From: "Mariusz Domanski" <surfer.q3@gmail.com>
Subject: Re: hda-intel,
	ALC861 and Asus A6rp laptop - problem with headphones almost solved
Date: Sun, 1 Oct 2006 12:45:51 +0200
Message-ID: <b209ae1e0610010345jcad32a1kc2141fbdc8a8a1dd@mail.gmail.com>
References: <b209ae1e0609231108i634d41fm87012983b4b9b83e@mail.gmail.com>
	<s5hmz8nt00v.wl%tiwai@suse.de>
	<b209ae1e0609260743kce76b90r15d4a8505657d146@mail.gmail.com>
	<s5h4puusmwc.wl%tiwai@suse.de>
	<b209ae1e0609260843j1418adcbn154f8308842ac251@mail.gmail.com>
	<s5hlko6r2ya.wl%tiwai@suse.de>
	<b209ae1e0609261114t44a4214dv51548f309c41a4eb@mail.gmail.com>
	<s5hfyedp6ag.wl%tiwai@suse.de>
	<b209ae1e0609271537p5bc7095dr3cbb0db41f99acac@mail.gmail.com>
	<s5hirj6537t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0570650672=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hirj6537t.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============0570650672==
Content-Type: multipart/alternative;
	boundary="----=_Part_56166_1030564.1159699551683"

------=_Part_56166_1030564.1159699551683
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2006/9/29, Takashi Iwai <tiwai@suse.de>:
>
> > At Thu, 28 Sep 2006 00:37:19 +0200,
> > Mariusz Domanski wrote:
> > >
> > >
> > > 2006/9/27, Takashi Iwai <tiwai@suse.de>:
> > >
> > >     At Tue, 26 Sep 2006 20:14:58 +0200,
> > >     Mariusz Domanski wrote:
> > >     >
> > >     > I have codec#0 output saved when everything was working.
> > >     > There is little change according to outpiu which codec#0 gives
> me now.
> > >     >
> > >     > Part of "good" codec#0:
> > >     > Node 0x15 [Audio Mixer] wcaps 0x20050f: Stereo Amp-In Amp-Out
> > >     > Amp-In caps: ofs=0x0c, nsteps=0x17, stepsize=0x0b, mute=1
> > >     > Amp-In vals: [0x95 0x95] [0x80 0x80] [0x80 0x80]
> > >     > Amp-Out caps: ofs=0x0c, nsteps=0x0c, stepsize=0x0b, mute=1
> > >     > Amp-Out vals: [0x0c 0x0c]
> > >     > Power: 0x0
> > >     > Connection: 3
> > >     > 0x11 0x14 0x1c
> > >     >
> > >     > Now the 3rd line is:
> > >     > Amp-In vals: [0x95 0x95] [0x95 0x95] [0x95 0x95]
> > >
> > >     Above all, _what_ happened by this change?
> > >
> > >     > This is the only change.
> > >     >
> > >     > What does this mean?
> > >
> > >     It means that the amp-input values are changed.
> > >     But they are still muted (bit 7 [0x80] is on), so in theory, they
> > >     shouldn't make any difference.  No other changes at all?
> > >
> > >     > How can I change it?
> > >
> > >     Via mixer elements, most likely.
> > >     You can check the mixer elements you created which ones have the
> NID
> > >     0x15 (and INPUT direction).
> > >
> > >     > Can this cause this whole strange problem?
> > >
> > >     You'd better to take a look at the block diagram in ALC861
> datasheet
> > >     to understand what's happning.
> > >
> > >     The widget 0x15 is "analog mixer" that takes all inputs from line,
> > >     mic, etc and passes to ADC and the output mixer.  The three values
> are
> > >     volumes from inputs to this mixer from CD, line and mic input
> pins.
> > >
> > >     > I can try to change something but I don't know what exactly
> should be changed,
> > >     so
> > >     > i'll be changing various values :P
> > >
> > >     That's my question, too.  First, you have to recognize the way to
> > >     reproduce the problem.  Debugging randomly happening problem is
> quite
> > >     hard.  We need to know the cause, not only the result.
> >>
> > >     Takashi
> > >
>

> > Well that's great question... What cause the problem? I really would
like to know... :)
> > If I would know how to reproduce this problem I would tell you...
>
> If you can ever get a "good" state, then there must be a cause. You
> need to find out how to get a good and a bad state, the step to
> reproduce (e.g. first boot Windows, or whatever). Then check the
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
sound...
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
mixers
> > are set to 100% I'm about to hear music... It's very very quiet and
> > with high frequency noises...
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
>
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
it? Any
> > special things to do?
>
> Has the headphone _ever_ worked? If not, we can do only blind shots.

As I wrote - worked few times.
> > What about looking at datasheet... Well... I don't understand much,
> > I'm not a driver
> > programmer. I just can think and read and I'm trying to make
> > something knowing almost nothing :)
> >
> > Now I'm looking at datasheet and can only tell what I knew earlier:
> > PORT-A - SURR-OUT - 0x0e - surround, but in my case hp jack (?) [let
> > say it can work]
>
> OK, that's good to know.
>
> > PORT-B - MIC1 - 0x0d - mic jack or built-in mic [works]
> > PORT-C - LINE1 - 0x0c - line-in jack [propably works, I have nothing to
test it]
> > PORT-D - FRONT - 0x0b - front out (built-in speakers) [works]
>
> Is it muted automatically when HP is plugged, or it still continues to
> output sounds? If it keeps sound, we'll need a pin detection (if
> auto-toggling feature is needed).

The FRONT is muted every time I plug something into hp jack, even if
headphones are not working.

> > PORT-E - LINE2 - 0x0f - usually hp, but not in my case, has to be
> > set to 0x24 (mic-input as I understand) or nothing does work...
>
> 0x24 is to set INPUT and VREF 80%. Yes, it's a usual setting for mic
input.
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
I have some problems sending mails to alsa-devel...

------=_Part_56166_1030564.1159699551683
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2006/9/29, Takashi Iwai &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt;:</span><blockquote class="gmail_quote" style="margin-top: 0; margin-right: 0; margin-bottom: 0; margin-left: 0; margin-left: 0.80ex; border-left-color: #cccccc; border-left-width: 1px; border-left-style: solid; padding-left: 1ex">
&gt;&nbsp;At Thu, 28 Sep 2006 00:37:19 +0200,<br>&gt;&nbsp;Mariusz Domanski wrote:<br>&gt;&nbsp;&gt;<br>&gt;&nbsp;&gt;<br>&gt;&nbsp;&gt; 2006/9/27, Takashi Iwai &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt;:<br>&gt;&nbsp;&gt;<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; At Tue, 26 Sep 2006 20:14:58 +0200,
<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; Mariusz Domanski wrote:<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; I have codec#0 output saved when everything was working.<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; There is little change according to outpiu which codec#0 gives me now.
<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Part of &quot;good&quot; codec#0:<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Node 0x15 [Audio Mixer] wcaps 0x20050f: Stereo Amp-In Amp-Out<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Amp-In caps: ofs=0x0c, nsteps=0x17, stepsize=0x0b, mute=1
<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Amp-In vals: [0x95 0x95] [0x80 0x80] [0x80 0x80]<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Amp-Out caps: ofs=0x0c, nsteps=0x0c, stepsize=0x0b, mute=1<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Amp-Out vals: [0x0c 0x0c]<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Power: 0x0
<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Connection: 3<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; 0x11 0x14 0x1c<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Now the 3rd line is:<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Amp-In vals: [0x95 0x95] [0x95 0x95] [0x95 0x95]<br>&gt;&nbsp;&gt;
<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; Above all, _what_ happened by this change?<br>&gt;&nbsp;&gt;<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; This is the only change.<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; What does this mean?<br>&gt;&nbsp;&gt;<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; It means that the amp-input values are changed.
<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; But they are still muted (bit 7 [0x80] is on), so in theory, they<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; shouldn't make any difference.&nbsp;&nbsp;No other changes at all?<br>&gt;&nbsp;&gt;<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; How can I change it?<br>&gt;&nbsp;&gt;
<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; Via mixer elements, most likely.<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; You can check the mixer elements you created which ones have the NID<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; 0x15 (and INPUT direction).<br>&gt;&nbsp;&gt;<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Can this cause this whole strange problem?
<br>&gt;&nbsp;&gt;<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; You'd better to take a look at the block diagram in ALC861 datasheet<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; to understand what's happning.<br>&gt;&nbsp;&gt;<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; The widget 0x15 is &quot;analog mixer&quot; that takes all inputs from line,
<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; mic, etc and passes to ADC and the output mixer.&nbsp;&nbsp;The three values are<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; volumes from inputs to this mixer from CD, line and mic input pins.<br>&gt;&nbsp;&gt;<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; I can try to change something but I don't know what exactly should be changed,
<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; so<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; i'll be changing various values :P<br>&gt;&nbsp;&gt;<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; That's my question, too.&nbsp;&nbsp;First, you have to recognize the way to<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; reproduce the problem.&nbsp;&nbsp;Debugging randomly happening problem is quite
<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; hard.&nbsp;&nbsp;We need to know the cause, not only the result.<br>&gt;&gt;&nbsp;<br>&gt;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; Takashi<br>&gt;&nbsp;&gt;<br></blockquote></div><br>&gt; &gt; Well that's great question... What cause the problem? I really would like to know... :) 
<br>&gt; &gt; If I would know how to reproduce this problem I would tell you...<br>&gt; <br>&gt; If you can ever get a &quot;good&quot; state, then there must be a cause.  You<br>&gt; need to find out how to get a good and a bad state, the step to 
<br>&gt; reproduce (e.g. first boot Windows, or whatever).  Then check the<br>&gt; internal state of the device.  This is the most important thing to<br>&gt; debug this kind of problems.<br><br>The worst thing is that I don't see any reason the &quot;good&quot; state is changing to&nbsp;the &quot;bad&quot; one... 
<br>Headphones DID work few times, just after recompilation, reinstallation of modules and restarting alsasound. Headphones were working well as they sould work always but just after restarting Alsa or rebooting laptop they weren't working... (I wrote about this in previous mails) 
<br><br>&gt; &gt; I mean now this problem is present - headphones are not working :P<br>&gt; &gt; codec#0 shows PIN_OUT (0x40) on headphones jack, but there is no sound...<br>&gt; <br>&gt; Which PIN node?  The headphone jack takes usually PIN_HP (0xc0) with 
<br>&gt; HP-overdrive bit.  You should also trace the connection line between<br>&gt; the pin and DAC, and check whether all widgets are unmuted/adjusted<br>&gt; throughout the line.<br><br>I know that the hp jack should take PIN_HP, it is even set in my patch, but codec#0 shows: 
<br>Pin-ctls: 0x40: OUT<br>for hp jack.<br>How can I chceck if all widgets between pin and DAC are unmuted?<br><br>&gt; &gt; I can tell you that when line-in is unmuted and master mixer and line-in mixers<br>&gt; &gt; are set to 100% I'm about to hear music... It's very very quiet and 
<br>&gt; &gt; with high frequency noises...<br>&gt; <br>&gt; Sorry, it's not clear what you mean here.  Please describe more<br>&gt; exactly what you did, step by step?<br><br>It's always when I'm writing &quot;there is no sound&quot;. Basically there is no sound, but: if you set PCM to 100% and unmute line-in and set it also to 100% (I'm using gnome-volume-manager), the sound can be heard. This sound is very very quiet and with high frequency noises. 
<br><br>&gt; &gt; The most strange thing is that, as I wrote before, the sound was and<br>&gt; &gt; disappeard after<br>&gt; &gt; Alsa restart...<br>&gt; <br>&gt; Is the device state restored via alsactl automatically?<br>
&gt; Usually, udev takes a charge to call &quot;alsactl restore&quot; after module<br>&gt; reloading.  You can call &quot;alsactl save&quot; before restart, and call<br>&gt; &quot;alsactl restore&quot; after restart manually. 
<br><br>I don't know if the device state is restored via alsactl automatically. How can i check it?<br>Dou you mean that after alsasound restart the mixers states should be set like before restart?<br><br>&gt; &gt; Does Alsa have any config files that could be changed during restart? 
<br>&gt; &gt; What can be changed during Alsa restart?<br>&gt; <br>&gt; The device is set up to be muted per default (depending on the driver<br>&gt; implementation, though).  You have to adjust it to unmuted state.<br>&gt; Calling &quot;alsactl restore&quot; would restore to the last saved state. 
<br>&gt; <br>&gt; This whole thing depends on the distribution you use.  I cannot tell<br>&gt; the exact detail.<br><br>As I wrote in the first mail I'm using Ubuntu 6.06 Dapper Drake with kernel <a href="http://2.6.17.11">
2.6.17.11</a> (I had to remove earlier emails, because it would be too long email and it would be hard to read everything, all our mails are archived in the alsa-devel archive of course, on <a href="http://news.gmane.org/gmane.linux.alsa.devel">
http://news.gmane.org/gmane.linux.alsa.devel</a> thread posted on 23 Sep 20:08).<br>And what about muted mixers per default... It's strange but every time I fully recompile Alsa (with make clean before recompilation) the default level of PCM (which is set after alsasound restart) is different. Once it's 45%, another time 80%, 60% or 10%... Strange... I think that earlier (with previous versions of Alsa) mixer was muted until I changed it or called alsaconf. 
<br><br>&gt; &gt; I'll try to make the headphones working... What should I do if I'll do it? Any<br>&gt; &gt; special things to do?<br>&gt; <br>&gt; Has the headphone _ever_ worked?  If not, we can do only blind shots.<br>
<br>As I wrote - worked few times.<br> &gt; &gt; What about looking at datasheet... Well... I don't understand much,<br>&gt; &gt; I'm not a driver<br>&gt; &gt; programmer. I just can think and read and I'm trying to make 
<br>&gt; &gt; something knowing almost nothing :)<br>&gt; &gt;<br>&gt; &gt; Now I'm looking at datasheet and can only tell what I knew earlier:<br>&gt; &gt; PORT-A - SURR-OUT - 0x0e - surround, but in my case hp jack (?) [let 
<br>&gt; &gt; say it can work]<br>&gt; <br>&gt; OK, that's good to know.<br>&gt; <br>&gt; &gt; PORT-B - MIC1 - 0x0d - mic jack or built-in mic [works]<br>&gt; &gt; PORT-C - LINE1 - 0x0c - line-in jack [propably works, I have nothing to test it] 
<br>&gt; &gt; PORT-D - FRONT - 0x0b - front out (built-in speakers) [works]<br>&gt; <br>&gt; Is it muted automatically when HP is plugged, or it still continues to<br>&gt; output sounds?  If it keeps sound, we'll need a pin detection (if 
<br> &gt; auto-toggling feature is needed).<br><br>The FRONT is muted every time I plug something into hp jack, even if headphones are not working.<br><br>&gt; &gt; PORT-E - LINE2 - 0x0f - usually hp, but not in my case, has to be 
<br>&gt; &gt; set to 0x24 (mic-input as I understand) or nothing does work...<br>&gt; <br>&gt; 0x24 is to set INPUT and VREF 80%.  Yes, it's a usual setting for mic input.<br>&gt; <br>&gt; &gt; PORT-F - MIC2 - 0x10 - built-in mic or mic jack [works] 
<br>&gt; <br>&gt; Hm, what is the difference from port-B?<br><br>PORT-B and PORT-F - I suppose that one is mic jack, 2nd is built-in mic (there is built-in mic which is muted, when something is plugged into mic jack).<br>
<br>&gt; Takashi<br><br>Mariusz<br><br>P.S.<br>I have some problems sending mails to alsa-devel...<br>

------=_Part_56166_1030564.1159699551683--


--===============0570650672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0570650672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0570650672==--
