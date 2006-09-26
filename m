From: "Mariusz Domanski" <surfer.q3@gmail.com>
Subject: Re: hda-intel,
	ALC861 and Asus A6rp laptop - problem with headphones almost solved
Date: Tue, 26 Sep 2006 20:14:58 +0200
Message-ID: <b209ae1e0609261114t44a4214dv51548f309c41a4eb@mail.gmail.com>
References: <b209ae1e0609231108i634d41fm87012983b4b9b83e@mail.gmail.com>
	<s5hpsdjj4mp.wl%tiwai@suse.de>
	<b209ae1e0609251125k399f7897jcf4d33d96d55055f@mail.gmail.com>
	<s5hmz8nt00v.wl%tiwai@suse.de>
	<b209ae1e0609260743kce76b90r15d4a8505657d146@mail.gmail.com>
	<s5h4puusmwc.wl%tiwai@suse.de>
	<b209ae1e0609260843j1418adcbn154f8308842ac251@mail.gmail.com>
	<s5hlko6r2ya.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1238235181=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hlko6r2ya.wl%tiwai@suse.de>
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

--===============1238235181==
Content-Type: multipart/alternative;
	boundary="----=_Part_14174_22896907.1159294498381"

------=_Part_14174_22896907.1159294498381
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2006/9/26, Takashi Iwai <tiwai@suse.de>:
>
> At Tue, 26 Sep 2006 17:43:26 +0200,
> Mariusz Domanski wrote:
> >
> >
> > 2006/9/26, Takashi Iwai <tiwai@suse.de>:
> >
> >     At Tue, 26 Sep 2006 16:43:32 +0200,
> >     Mariusz Domanski wrote:
> >     >
> >     > 2006/9/26, Takashi Iwai <tiwai@suse.de>:
> >     >
> >     >     >At Mon, 25 Sep 2006 20:25:50 +0200,
> >     >     >Mariusz Domanski wrote:
> >     >     >>
> >     >     >>
> >     >     > >2006/9/25, Takashi Iwai <tiwai@suse.de>:
> >     >     >>
> >     >     >>     >> Propably the sound will appear after (x)th
> compilation, but why?
> >     Why it
> >     >     is not
> >     >     >>     working
> >     >     >>     >> all the time?
> >     >     >>
> >     >     >>     >No idea.  A weird hardware...
> >     >     >>
> >     >     >>     >> And why the ALC861 is detected to be the ALC660?
> >     >     >>
> >     >     >>     >Simply because they are almost compatible (according
> to Realtek).
> >     >     >>
> >     >     >>     >The patch looks broken.  Could you regenerated it?
> >     >     >>
> >     >     >>     >thanks,
> >     >     >>
> >     >     >>     >Takashi
> >     >     >>
> >     >     >>  Here is patch (now I'll write it as a part of email):
> >     >     >
> >     >     >... and it's more broken now :)
> >     >     >
> >     >     >Could you give the correct patch as an attachment?
> >     >     >Also, try to avoid C++ style comments as much as possible.
> >     >     >
> >     >     >
> >     >     >Thanks,
> >     >     >
> >     >     >Takashi
> >     >
> >     > Ok, I really don't know why the patch doesn't want to work... It
> looks well, but
> >     > produces errors when applied...
> >     > Anyway, I'm sending attachement with modified patch_realtek.c and
> patch file
> >     which
> >     > should work but doesn't...
> >
> >     Maybe the gzipped patch should have sufficed.  So, it's kept
> >     unmodified by the mailer.
> >
> >     I'm now looking at your new patch, and found that you do _not_
> comment
> >     out #if 0 for mic and line-in verbs as you did in the earlier patch.
> >     Namely, in the earler version:
> >
> >     +//#if 0
> >     + { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7080 | (0x01 << 8)) },
> /*mic*/
> >     + { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7080 | (0x02 << 8)) },
> /*line in*/
> >     +//#endif
> >     + { } /* end */
> >
> >     while the '//' are removed in the newer version.
> >     Is it intentional?
> >
> >     Otherwise it looks fine.
> >
> >     Thanks,
> >
> >     Takashi
> >
> > Well... It does't seem to make difference for me.. Now it does't want to
> work with
> > comment tags and withotu them... It only works _sometimes_.
> >
> > I wrote in bugreport that when model=3stack is chosen and channel mode
> is set to 6ch
> > the line-in and mic works as output, but I can now tell you that was one
> of these
> > _sometimes_ and it worked only once, but worked, and there in the
> sourcecode the #if 0
> > is not commented out. Later, when testing my patch everything worked
> with #if 0
> > commented out.. So... It doesn't change anything in my case...
>
> Hm, that's weird.  For more precise analysis, try the following:
>
> - get a "bad" state (e.g. mic/line doesn't work)
>   then get dump by copying /proc/asound/card0/codec#* file.
> - change the code, get a "good" state, and do the same dump
> - compare two dump files.
>
> Sometimes the things don't work as expected, and this is often caused
> by simple human mistakes.  Comparing dumps would reveal whether the
> hardware states are really changed or not, at least.
>
>
> Takashi
>

I have codec#0 output saved when everything was working.
There is little change according to outpiu which codec#0 gives me now.

Part of "good" codec#0:
Node 0x15 [Audio Mixer] wcaps 0x20050f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x0c, nsteps=0x17, stepsize=0x0b, mute=1
Amp-In vals: [0x95 0x95] [0x80 0x80] [0x80 0x80]
Amp-Out caps: ofs=0x0c, nsteps=0x0c, stepsize=0x0b, mute=1
Amp-Out vals: [0x0c 0x0c]
Power: 0x0
Connection: 3
0x11 0x14 0x1c

Now the 3rd line is:
Amp-In vals: [0x95 0x95] [0x95 0x95] [0x95 0x95]

This is the only change.

What does this mean?
How can I change it?
Can this cause this whole strange problem?

I can try to change something but I don't know what exactly should be
changed, so i'll be changing various values :P

Thanks for your support :)
Mariusz

------=_Part_14174_22896907.1159294498381
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2006/9/26, Takashi Iwai &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt;:</span><blockquote class="gmail_quote" style="margin-top: 0; margin-right: 0; margin-bottom: 0; margin-left: 0; margin-left: 0.80ex; border-left-color: #cccccc; border-left-width: 1px; border-left-style: solid; padding-left: 1ex">
At Tue, 26 Sep 2006 17:43:26 +0200,<br>Mariusz Domanski wrote:<br>&gt;<br>&gt;<br>&gt; 2006/9/26, Takashi Iwai &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt;:<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; At Tue, 26 Sep 2006 16:43:32 +0200,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Mariusz Domanski wrote:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; 2006/9/26, Takashi Iwai &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt;:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;At Mon, 25 Sep 2006 20:25:50 +0200,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;Mariusz Domanski wrote:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; &gt;2006/9/25, Takashi Iwai &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt;:
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; Propably the sound will appear after (x)th compilation, but why?<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Why it<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; is not<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; working
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; all the time?<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;No idea.&nbsp;&nbsp;A weird hardware...<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; And why the ALC861 is detected to be the ALC660?
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;Simply because they are almost compatible (according to Realtek).<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;The patch looks broken.&nbsp;&nbsp;Could you regenerated it?
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;thanks,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;Takashi<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;Here is patch (now I'll write it as a part of email):
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;... and it's more broken now :)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;Could you give the correct patch as an attachment?<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;Also, try to avoid C++ style comments as much as possible.
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;Thanks,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;Takashi<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Ok, I really don't know why the patch doesn't want to work... It looks well, but
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; produces errors when applied...<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Anyway, I'm sending attachement with modified patch_realtek.c and patch file<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; which<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; should work but doesn't...<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Maybe the gzipped patch should have sufficed.&nbsp;&nbsp;So, it's kept
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; unmodified by the mailer.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; I'm now looking at your new patch, and found that you do _not_ comment<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; out #if 0 for mic and line-in verbs as you did in the earlier patch.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Namely, in the earler version:
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; +//#if 0<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; + { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7080 | (0x01 &lt;&lt; 8)) }, /*mic*/<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; + { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7080 | (0x02 &lt;&lt; 8)) }, /*line in*/<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; +//#endif
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; + { } /* end */<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; while the '//' are removed in the newer version.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Is it intentional?<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Otherwise it looks fine.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Thanks,<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Takashi
<br>&gt;<br>&gt; Well... It does't seem to make difference for me.. Now it does't want to work with<br>&gt; comment tags and withotu them... It only works _sometimes_.<br>&gt;<br>&gt; I wrote in bugreport that when model=3stack is chosen and channel mode is set to 6ch
<br>&gt; the line-in and mic works as output, but I can now tell you that was one of these<br>&gt; _sometimes_ and it worked only once, but worked, and there in the sourcecode the #if 0<br>&gt; is not commented out. Later, when testing my patch everything worked with #if 0
<br>&gt; commented out.. So... It doesn't change anything in my case...<br><br>Hm, that's weird.&nbsp;&nbsp;For more precise analysis, try the following:<br><br>- get a &quot;bad&quot; state (e.g. mic/line doesn't work)<br>&nbsp;&nbsp;then get dump by copying /proc/asound/card0/codec#* file.
<br>- change the code, get a &quot;good&quot; state, and do the same dump<br>- compare two dump files.<br><br>Sometimes the things don't work as expected, and this is often caused<br>by simple human mistakes.&nbsp;&nbsp;Comparing dumps would reveal whether the
<br>hardware states are really changed or not, at least.<br><br><br>Takashi<br></blockquote></div><br>I have codec#0 output saved when everything was working.<br>There is little change according to outpiu which codec#0 gives me now.
<br><br>Part of &quot;good&quot; codec#0:<br>Node 0x15 [Audio Mixer] wcaps 0x20050f: Stereo Amp-In Amp-Out<br>  Amp-In caps: ofs=0x0c, nsteps=0x17, stepsize=0x0b, mute=1<br>  Amp-In vals:  [0x95 0x95] [0x80 0x80] [0x80 0x80]
<br>  Amp-Out caps: ofs=0x0c, nsteps=0x0c, stepsize=0x0b, mute=1<br>  Amp-Out vals:  [0x0c 0x0c]<br>  Power: 0x0<br>  Connection: 3<br>     0x11 0x14 0x1c<br><br>Now the 3rd line is:<br>Amp-In vals:  [0x95 0x95] [0x95 0x95] [0x95 0x95]
<br><br>This is the only change.<br><br>What does this mean?<br>How can I change it?<br>Can this cause this whole strange problem?<br><br>I can try to change something but I don't know what&nbsp;exactly should be changed, so i'll&nbsp;be changing various values :P
<br><br>Thanks for  your support :)<br>Mariusz<br>

------=_Part_14174_22896907.1159294498381--


--===============1238235181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1238235181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1238235181==--
