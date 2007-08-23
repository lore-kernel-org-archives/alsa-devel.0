From: stan <stanl@cox.net>
Subject: Unable to open plughw:0,0 from user program.
Date: Thu, 23 Aug 2007 11:44:56 -0700
Message-ID: <46CDD5A8.3000006@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao104.cox.net (fed1rmmtao104.cox.net [68.230.241.42])
	by alsa0.perex.cz (Postfix) with ESMTP id A527324357
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Aug 2007 20:44:58 +0200 (CEST)
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao104.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP id
	<20070823184457.UNEP13288.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>
	for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2007 14:44:57 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am unable to use plughw:0,0 as a device string while calling
err = snd_pcm_open (&alsa_dev, hw_from_default, SND_PCM_STREAM_PLAYBACK, 0);

The same call works with hw_from_default == 'default', but fails when it 
is 'plughw:0,0'.
The error is
cannot open audio device "plughw:0,0" (Device or resource busy)

I am using the latest snapshot of alsa-lib, alsa-lib20070821.  I tried 
debugging but I cannot trace through the macros.  As near as I can tell 
there have been no changes to alsa.conf, and this worked just fine 
before the latest upgrade alsa package alsa-lib.1.0.14-3

Is this a deliberate change in alsa that is known about, and is there a 
way to still get the functionality?

Thanks.
