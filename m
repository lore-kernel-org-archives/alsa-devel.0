From: William Estrada <MrUmunhum@popdial.com>
Subject: alsa callback not async - Second post to this list
Date: Sun, 14 Sep 2008 13:16:54 -0700
Message-ID: <48CD7136.7070702@popdial.com>
Reply-To: MrUmunhum@popdial.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MAIL02.inside.adbasesystems.com (mail.1dial.com [64.136.164.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E4671037E3
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Sep 2008 14:46:07 +0200 (CEST)
Received: from [10.1.1.50] (64.124.13.3.gatespeed.com [64.124.13.3]) by
	MAIL02.inside.adbasesystems.com
	(Vircom SMTPRS 4.5.654.13) with ESMTP id
	<B0599343604@MAIL02.inside.adbasesystems.com> for
	<alsa-devel@alsa-project.org>; Sun, 14 Sep 2008 16:16:59 -0400
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

Hi guys,

  I am cross posting this because I am not sure which list it belongs to.

  I have a test program I wrote to help me learn ALSA APIs, It work to a 
degree. It is a
simple Capture/Playback interface. My problem is that when the Callback 
starts, it
does not allow any cycles back to the main program. The main program 
waits for console
input to tell the callback when to stop. Well it does not accept any 
console input when
the callback is running. Any ideas??

  The source is here: http://64.124.13.3/_ALSA_/Echo/

-- 
William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum
