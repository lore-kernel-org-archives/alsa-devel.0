From: Aurelien Bouin <a_bouin@yahoo.fr>
Subject: iMX6 ESAI TDM with underrun and overrun support
Date: Wed, 17 Dec 2014 15:13:43 +0000 (UTC)
Message-ID: <1758576875.330121.1418829223072.JavaMail.yahoo@jws11142.mail.ir2.yahoo.com>
Reply-To: Aurelien Bouin <a_bouin@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm39-vm6.bullet.mail.ir2.yahoo.com
 (nm39-vm6.bullet.mail.ir2.yahoo.com [212.82.97.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FB082605E3
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 16:13:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,
I am currently working on an iMX6 board, I work with the master branch of git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
I have seen some problems in the freescale ESAI implementation :

1.The registers TCCR and RCCR have TFP and RFP bits in register of a width of 5, not 4 !
With a value of 5 we are able to use the full range of slots (32)
Patch : http://pastebin.com/Ai1RZ9mE
2.The channels number are limited in Playback to 12, but actually we can rise 128, in Capture it is limited to 8 but actually we can rise 128 also

Patch : http://pastebin.com/SHk5eHPa

I use the iMX6 ESAI bus to send audio datas to other processors ... but actually I don't have any codec behind ...
I am wondering if there is any solution with the devicetree to implement such configuration with "simple-audio-card"

Because for the moment I have not find another solution than doing a module : http://pastebin.com/cnGwnEjn

I also see that the chip errata of the iMX6 ERR008000 is not handle ...Which make channel swapping on my ESAI bus ...
Is there someone that succeed in implementing the underrun overrun catch ?

Thank you for your return,

Regards
Aurelien BOUIN
