From: Jan-Simon =?iso-8859-1?q?M=F6ller?= <dl9pf@gmx.de>
Subject: Re: PCM Volume on FSC V5505
Date: Thu, 29 Nov 2007 16:02:09 +0100
Message-ID: <200711291602.10082.dl9pf@gmx.de>
References: <200711231745.21199.dl9pf@gmx.de> <s5h63znk95v.wl%tiwai@suse.de>
	<s5h4pf7k90j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 78EB024448
	for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2007 16:02:12 +0100 (CET)
In-Reply-To: <s5h4pf7k90j.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The levels were  0-43 on Master and PCM.
When PCM was over 20 it sounded ugly.
Your patch fixed it with PCM. =

Master now 0-43, PCM now 0-20 .
What about the inputs are they affected before/after the patch ?

Many thanks !

Best regards
Jan-Simon


Am Dienstag 27 November 2007 16:23:08 schrieb Takashi Iwai:
> At Tue, 27 Nov 2007 16:19:56 +0100,
>
> I wrote:
> > At Fri, 23 Nov 2007 17:45:21 +0100,
> >
> > Jan-Simon M=F6ller wrote:
> > > Hi !
> > > With the patches, the sound works - well done!
> > > But I need to make sure the PCM volume is max @ 50% .
> > > If its over 50% sound is clipped and ugly (overload?).
> >
> > Looks like so.  Mixer apps (e.g. alsamixer) can show its dB value
> > instead of percent.  Check the dB level shown there.
> >
> > The patch below may fix this issue.  Give it a try.
>
> Argh, the patch is wrong.  Use the below instead.
>
>
> Takashi
>
> diff -r 17223a4918b4 pci/hda/patch_conexant.c
> --- a/pci/hda/patch_conexant.c	Tue Nov 27 15:27:17 2007 +0100
> +++ b/pci/hda/patch_conexant.c	Tue Nov 27 16:50:37 2007 +0100
> @@ -826,6 +826,17 @@ static int patch_cxt5045(struct hda_code
>  		spec->init_verbs[0] =3D cxt5045_test_init_verbs;
>  #endif
>  	}
> +
> +	/*
> +	 * Fix max PCM level to 0 dB
> +	 * (originall it has 0x2b steps with 0dB offset 0x14)
> +	 */
> +	snd_hda_override_amp_caps(codec, 0x17, HDA_INPUT,
> +				  (0x14 << AC_AMPCAP_OFFSET_SHIFT) |
> +				  (0x14 << AC_AMPCAP_NUM_STEPS_SHIFT) |
> +				  (0x05 << AC_AMPCAP_STEP_SIZE_SHIFT) |
> +				  (1 << AC_AMPCAP_MUTE_SHIFT));
> +
>  	return 0;
>  }
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



-- =

Jan-Simon M=F6ller
Schaumburgstra=DFe 2
30419 Hannover

+49 511 2700750
+49 177 3017915
