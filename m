From: Takashi Sakamoto <mocchi.sakamoto113@gmail.com>
Subject: About 'SNDRV_PCM_CLASS_MULTI' for devices with
	multi-channels
Date: Thu, 20 Feb 2014 01:41:46 +0900
Message-ID: <5304DECA.30006@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f65.google.com (mail-pa0-f65.google.com
 [209.85.220.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 36742265670
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 17:42:00 +0100 (CET)
Received: by mail-pa0-f65.google.com with SMTP id kq14so367721pab.8
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 08:41:59 -0800 (PST)
Received: from [192.168.100.117] (e0109-106-188-242-244.uqwimax.jp.
 [106.188.242.244])
 by mx.google.com with ESMTPSA id n6sm2156825pbj.22.2014.02.19.08.41.57
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 19 Feb 2014 08:41:58 -0800 (PST)
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

My drivers support some firewire devices, which is desinged for 
studio-use and have many channels. Its combination of channels are not 
designed for surround sound like 5.1ch.

Just judging from its name, 'SNDRV_PCM_CLASS_MULTI', I should use this.
But there are no drivers which use this macro in current tree, against 
my expectation that some drivers (ICE1712-pro, RME9652, 6fire usb and so 
on) should use this macro.

Are there any reasons?


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
