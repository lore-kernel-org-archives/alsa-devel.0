From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [Intel-gfx] Problems with HDMI audio on Intel
 DG45FC motherboard
Date: Tue, 27 Oct 2009 00:11:25 +0100
Message-ID: <20091026231125.GA30634@hardeman.nu>
References: <20091011214513.GB12771@hardeman.nu>
	<20091014015455.GI13364@zhen-devel.sh.intel.com>
	<20091014020044.GA10032@localhost>
	<20091014174053.GA31149@hardeman.nu>
	<20091020012600.GA6548@localhost> <20091020224353.GA23186@csy.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-user-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20091020224353.GA23186@csy.ca>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Shane W <shane-alsa@csy.ca>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 20, 2009 at 03:43:53PM -0700, Shane W wrote:
> On Tue, Oct 20, 2009 at 09:26:00AM +0800, Wu Fengguang wrote:
> > HDMI codec/sink seem to take some time to response to the output
> > enable and new infoframe, so there are some delay. I've moved the HDMI
> > output enable command to module load time, this helps. The infoframe
> > is in theory created in run time based on the format of _each_ new
> > audio stream, so infoframe transmission has to be started/stopped
> > for each track..
> =

> I know this has come up before but can't we not start/stop
> the infoframe if the sample format on the new track is the
> same as the old. I mean playing an album, you're gonna get
> 44100, 2ch s16le 95% of the time so that would atleast
> cause the problem to appear much less.

Tried it, still had the second-track-produces-silence bug on my receiver =

so I couldn't test it properly.

I however did manage to create a different patch which fixed my receiver =

bug (yay!)...by sending "refer-to-stream-header" audio infoframes from =

pcm close to pcm open...something like this quick hack:


--- linux-2.6.32-rc5/sound/pci/hda/patch_intelhdmi.c	2009-10-16 02:41:50.00=
0000000 +0200
+++ ../linux-2.6.32-rc5/sound/pci/hda/patch_intelhdmi.c	2009-10-26 23:39:54=
.000000000 +0100
@@ -552,8 +552,16 @@
 					 struct snd_pcm_substream *substream)
 {
 	struct intel_hdmi_spec *spec =3D codec->spec;
+	struct hdmi_audio_infoframe ai =3D {
+		.type		=3D 0x84,
+		.ver		=3D 0x01,
+		.len		=3D 0x0a,
+		.CC02_CT47	=3D 0x00,
+	};
 =

 	hdmi_stop_infoframe_trans(codec);
+	hdmi_fill_audio_infoframe(codec, &ai);
+	hdmi_start_infoframe_trans(codec);
 =

 	return snd_hda_multi_out_dig_close(codec, &spec->multiout);
 }
@@ -571,6 +579,7 @@
 =

 	hdmi_set_channel_count(codec, substream->runtime->channels);
 =

+	hdmi_stop_infoframe_trans(codec);
 	hdmi_setup_audio_infoframe(codec, substream);
 =

 	return 0;


Not sure how/if something like that could be turned into an acceptable =

patch though...

-- =

David H=E4rdeman

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
