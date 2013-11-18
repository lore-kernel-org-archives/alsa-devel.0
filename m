From: Oleksij Rempel <linux@rempel-privat.de>
Subject: internal mic boost: how much is too much?
Date: Mon, 18 Nov 2013 15:51:01 +0100
Message-ID: <528A2955.5060303@rempel-privat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by alsa0.perex.cz (Postfix) with ESMTP id B304B260309
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2013 15:51:02 +0100 (CET)
Received: from [192.168.1.138] ([93.218.98.132]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0LaGfK-1VGTTk1ZoE-00m24z for
 <alsa-devel@alsa-project.org>; Mon, 18 Nov 2013 15:51:02 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello all,

i have two laptops with internal dmic, each of them has 3 step mic
boost. One step 12 dB. The third step seems to me useless, since it give
more noise then sound.
I know there is code in patch_reatek.c to disable two steps.
But before i provide some patch, it will be interesting to know, how
much noise is too much? What is the best way to measure it?
Do i need some tools like this?
http://www.conrad.de/ce/de/product/100804/VOLTCRAFT-SL-100-Schallpegel-Messgeraet-Laerm-Messgeraet-315-Hz-8-kHz?ref=list

-- 
Regards,
Oleksij
