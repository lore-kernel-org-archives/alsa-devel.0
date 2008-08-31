From: William Estrada <MrUmunhum@popdial.com>
Subject: snd_pcm_avail_update does not return until I have
	32768 bytes ready
Date: Sun, 31 Aug 2008 14:09:52 -0700
Message-ID: <48BB08A0.6020409@popdial.com>
Reply-To: MrUmunhum@popdial.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MAIL02.inside.adbasesystems.com (mail.1dial.com [64.136.164.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 340FF245CC
	for <alsa-devel@alsa-project.org>;
	Sun, 31 Aug 2008 23:10:04 +0200 (CEST)
Received: from [10.1.1.50] (64.124.13.3.gatespeed.com [64.124.13.3]) by
	MAIL02.inside.adbasesystems.com
	(Vircom SMTPRS 4.5.654.13) with ESMTP id
	<B0591273044@MAIL02.inside.adbasesystems.com> for
	<alsa-devel@alsa-project.org>; Sun, 31 Aug 2008 17:10:01 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi group,

  I am having a little problem with ALSA. My problem is that 
snd_pcm_readi does not return
until i have 32768 bytes available. I want to get an interrupt back when 
I have 80 bytes
( 1/100 of a second ). This delay is about 4.09 seconds which is much 
too long to want.

  My question is how do I tell ALSA to return from snd_pcm_avail_update 
when I have
80 bytes ready to read?

-- 
William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum
