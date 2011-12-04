From: Peter Dunker <pdunker@gracenote.com>
Subject: Re: snd-usb-audio - NI Traktor 10 - phono settings -
 partly solved
Date: Sat, 3 Dec 2011 23:26:57 -0800
Message-ID: <46ECA1EC0460234BAE43D054B3738BDA068B04AA0B@GNMAILBOX.gracenote.gracenote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gracenote.com (pat.gracenote.com [209.10.41.94])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D9B8245D4
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 08:27:01 +0100 (CET)
Received: from [10.3.8.54] (helo=SCCAS01.gracenote.gracenote.com)
	by mail.gracenote.com with esmtp (Exim 4.42) id 1RX6TT-00070G-5r
	for alsa-devel@alsa-project.org; Sat, 03 Dec 2011 23:26:59 -0800
Content-Language: en-US
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

Hi Daniel,

I tried amixer contents, which looks like more info, but it was not obvious:
numid=1,iface=MIXER,name='Direct Thru Channel A'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=2,iface=MIXER,name='Direct Thru Channel B'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=3,iface=MIXER,name='Direct Thru Channel C'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=4,iface=MIXER,name='Direct Thru Channel D'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=5,iface=MIXER,name='Phono Input Channel A'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=6,iface=MIXER,name='Phono Input Channel B'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=7,iface=MIXER,name='Phono Input Channel C'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=8,iface=MIXER,name='Phono Input Channel D'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on


I used now 
amixer -c 1 numid=<1..8> off

and it worked! The channels are on line level now:
numid=1,iface=MIXER,name='Direct Thru Channel A'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=2,iface=MIXER,name='Direct Thru Channel B'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=3,iface=MIXER,name='Direct Thru Channel C'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=4,iface=MIXER,name='Direct Thru Channel D'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=5,iface=MIXER,name='Phono Input Channel A'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=6,iface=MIXER,name='Phono Input Channel B'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=7,iface=MIXER,name='Phono Input Channel C'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=8,iface=MIXER,name='Phono Input Channel D'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off


I have 2 problems left:
1) The amixer shows only 8, but the card has 10 channels. It might be no problem, as 2 channels were always line, but I have to double check, as soon as I have the card in hand (currently remote).
Any idea, in case the 9. and 10. channel are still phono, where and how to look to set these channels too.

2) When I connect 2 cards, how can I for sure discriminate which is which and assign certain plugins in asoundrc to a specific one. I plan to use more then one T10. I read people use the name of the card to avoid confusion, but they have no wall the same name.
The problem is that the order of card numbers is given by the order the cards are connected and its not clear what happens when reboot, maybe every time something different.

Any idea, how I could define for sure, which one is which one? Maybe with a serial number, but I haven't seen one.

Thanks,
Peter


Message: 5
Date: Sat, 03 Dec 2011 17:37:05 +0100
From: Daniel Mack <zonque@gmail.com>
Subject: Re: [alsa-devel] snd-usb-audio - NI Traktor 10 - phono
        settings
To: alsa-devel@alsa-project.org
Message-ID: <4EDA5031.1050502@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1

On 12/03/2011 05:02 AM, Peter Dunker wrote:
> Hi, I am new to this list, so please excuse if my questions are not
> at the right target group.

No, this is the perfectly right place for asking such questions :) For
the record, please make sure you send your follow-ups to the list as well.

> I am using since a couple days the NI Traktor 10 USB audio sound card
> that has 10 channels. I use Ubuntu 11.10. and I was able to capture
> with arecord from the device out of the box all 10 channels and I was
> able to make an asoundrc to make 10 devices each 1 channel of it
> too.
>
> My problem is now that this device enables by default 4 of the 10
> channels as phono level input, which leads to clipping and corrupt
> audio on these channels when I feed line level. NI provides an config
> app for Mac and Windows to set phono or non phono to the channels
> that you like. Unfortunately, these settings do not stay as you set
> under win or mac.

There is no such tool, but controls for all 4 analog stereo pairs to
configure the "direct thru" modes and the phono pre-amps should be
exported as generic amixer controls.

> My question, is there anything in this snd-usb-audio driver module
> that could help me set this phono on/off values or can you guys think
> of any other Linux tool that I could use to set these fields? I also
> noticed that some channels actually changed the phono setting while
> connecting to win and back to linux. So if you guys have an idea how
> to set these values so that they might stay even when connect to
> Linux, this would be helpful too.

Post the output of "amixer controls", please. If there is more than one
card connected and the TA10 is not your default, you might need to pass
the "-D" option to amixer as well. See the output of "cat
/proc/asound/cards" for the right value to pass. With this output, it
should be easy to find the correct ALSA control to use with "amixer cset".


Daniel
