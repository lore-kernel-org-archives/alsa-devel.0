From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [Intel-gfx] Problems with HDMI audio on Intel
	DG45FC	motherboard
Date: Tue, 27 Oct 2009 17:08:08 +0800
Message-ID: <20091027090808.GA9088@localhost>
References: <20091011214513.GB12771@hardeman.nu>
	<20091014015455.GI13364@zhen-devel.sh.intel.com>
	<20091014020044.GA10032@localhost>
	<20091014174053.GA31149@hardeman.nu>
	<20091020012600.GA6548@localhost> <20091020224353.GA23186@csy.ca>
	<20091026231125.GA30634@hardeman.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CEA6243A9
	for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2009 10:08:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091026231125.GA30634@hardeman.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David =?utf-8?B?SMOkcmRlbWFu?= <david@hardeman.nu>, Shane W <shane-alsa@csy.ca>, alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2009 at 07:11:25AM +0800, David H=C3=A4rdeman wrote:
> On Tue, Oct 20, 2009 at 03:43:53PM -0700, Shane W wrote:
> > On Tue, Oct 20, 2009 at 09:26:00AM +0800, Wu Fengguang wrote:
> > > HDMI codec/sink seem to take some time to response to the output
> > > enable and new infoframe, so there are some delay. I've moved the H=
DMI
> > > output enable command to module load time, this helps. The infofram=
e
> > > is in theory created in run time based on the format of _each_ new
> > > audio stream, so infoframe transmission has to be started/stopped
> > > for each track..
> >=20
> > I know this has come up before but can't we not start/stop
> > the infoframe if the sample format on the new track is the
> > same as the old. I mean playing an album, you're gonna get
> > 44100, 2ch s16le 95% of the time so that would atleast
> > cause the problem to appear much less.
>=20
> Tried it, still had the second-track-produces-silence bug on my receive=
r=20
> so I couldn't test it properly.
>=20
> I however did manage to create a different patch which fixed my receive=
r=20
> bug (yay!)...by sending "refer-to-stream-header" audio infoframes from=20
> pcm close to pcm open...something like this quick hack:

This is an important clue, thank you! :)

The patch is not quite logical. Hopefully the sticky infoframe patch
can help in the same way.

Attached is the broken up patches, hope that helps your debugging.
The last 4 patches in the series are inspired by your comments.

Thanks,
Fengguang

>=20
> --- linux-2.6.32-rc5/sound/pci/hda/patch_intelhdmi.c	2009-10-16 02:41:5=
0.000000000 +0200
> +++ ../linux-2.6.32-rc5/sound/pci/hda/patch_intelhdmi.c	2009-10-26 23:3=
9:54.000000000 +0100
> @@ -552,8 +552,16 @@
>  					 struct snd_pcm_substream *substream)
>  {
>  	struct intel_hdmi_spec *spec =3D codec->spec;
> +	struct hdmi_audio_infoframe ai =3D {
> +		.type		=3D 0x84,
> +		.ver		=3D 0x01,
> +		.len		=3D 0x0a,
> +		.CC02_CT47	=3D 0x00,
> +	};
> =20
>  	hdmi_stop_infoframe_trans(codec);
> +	hdmi_fill_audio_infoframe(codec, &ai);
> +	hdmi_start_infoframe_trans(codec);
> =20
>  	return snd_hda_multi_out_dig_close(codec, &spec->multiout);
>  }
> @@ -571,6 +579,7 @@
> =20
>  	hdmi_set_channel_count(codec, substream->runtime->channels);
> =20
> +	hdmi_stop_infoframe_trans(codec);
>  	hdmi_setup_audio_infoframe(codec, substream);
> =20
>  	return 0;
>=20
>=20
> Not sure how/if something like that could be turned into an acceptable=20
> patch though...
>=20
> --=20
> David H=C3=A4rdeman

--8t9RHnE3ZwKMSgU+
Content-Type: application/x-gtar
Content-Disposition: attachment; filename="intel-hdmi-2009-10-27.tgz"
Content-Transfer-Encoding: base64

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
J06cOHHixIkTJ88l/wNJFGQ7APAAAA==

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8t9RHnE3ZwKMSgU+--
