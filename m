From: <mariook@wp.pl>
Subject: Re: hda-intel,
	ALC861 and Asus A6rp laptop - problem with headphones almost solved
Date: Thu, 5 Oct 2006 18:21:38 +0200
Message-ID: <004901c6e89a$5812c2f0$83030a54@MIREK>
References: <000501c6ccf2$8515d3f0$83030a54@MIREK>
	<op.te66ytxp143j3k@starlight.ubyt.sdjls.uniba.sk>
	<003f01c6ce85$f7f52c10$83030a54@MIREK>
	<op.tfp1qlap143j3k@starlight>
	<009e01c6d5e9$21e24110$83030a54@MIREK>
	<op.tfrmlbwu143j3k@starlight>
	<00a501c6dbf1$f865a4d0$83030a54@MIREK>
	<e5a80d4f0609190736v79cee634qcdc453d1f600cbb1@mail.gmail.com>
	<007901c6e184$7ea47e80$83030a54@MIREK>
	<op.tgi3diqx143j3k@localhost>
	<004201c6e2c9$906e4f10$83030a54@MIREK>
	<op.tgxzi0j3143j3k@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

2006/9/29, Takashi Iwai <tiwai@suse.de>:
> > At Thu, 28 Sep 2006 00:37:19 +0200,
> > Mariusz Domanski wrote:
> > >
> > >
> > > 2006/9/27, Takashi Iwai <tiwai@suse.de>:
> > >
> > > At Tue, 26 Sep 2006 20:14:58 +0200, Mariusz Domanski wrote:
> > > >
> > > > I have codec#0 output saved when everything was working.
> > > > There is little change according to outpiu which codec#0 gives me 
> > > > now.
> > > > Part of "good" codec#0:
> > > > Node 0x15 [Audio Mixer] wcaps 0x20050f: Stereo Amp-In Amp-Out
> > > > Amp-In caps: ofs=0x0c, nsteps=0x17, stepsize=0x0b, mute=1 Amp-In 
> > > > vals: [0x95 0x95] [0x80 0x80] [0x80 0x80]
> > > > Amp-Out caps: ofs=0x0c, nsteps=0x0c, stepsize=0x0b, mute=1
> > > > Amp-Out vals: [0x0c 0x0c]
> > > > Power: 0x0 Connection: 3
> > > > 0x11 0x14 0x1c
> > > >
> > > > Now the 3rd line is:
> > > > Amp-In vals: [0x95 0x95] [0x95 0x95] [0x95 0x95]
> > >
> > > Above all, _what_ happened by this change?
> > >
> > > > This is the only change.
> > > >
> > > > What does this mean?
> > >
> > > It means that the amp-input values are changed. But they are still 
> > > muted (bit 7 [0x80] is on), so in theory, they
> > > shouldn't make any difference. No other changes at all?
> > >
> > > > How can I change it?
> > >
> > > Via mixer elements, most likely.
> > > You can check the mixer elements you created which ones have the NID
> > > 0x15 (and INPUT direction).
> > >
> > > > Can this cause this whole strange problem?
> > >
> > > You'd better to take a look at the block diagram in ALC861 datasheet
> > > to understand what's happning.
> > >
> > > The widget 0x15 is "analog mixer" that takes all inputs from line, 
> > > mic, etc and passes to ADC and the output mixer. The three values are
> > > volumes from inputs to this mixer from CD, line and mic input pins.
> > >
> > > > I can try to change something but I don't know what exactly should 
> > > > be changed,
> > > so
> > > > i'll be changing various values :P
> >> That's my question, too. First, you have to recognize the way to
> > > reproduce the problem. Debugging randomly happening problem is quite 
> > > hard. We need to know the cause, not only the result.
> > >
> > > Takashi
> > >

> > Well that's great question... What cause the problem? I really would 
> > like to know... :) If I would know how to reproduce this problem I would 
> > tell you...
>
> If you can ever get a "good" state, then there must be a cause. You
> need to find out how to get a good and a bad state, the step to reproduce 
> (e.g. first boot Windows, or whatever). Then check the
> internal state of the device. This is the most important thing to
> debug this kind of problems.

The worst thing is that I don't see any reason the "good" state is changing 
to the "bad" one...
Headphones DID work few times, just after recompilation, reinstallation of 
modules and restarting alsasound. Headphones were working well as they sould 
work always but just after restarting Alsa or rebooting laptop they weren't 
working... (I wrote about this in previous mails)

> > I mean now this problem is present - headphones are not working :P
> > codec#0 shows PIN_OUT (0x40) on headphones jack, but there is no 
> > sound...
>
> Which PIN node? The headphone jack takes usually PIN_HP (0xc0) with 
> HP-overdrive bit. You should also trace the connection line between
> the pin and DAC, and check whether all widgets are unmuted/adjusted
> throughout the line.

I know that the hp jack should take PIN_HP, it is even set in my patch, but 
codec#0 shows:
Pin-ctls: 0x40: OUT
for hp jack.
How can I chceck if all widgets between pin and DAC are unmuted?

> > I can tell you that when line-in is unmuted and master mixer and line-in 
> > mixers
> > are set to 100% I'm about to hear music... It's very very quiet and with 
> > high frequency noises...
>
> Sorry, it's not clear what you mean here. Please describe more
> exactly what you did, step by step?

It's always when I'm writing "there is no sound". Basically there is no 
sound, but: if you set PCM to 100% and unmute line-in and set it also to 
100% (I'm using gnome-volume-manager), the sound can be heard. This sound is 
very very quiet and with high frequency noises.

> > The most strange thing is that, as I wrote before, the sound was and
> > disappeard after
> > Alsa restart...
>
> Is the device state restored via alsactl automatically?
> Usually, udev takes a charge to call "alsactl restore" after module
> reloading. You can call "alsactl save" before restart, and call
> "alsactl restore" after restart manually.

I don't know if the device state is restored via alsactl automatically. How 
can i check it?
Dou you mean that after alsasound restart the mixers states should be set 
like before restart?

> > Does Alsa have any config files that could be changed during restart? 
> > What can be changed during Alsa restart?
>
> The device is set up to be muted per default (depending on the driver
> implementation, though). You have to adjust it to unmuted state.
> Calling "alsactl restore" would restore to the last saved state.
> This whole thing depends on the distribution you use. I cannot tell
> the exact detail.

As I wrote in the first mail I'm using Ubuntu 6.06 Dapper Drake with kernel 
2.6.17.11 (I had to remove earlier emails, because it would be too long 
email and it would be hard to read everything, all our mails are archived in 
the alsa-devel archive of course, on 
http://news.gmane.org/gmane.linux.alsa.devel thread posted on 23 Sep 20:08).
And what about muted mixers per default... It's strange but every time I 
fully recompile Alsa (with make clean before recompilation) the default 
level of PCM (which is set after alsasound restart) is different. Once it's 
45%, another time 80%, 60% or 10%... Strange... I think that earlier (with 
previous versions of Alsa) mixer was muted until I changed it or called 
alsaconf.

> > I'll try to make the headphones working... What should I do if I'll do 
> > it? Any
> > special things to do?
>
> Has the headphone _ever_ worked? If not, we can do only blind shots.

As I wrote - worked few times.

> > What about looking at datasheet... Well... I don't understand much,
> > I'm not a driver
> > programmer. I just can think and read and I'm trying to make something 
> > knowing almost nothing :)
> >
> > Now I'm looking at datasheet and can only tell what I knew earlier:
> > PORT-A - SURR-OUT - 0x0e - surround, but in my case hp jack (?) [let say 
> > it can work]
>
> OK, that's good to know.
>
> > PORT-B - MIC1 - 0x0d - mic jack or built-in mic [works]
> > PORT-C - LINE1 - 0x0c - line-in jack [propably works, I have nothing to 
> > test it] PORT-D - FRONT - 0x0b - front out (built-in speakers) [works]
>
> Is it muted automatically when HP is plugged, or it still continues to
> output sounds? If it keeps sound, we'll need a pin detection (if 
> auto-toggling feature is needed).

The FRONT is muted every time I plug something into hp jack, even if 
headphones are not working.

> > PORT-E - LINE2 - 0x0f - usually hp, but not in my case, has to be set to 
> > 0x24 (mic-input as I understand) or nothing does work...
>
> 0x24 is to set INPUT and VREF 80%. Yes, it's a usual setting for mic 
> input.
>
> > PORT-F - MIC2 - 0x10 - built-in mic or mic jack [works]
>
> Hm, what is the difference from port-B?

PORT-B and PORT-F - I suppose that one is mic jack, 2nd is built-in mic 
(there is built-in mic which is muted, when something is plugged into mic 
jack).

> Takashi

Mariusz

P.S.
I have some problems sending mails to alsa-devel from my gmail account... 
Tried few times but I always get same error:
"This is an automatically generated Delivery Status Notification

Delivery to the following recipient failed permanently:

    alsa-devel@lists.sourceforge.net

Technical details of permanent failure:
TEMP_FAILURE: SMTP Error (state 9): 451-Could not complete sender verify 
callout
451-Could not complete sender verify callout for <surfer.q3@gmail.com>.
451-The mail server(s) for the domain may be temporarily unreachable, or
451-they may be permanently unreachable from this server. In the latter 
case,
451-you need to change the address or create an MX record for its domain
451-if it is supposed to be generally accessible from the Internet.
451 Talk to your mail administrator for details." 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
