From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd-hda-intel acl269 toshiba r700 speakers work,
	headphones do not
Date: Tue, 20 Jul 2010 17:06:52 +0800
Message-ID: <AANLkTin4oysFCoXPqW_-d1YT6yMJScosNw-h7cYPIXoY@mail.gmail.com>
References: <4C41F914.5040508@gmail.com> <1279527456.3803.1.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 29F621038DE
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 11:06:53 +0200 (CEST)
Received: by vws9 with SMTP id 9so5760638vws.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2010 02:06:52 -0700 (PDT)
In-Reply-To: <1279527456.3803.1.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/19 Paul Menzel <paulepanter@users.sourceforge.net>

> Dear Thomas,
>
>
> Am Samstag, den 17.07.2010, 11:40 -0700 schrieb Thomas Hoffmann:
>
> > Sound works from the built in laptop speakers. When headphones are
> > plugged in, the speakers properly mute, but there is no sound coming
> > from the headphones. I've tried some of the options to the
> > alsa-base.conf file to no avail; generally they made it so sound came
> > out of the speakers always, even when headphones were plugged in.
> >
> > I previously sent an e-mail to this list server:
> >      https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5064
> > where they suggested I e-mail you. My system info is available from
> >
> >
> http://www.alsa-project.org/db/?f=f9aaf6e43b669cf2c4b2215781a414b12843e2a3
>
> did you already try different values for the `model` parameter [1]?
>
>
> Thanks,
>
> Paul
>
>
ALC269 does not has node 0x24

The last node is 0x23

Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80]
  Connection: 6
     0x18 0x19 0x1a 0x1b 0x1d 0x0b




[ 18.731733] hda_codec: ALC269: BIOS auto-probing.
[ 18.731930] hda_codec: connection list not available for 0x24

"connection list not available for" is printed by hda_get_connections()

The functions in patch_realtek.c which called hda_get_connections() are
get_connection_index() and fillup_priv_adc_nids() for alc269
