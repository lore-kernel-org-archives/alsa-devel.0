From: William Estrada <MrUmunhum@popdial.com>
Subject: snd_pcm_hw_param_any returns bad data
Date: Sat, 06 Sep 2008 10:52:31 -0700
Message-ID: <48C2C35F.8060001@popdial.com>
Reply-To: MrUmunhum@popdial.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MAIL02.inside.adbasesystems.com (mail.1dial.com [64.136.164.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 1717124426
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Sep 2008 19:52:31 +0200 (CEST)
Received: from [10.1.1.50] (64.124.13.3.gatespeed.com [64.124.13.3]) by
	MAIL02.inside.adbasesystems.com
	(Vircom SMTPRS 4.5.654.13) with ESMTP id
	<B0594567845@MAIL02.inside.adbasesystems.com> for
	<alsa-devel@alsa-project.org>; Sat, 6 Sep 2008 13:52:27 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi group,

  I'm using snd_pcm_hw_param_any to retrieve the parameters from an 
opened device
and I'm getting garbage back in the structures. My code is here: 
http://64.124.13.3/_ALSA_/
This is a simple test to show the problem. The output is shown in 
show.txt. as you can see the
before ( within the open function ) is much different than the after.

  I am assuming that it is my code that has the problem, any ideas???

  Thanks for your time.

-- 
William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum
