From: John Lindgren <john.lindgren@tds.net>
Subject: snd_pcm_drop causing lockup with DMix
Date: Sun, 28 Feb 2010 10:37:21 -0500
Message-ID: <1267371441.14748.22.camel@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2EA3824437
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 16:37:26 +0100 (CET)
Received: by gyf2 with SMTP id 2so729725gyf.38
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 07:37:25 -0800 (PST)
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
List-Id: alsa-devel@alsa-project.org

Hi,

A couple of weeks ago I reported a rather serious bug #4914 that can
cause a multi-threaded using ALSA to lock up so that it can only be
ended with SIGKILL.

I maintain the ALSA output part of Audacious, and I need to be able to
play audio in one thread of the program and then signal that thread to
stop from another.  The way to do this in ALSA, if I understand
correctly, is to interrupt the thread that is sending audio with a call
to snd_pcm_drop.  But using DMix makes the first thread hang up in a
snd_pcm_wait call with a timeout of -1.

Is anyone working on this bug?  Is there any more help I can provide?

John Lindgren
