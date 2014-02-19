From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: About 'SNDRV_PCM_CLASS_MULTI' for devices with
	multi-channels
Date: Thu, 20 Feb 2014 01:59:04 +0900
Message-ID: <1392829144-26291-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id E57B32656BA
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 17:59:11 +0100 (CET)
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

Hi all,

I have two questions about the usage of this macro.

Should I use this macro for new drivers which I'm working for?'
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/071820.html

My drivers support some firewire devices, which is desinged for studio-use and have many channels. Its combination of channels are not designed for surround sound like 5.1ch.

Just judging from its name, 'SNDRV_PCM_CLASS_MULTI', I should use this.
But there are no drivers which use this macro in current tree, against my expectation that some drivers (ICE1712-pro, RME9652, 6fire usb and so on) should use this macro.

Are there any reasons?


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
