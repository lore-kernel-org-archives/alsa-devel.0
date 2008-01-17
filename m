From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: S16_LE + softvol = bad
Date: Thu, 17 Jan 2008 18:40:27 +0500
Message-ID: <fmnlt1$g5m$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id D01A124378
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 14:41:00 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JFUzG-0002Zo-K3
	for alsa-devel@alsa-project.org; Thu, 17 Jan 2008 13:40:54 +0000
Received: from 90.151.107.193 ([90.151.107.193])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 13:40:54 +0000
Received: from patrakov by 90.151.107.193 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 13:40:54 +0000
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

Hello developers,

some cards (most notably, Intel HD audio) have the PCM control as softvol, and 
default to S16_LE as a format for dmix. Since softvol is configured to attenuate 
signal, and not many people set this control to 100% (especially those who have 
no other volume controls), this effectively leaves less than 16 bits per sample.

The card can surely produce sound of better quality in most cases, if one 
changes defaults.pcm.dmix.format in ~/.asoundrc. However, one should now search 
a lot of forums in order to know about this setting. Not everyone does this, and 
not everyone is even able to diagnose the "noisy sound in Linux" problem 
properly as "too few bits per sample in the default configuration". A much 
better situation would be if ALSA defaulted to good quality (i.e.: S24_LE or 
S32_LE on all cards that require softvol and support this sample format). Could 
you please change the files in /usr/share/alsa/cards accordingly?

-- 
Alexander E. Patrakov
