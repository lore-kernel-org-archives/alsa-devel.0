From: william estrada <MrUmunhum@popdial.com>
Subject: short writes?
Date: Sun, 30 Sep 2007 11:47:37 -0700
Message-ID: <46FFEF49.6070909@popdial.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MAIL02.inside.adbasesystems.com (mail.1dial.com [64.136.164.73])
	by alsa0.perex.cz (Postfix) with ESMTP id B5BD0243BC
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Sep 2007 20:47:19 +0200 (CEST)
Received: from laptop.mt-umunhum-wireless.net (64.124.13.3.gatespeed.com
	[64.124.13.3]) by MAIL02.inside.adbasesystems.com
	(Vircom SMTPRS 4.4.568.54) with ESMTP id
	<B0402559911@MAIL02.inside.adbasesystems.com> for
	<alsa-devel@alsa-project.org>; Sun, 30 Sep 2007 14:47:15 -0400
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

Hi group,

   I have written my own ALSA recorder and player.  Along with that I have
several bugs. The bug I am working on right now is 'short writes' when I
use the pipe command into my player.  My player runs and asks for the file
to play, so that I may play incoming files as they are sent in.  I have
a program that uses 'inotify' to watch for incoming file and then pipe
the file name into my player.

   Now with all of that, is there a API call that will put the writei into
blocking mode?  Or an API call that will flush the output from writei? Or
any other suggestions?

   Thanks for your time.

-- 
William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum
