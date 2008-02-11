From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: PATCH: remove duplicate controls in alc268 test
Date: Mon, 11 Feb 2008 10:37:20 +1030 (CST)
Message-ID: <200802110007.m1B07Kwt004648@turbo.physics.adelaide.edu.au>
References: <47AC59C0.9080709@harddisk.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 8941010387A
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 01:07:25 +0100 (CET)
In-Reply-To: <47AC59C0.9080709@harddisk.is-a-geek.org> from "Marco Schuster"
	at Feb 08, 2008 02:31:44 PM
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marco Schuster <marco@harddisk.is-a-geek.org>
Cc: alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Marco wrote:
> when these four things are missing, alsamixer fails to load, and KMix 
> outputs garbage controls here.
> Would be interesting if other users experience the same.

Why would this be?  These controls are just duplicates of others present
elsewhere in the test mixer structure.  To facilitate the use of the test
mixer it is the "LOUT1 Playback Volume" etc names which should be used which
is why the patch removes the "Front Playback Volume" etc entries.

Does alsamixer/kmix assume that there will always be controls named
"Headphone Playback Volume" and "Front Playback Volume" and crash badly if
they don't exist?  That seems a little odd.

Regards
  jonathan

> > Hi guys
> > 
> > I've just noticed that there are a handful of duplicate controls in the
> > ALC268 test model mixer.  This patch (against alsa-driver 1.0.16) removes
> > them.
> > 
> > Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
> > 
> > --- patch_realtek.c-orig	2008-02-05 19:53:24.000000000 +1030
> > +++ patch_realtek.c	2008-02-08 09:23:02.000000000 +1030
> > @@ -9834,11 +9834,6 @@
> >  
> >  #ifdef CONFIG_SND_DEBUG
> >  static struct snd_kcontrol_new alc268_test_mixer[] = {
> > -	HDA_CODEC_VOLUME("Front Playback Volume", 0x2, 0x0, HDA_OUTPUT),
> > -	HDA_CODEC_MUTE("Front Playback Switch", 0x14, 0x0, HDA_OUTPUT),
> > -	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x3, 0x0, HDA_OUTPUT),
> > -	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
> > -
> >  	/* Volume widgets */
> >  	HDA_CODEC_VOLUME("LOUT1 Playback Volume", 0x02, 0x0, HDA_OUTPUT),
> >  	HDA_CODEC_VOLUME("LOUT2 Playback Volume", 0x03, 0x0, HDA_OUTPUT),
