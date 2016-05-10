From: Jochen Henneberg <jh@henneberg-systemdesign.com>
Subject: Re: bug: reconfig broken on kernel 4.5
Date: Tue, 10 May 2016 11:47:56 +0200
Message-ID: <1462873676.10277.16.camel@maxwell>
References: <1462782169.3239.12.camel@maxwell>
 <s5hlh3jpbh9.wl-tiwai@suse.de> <s5h4ma6b985.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EC528265AA1
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 11:47:57 +0200 (CEST)
Received: from [192.168.0.100] ([109.47.2.107]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPSA (Nemesis) id 0Mbb9R-1bIYae1Sr7-00J3Gk for
 <alsa-devel@alsa-project.org>; Tue, 10 May 2016 11:47:57 +0200
In-Reply-To: <s5h4ma6b985.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Di, 2016-05-10 at 10:36 +0200, Takashi Iwai wrote:
> On Mon, 09 May 2016 16:11:46 +0200,
> Takashi Iwai wrote:
> > 
> > On Mon, 09 May 2016 10:22:49 +0200,
> > Jochen Henneberg wrote:
> > > 
> > > Hi,
> > > 
> > > it looks as if 'reconfig' feature is broken since the sysfs attributes
> > > have been moved to device attributes. In hda_sysfs.c:reconfig_codec()
> > > the device is cleared with snd_hda_codec_reset() which calls
> > > snd_hdac_device_unregister() which removes the sysfs entries (including
> > > the currently in-use 'reconfig'), the re-registration fails afterwards
> > > in snd_hda_codec_build_controls().
> > > I am not sure when things got broken, but snd_hda_codec_reset()
> > > called from reconfig_codec() unregisters the device and removes the
> > > sysfs entries where in the past it only stripped all configurations
> > > (pcms, controls ...) from the device.
> > 
> > Hrm, OK, something got broken indeed there.  I'll check it later.
> 
> Actually it's not about the sysfs, but rather the superfluous calls of
> snd_hda_codec_build_controls() & co.  The fix patch is below.
> 

Sorry for the confusion, I did not notice. Anyway, I have tested the
patch with 4.5, changed codec hints, reconfig and no error messages and
the changed hints have been respected after reconfig, looks good for me.

Jochen

> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Fix broken reconfig
> 
> The HD-audio reconfig function got broken in the recent kernels,
> typically resulting in a failure like:
>   snd_hda_intel 0000:00:1b.0: control 3:0:0:Playback Channel Map:0 is already present
> 
> This is because of the code restructuring to move the PCM and control
> instantiation into the codec drive probe, by the commit [bcd96557bd0a:
> ALSA: hda - Build PCMs and controls at codec driver probe].  Although
> the commit above removed the calls of snd_hda_codec_build_pcms() and
> *_build_controls() at the controller driver probe, the similar calls
> in the reconfig were still left forgotten.  This caused the
> conflicting and duplicated PCMs and controls.
> 
> The fix is trivial: just remove these superfluous calls from
> reconfig_codec().
> 
> Fixes: bcd96557bd0a ('ALSA: hda - Build PCMs and controls at codec driver probe')
> Reported-by: Jochen Henneberg <jh@henneberg-systemdesign.com>
> Cc: <stable@vger.kernel.org> # v4.1+
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_sysfs.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_sysfs.c b/sound/pci/hda/hda_sysfs.c
> index 64e0d1d81ca5..9739fce9e032 100644
> --- a/sound/pci/hda/hda_sysfs.c
> +++ b/sound/pci/hda/hda_sysfs.c
> @@ -141,14 +141,6 @@ static int reconfig_codec(struct hda_codec *codec)
>  	err = snd_hda_codec_configure(codec);
>  	if (err < 0)
>  		goto error;
> -	/* rebuild PCMs */
> -	err = snd_hda_codec_build_pcms(codec);
> -	if (err < 0)
> -		goto error;
> -	/* rebuild mixers */
> -	err = snd_hda_codec_build_controls(codec);
> -	if (err < 0)
> -		goto error;
>  	err = snd_card_register(codec->card);
>   error:
>  	snd_hda_power_down(codec);

-- 
Henneberg - Systemdesign
Jochen Henneberg
Loehnfeld 26
21423 Winsen (Luhe)
--
Fon: +49 4174 668 773
Mobile: +49 172 160 14 69
Fax: +49 321 210 761 64
www: www.henneberg-systemdesign.com
