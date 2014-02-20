From: Takashi Sakamoto <mocchi.sakamoto113@gmail.com>
Subject: Re: About 'SNDRV_PCM_CLASS_MULTI' for devices with
	multi-channels
Date: Thu, 20 Feb 2014 11:28:48 +0900
Message-ID: <53056860.7090500@sakamocchi.jp>
References: <5304C64D.3090400@sakamocchi.jp> <530508BB.6060802@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f196.google.com (mail-pd0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 79090265607
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:29:04 +0100 (CET)
Received: by mail-pd0-f196.google.com with SMTP id y10so563969pdj.11
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 18:29:03 -0800 (PST)
In-Reply-To: <530508BB.6060802@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi David,
(My message was not delivered by ALSA's mailman...)

Again all,

 >> I have two questions about the usage of this macro.
 >>
 >> Should I use this macro for new drivers which I'm working for?'
 >> 
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/071820.html
 >>
 >>
 >> My drivers support some firewire devices, which is desinged for
 >> studio-use and have many channels. Its combination of channels are not
 >> designed for surround sound like 5.1ch.
 >>
 >> Just judging from its name, 'SNDRV_PCM_CLASS_MULTI', I should use this.
 >> But there are no drivers which use this macro in current tree, against
 >> my expectation that some drivers (ICE1712-pro, RME9652, 6fire usb and so
 >> on) should use this macro.
 >>
 >> Are there any reasons?

In current tree, there are no drivers which uses this macro.

As long as I investigated in ftp server, this macro is firstly added in 
ALSA 0.9.0beta1 (2001/02/21). So this macro has been ignored over 10 
years...


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
