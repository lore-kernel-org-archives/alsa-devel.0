From: Daniel Mack <zonque@gmail.com>
Subject: Re: snd-usb-audio - NI Traktor 10 - phono settings -
 partly solved
Date: Sun, 04 Dec 2011 13:33:50 +0100
Message-ID: <4EDB68AE.6070100@gmail.com>
References: <46ECA1EC0460234BAE43D054B3738BDA068B04AA0B@GNMAILBOX.gracenote.gracenote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7F383246F5
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 13:33:58 +0100 (CET)
Received: by bkcjk13 with SMTP id jk13so2962486bkc.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Dec 2011 04:33:57 -0800 (PST)
In-Reply-To: <46ECA1EC0460234BAE43D054B3738BDA068B04AA0B@GNMAILBOX.gracenote.gracenote.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/04/2011 08:26 AM, Peter Dunker wrote:
> I used now amixer -c 1 numid=<1..8> off
> 
> and it worked! The channels are on line level now:

Good :)

> numid=1,iface=MIXER,name='Direct Thru Channel A' ;
> type=BOOLEAN,access=rw------,values=1 : values=off 
> numid=2,iface=MIXER,name='Direct Thru Channel B' ;
> type=BOOLEAN,access=rw------,values=1 : values=off 
> numid=3,iface=MIXER,name='Direct Thru Channel C' ;
> type=BOOLEAN,access=rw------,values=1 : values=off 
> numid=4,iface=MIXER,name='Direct Thru Channel D' ;
> type=BOOLEAN,access=rw------,values=1 : values=off 
> numid=5,iface=MIXER,name='Phono Input Channel A' ;
> type=BOOLEAN,access=rw------,values=1 : values=off 
> numid=6,iface=MIXER,name='Phono Input Channel B' ;
> type=BOOLEAN,access=rw------,values=1 : values=off 
> numid=7,iface=MIXER,name='Phono Input Channel C' ;
> type=BOOLEAN,access=rw------,values=1 : values=off 
> numid=8,iface=MIXER,name='Phono Input Channel D' ;
> type=BOOLEAN,access=rw------,values=1 : values=off
> 
> 
> I have 2 problems left: 1) The amixer shows only 8, but the card has
> 10 channels. It might be no problem, as 2 channels were always line,
> but I have to double check, as soon as I have the card in hand
> (currently remote). Any idea, in case the 9. and 10. channel are
> still phono, where and how to look to set these channels too.

Yes, the main input on the front doesn't have a phono preamp and no
direct-thru feature.

> 2) When I connect 2 cards, how can I for sure discriminate which is
> which and assign certain plugins in asoundrc to a specific one. I
> plan to use more then one T10. I read people use the name of the card
> to avoid confusion, but they have no wall the same name. The problem
> is that the order of card numbers is given by the order the cards are
> connected and its not clear what happens when reboot, maybe every
> time something different.
> 
> Any idea, how I could define for sure, which one is which one? Maybe
> with a serial number, but I haven't seen one.

The devices have unique serial numbers in the USB descriptor, but that
won't help you much as the driver doesn't use them to describe the
units. However, the 2nd card will get a suffix in its shortname, so you
might need to connect them one after the other to make sure the ordering
doesn't change.


Daniel

> On 12/03/2011 05:02 AM, Peter Dunker wrote:
>> Hi, I am new to this list, so please excuse if my questions are
>> not at the right target group.
> 
> No, this is the perfectly right place for asking such questions :)
> For the record, please make sure you send your follow-ups to the list
> as well.
> 
>> I am using since a couple days the NI Traktor 10 USB audio sound
>> card that has 10 channels. I use Ubuntu 11.10. and I was able to
>> capture with arecord from the device out of the box all 10 channels
>> and I was able to make an asoundrc to make 10 devices each 1
>> channel of it too.
>> 
>> My problem is now that this device enables by default 4 of the 10 
>> channels as phono level input, which leads to clipping and corrupt 
>> audio on these channels when I feed line level. NI provides an
>> config app for Mac and Windows to set phono or non phono to the
>> channels that you like. Unfortunately, these settings do not stay
>> as you set under win or mac.
> 
> There is no such tool, but controls for all 4 analog stereo pairs to 
> configure the "direct thru" modes and the phono pre-amps should be 
> exported as generic amixer controls.
> 
>> My question, is there anything in this snd-usb-audio driver module 
>> that could help me set this phono on/off values or can you guys
>> think of any other Linux tool that I could use to set these fields?
>> I also noticed that some channels actually changed the phono
>> setting while connecting to win and back to linux. So if you guys
>> have an idea how to set these values so that they might stay even
>> when connect to Linux, this would be helpful too.
> 
> Post the output of "amixer controls", please. If there is more than
> one card connected and the TA10 is not your default, you might need
> to pass the "-D" option to amixer as well. See the output of "cat 
> /proc/asound/cards" for the right value to pass. With this output,
> it should be easy to find the correct ALSA control to use with
> "amixer cset".
> 
> 
> Daniel
> 
> _______________________________________________ Alsa-devel mailing
> list Alsa-devel@alsa-project.org 
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
