From: Olivier Langlois <olivier@trillion01.com>
Subject: Controlling the cards order
Date: Thu, 06 Mar 2014 12:42:14 -0500
Message-ID: <1394127734.15237.20.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy18-pub.mail.unifiedlayer.com
 (oproxy18-pub.mail.unifiedlayer.com [69.89.17.20])
 by alsa0.perex.cz (Postfix) with SMTP id 40D67265467
 for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2014 18:42:23 +0100 (CET)
Received: from [173.179.63.169] (port=37059 helo=[192.168.1.150])
 by box610.bluehost.com with esmtpsa (SSLv3:RC4-SHA:128) (Exim 4.80)
 (envelope-from <olivier@trillion01.com>) id 1WLcJE-00049Q-VF
 for alsa-devel@alsa-project.org; Thu, 06 Mar 2014 10:42:17 -0700
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

Hi,

I have added a second sound device in my system and it unexpectedly took
the first card slot.

I have found that it is easy to control the order as long as the devices
use different drivers by modifying

/etc/modprobe.d/alsa.conf

( http://alsa.opensrc.org/MultipleCards )

but in my situation I have 2 different devices using the same driver. I
think that there is hope that I find an answer by digging the more
general topic of ordering PCI devices drivers loading but if someone has
few pointers to share, any help is welcome!

Here are my 2 devices that I would like to change the order:

lano1106@whippet2 /proc/asound $ cat cards
 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xfbf20000 irq 84
 1 [HDMI           ]: HDA-Intel - HDA ATI HDMI
                      HDA ATI HDMI at 0xfbe60000 irq 88

thank you for your time,
Olivier
