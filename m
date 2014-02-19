From: Takashi Sakamoto <mocchi.sakamoto113@gmail.com>
Subject: About 'SNDRV_PCM_CLASS_MULTI' for devices with
	multi-channels
Date: Thu, 20 Feb 2014 02:17:23 +0900
Message-ID: <5304E723.3090103@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f67.google.com (mail-pa0-f67.google.com
 [209.85.220.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 5970C265AFD
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 18:17:28 +0100 (CET)
Received: by mail-pa0-f67.google.com with SMTP id rd3so391574pab.6
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 09:17:26 -0800 (PST)
Received: from [192.168.100.117] (e0109-106-188-242-244.uqwimax.jp.
 [106.188.242.244])
 by mx.google.com with ESMTPSA id sx8sm5537323pab.5.2014.02.19.09.17.24
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 19 Feb 2014 09:17:25 -0800 (PST)
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
