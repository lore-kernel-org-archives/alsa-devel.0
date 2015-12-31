From: Owen Williams <owilliams@mixxx.org>
Subject: Regression in Traktor Audio10 driver (snd-usb-audio)
	mixer flags
Date: Thu, 31 Dec 2015 13:26:58 -0500
Message-ID: <1451586418.9097.8.camel@mixxx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E544265D01
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2015 19:27:01 +0100 (CET)
Received: by mail-qk0-f179.google.com with SMTP id p186so24006597qke.0
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2015 10:27:01 -0800 (PST)
Received: from [192.168.1.110] (c-66-31-35-94.hsd1.ma.comcast.net.
 [66.31.35.94])
 by smtp.gmail.com with ESMTPSA id n91sm24579106qkh.11.2015.12.31.10.26.58
 for <alsa-devel@alsa-project.org> (version=TLSv1/SSLv3 cipher=OTHER);
 Thu, 31 Dec 2015 10:26:58 -0800 (PST)
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

Sometime between kernels 3.13 (ubuntu 14.04) and 3.19 (15.04) there was
a regression that caused the mixer elements of the Traktor Audio10
driver to stop responding to changes to True.  I have an older machine
still running 14.04, and if I open alsamixer I can see and interact
with the 8 basic boolean switches:

numid=3,iface=MIXER,name='Direct Thru Channel A'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=4,iface=MIXER,name='Direct Thru Channel B'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=5,iface=MIXER,name='Direct Thru Channel C'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=6,iface=MIXER,name='Direct Thru Channel D'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=7,iface=MIXER,name='Phono Input Channel A'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=8,iface=MIXER,name='Phono Input Channel B'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=9,iface=MIXER,name='Phono Input Channel C'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=10,iface=MIXER,name='Phono Input Channel D'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off


or I can use amixer:
amixer -c T10 cset numid=8 on


however on my newer machine, with ubuntu 15.04 and 15.10, I am unable
to change the values to true.  I am a member of the audio group and I
have also tried with sudo, but when I try to set the value on nothing
happens:

$ amixer -c T10 cset numid=8 on
numid=8,iface=MIXER,name='Phono Input Channel B'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off

The fun part is, if I connect the card to my mac I can set startup
conditions for these flags.  I can set them to true, and when I connect
to my linux machines the flags start up as true.  And then, even on the
newer kernel, I can turn them off!  But I can't turn them back on
again.

This sound card is the one I'd like to recommend officially for the
Mixxx DJ project so I'd really like to get to the bottom of this issue.


thanks,
Owen Williams

A Lead Developer, Mixxx.org
