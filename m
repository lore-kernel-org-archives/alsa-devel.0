From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] ALSA: hda - Avoid outputting HDMI audio
 before prepare() and after close()
Date: Sat, 16 Feb 2013 22:59:40 +0200
Message-ID: <511FF33C.6050709@iki.fi>
References: <511EEDB0.6010603@iki.fi>
 <1361032822-4041-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw-out2.cc.tut.fi (mail-gw-out2.cc.tut.fi [130.230.160.33])
 by alsa0.perex.cz (Postfix) with ESMTP id B159C2615D6
 for <alsa-devel@alsa-project.org>; Sat, 16 Feb 2013 21:59:41 +0100 (CET)
In-Reply-To: <1361032822-4041-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

16.02.2013 18:40, Anssi Hannula kirjoitti:
> Some HDMI codecs (at least NVIDIA 0x10de000b:0x10de0101:0x100100) start
> transmitting an empty audio stream as soon as PIN_OUT and AC_DIG1_ENABLE
> are enabled.
> 
> Since commit 6169b673618bf0b2518ce413b54925782a603f06 ("ALSA: hda -
> Always turn on pins for HDMI/DP") this happens at first open() time, and
> will continue even after close().
> 
> Additionally, some codecs (at least Intel PantherPoint HDMI) currently
> continue transmitting HDMI audio even after close() in case some actual
> audio was output after open() (this happens regardless of PIN_OUT).
> 
> Empty HDMI audio transmission when not intended has the effect that a
> possible HDMI audio sink/receiver may prefer the empty HDMI audio stream
> over an actual audio stream on its S/PDIF inputs.
> 
> To avoid the issue before first prepare(), set stream format to 0 on
> codec initialization. 0 is not a valid format value for HDMI and will
> prevent the audio stream from being output.
> 
> Additionally, at close() time, make sure that the stream is cleaned up.
> This will ensure that the format is reset to 0 at that time, preventing
> audio from being output in that case.
> 
> Thanks to OpenELEC developers and users for their help in investigating
> this issue on the affected NVIDIA "ION2" hardware, and for the initial
> bug report of the issue. Testing of the final version on NVIDIA ION2 was
> done by OpenELEC user "MrXIII". Testing on Intel PantherPoint was done
> by myself.
> 
> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> Cc: stable@vger.kernel.org
> ---
> 
> This also supersedes the patch I attached yesterday as it fixes both
> cases.
> 
> I guess the alternative to this approach would be to fiddle with
> AC_DIG1_ENABLE when preparing and closing the device, but with a quick
> look that seemed to be possibly more complex since AC_DIG1_ENABLE is
> already meddled with at quite a few places in hda_codec.c.

Hmm... actually, that would not be so much more complex, just making
sure AC_DIG1_ENABLE is off in hdmi_add_cvt() (by e.g. zeroing
AC_VERB_SET_DIGI_CONVERT_1) and making snd_hda_spdif_ctls_unassign()
call "set_spdif_ctls(codec, spdif->nid, 0, -1);".

However, it would still mean that just a simple snd_pcm_open() could
cause an empty stream to be output (if format is valid), since iec958
controls are assigned at open() time, and iec958 mute controls
AC_DIG1_ENABLE. Or we could add additional code in hda_codec.c to
prevent AC_DIG1_ENABLE being set if prepare() has not been called.


> WDYT, is this OK or should we try a AC_DIG1_ENABLE based approach or
> something else?
> 
> 
>  sound/pci/hda/patch_hdmi.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 807a2aa..bcb83c7 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1253,6 +1253,14 @@ static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
>  	if (err < 0)
>  		return err;
>  
> +	/*
> +	 * Some HDMI codecs (at least NVIDIA 0x10de000b:0x10de0101:0x100100)
> +	 * start transmitting an empty audio stream as soon as PIN_OUT and
> +	 * AC_DIG1_ENABLE are enabled, which happens at open() time.
> +	 * To avoid that, set format to 0, which is not valid for HDMI.
> +	 */
> +	snd_hda_codec_write(codec, cvt_nid, 0, AC_VERB_SET_STREAM_FORMAT, 0);
> +
>  	spec->num_cvts++;
>  
>  	return 0;
> @@ -1372,6 +1380,12 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
>  	struct hdmi_spec_per_pin *per_pin;
>  
>  	if (hinfo->nid) {
> +		/*
> +		 * Make sure no empty audio is output after this point by
> +		 * setting stream format to 0, which is not valid for HDMI.
> +		 */
> +		__snd_hda_codec_cleanup_stream(codec, hinfo->nid, 1);
> +
>  		cvt_idx = cvt_nid_to_cvt_index(spec, hinfo->nid);
>  		if (snd_BUG_ON(cvt_idx < 0))
>  			return -EINVAL;
> 


-- 
Anssi Hannula
