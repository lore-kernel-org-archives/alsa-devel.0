From: "Aditya Shankar" <mc.aditya@gmail.com>
Subject: Re: OSS MIxer API(OSS Emulation mode)
Date: Tue, 14 Nov 2006 13:16:50 +0530
Message-ID: <24a2bfdf0611132346q65ec8a33j9bc439b2a85ea86c@mail.gmail.com>
References: <24a2bfdf0611060451l4400868brb45f5668f3504d9a@mail.gmail.com>
	<s5hr6wfe9f6.wl%tiwai@suse.de>
	<24a2bfdf0611090152n15efec46me9ea7fadbd882124@mail.gmail.com>
	<s5hhcx8vr11.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1138661201=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hhcx8vr11.wl%tiwai@suse.de>
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

--===============1138661201==
Content-Type: multipart/alternative;
	boundary="----=_Part_84482_13121858.1163490410740"

------=_Part_84482_13121858.1163490410740
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 Takashi-san,

      Thanks for the info on that.
     I am trying to invoke the ioctl command SOUND_MIXER_WRITE_RECSRC . The
name or the identifier string in the kcontrol record is "Master Input
Capture Route".  But with this also, it's not getting mapped to the put func
of the kcontrol. Is the name for the kcontrol correct or is there something
additional that must be done? pls let me know..

Thanks & Regards,
Aditya

On 11/9/06, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Thu, 9 Nov 2006 15:22:34 +0530,
> aditya shankar wrote:
> >
> > Takashi-san,
> >
> > We tried invoking an IOCTL on /dev/mixer with command
> SOUND_MIXER_WRITE_RECSRC. It did
> > not seem to invoke the put function of the kcontrol for selecting
> recording source
> > (it's "Master Input Capture").
>
> "Master Input Capture" is an uncommon name, and it won't be mapped to
> OSS mixer elements unless you specify via proc file.
>
>
> > Also, can I add my own IOCTL commands and route control to their
> implementations?
>
> No for oss mixer API.  Yes for ALSA native API using hwdep device.


Takashi


> Thanks in advance
> Aditya
>
> On 11/7/06, Takashi Iwai <tiwai@suse.de> wrote:
>
>     At Mon, 6 Nov 2006 18:21:40 +0530,
>     aditya shankar wrote:
>     >
>     > Hi Group,
>     >
>     > I'm integrating OSS mixer API support on a custom ARM based platform
(custom
>     audio
>     > chip as well). I would like to know if I can add my own IOCTL
commands in OSS
>     mixer
>     > API and then route them to my implementation. (This is required
because there
>     are some
>     > features in audio chip and I can't find a mapping to the existing
OSS mixer
>     IOCTL
>     > commands).
>     > Also I've observed that some standard IOCTLs such as REC_MASK etc
are not
>     getting
>     > properly routed to the corresponding kcontrols.
>
>     How did you check this exactly?  Note that REC_MASK (RECSRC) doesn't
>     always correspond to an ALSA mixer element as 1:1 but often to a group
>     of elements.
>
>     Takashi
>
>

------=_Part_84482_13121858.1163490410740
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>&nbsp;&nbsp; <br>&nbsp;Takashi-san,</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks for the info on that.</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; I am trying to invoke the ioctl command SOUND_MIXER_WRITE_RECSRC . The name or the identifier string in the kcontrol record is &quot;Master Input Capture Route&quot;.&nbsp; But with this also, it's not getting mapped to the put func of the kcontrol. Is the name&nbsp;for the kcontrol correct or is there something additional that must be done? pls let me know..
</div>
<div>&nbsp;</div>
<div>Thanks &amp; Regards,</div>
<div>Aditya&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;</div>
<div><span class="gmail_quote">On 11/9/06, <b class="gmail_sendername">Takashi Iwai</b> &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:tiwai@suse.de" target="_blank">tiwai@suse.de</a>&gt; wrote:
</span> 
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">At Thu, 9 Nov 2006 15:22:34 +0530,<br>aditya shankar wrote:<br>&gt;<br>&gt; Takashi-san,<br>&gt;<br>&gt; We tried invoking an IOCTL on /dev/mixer with command SOUND_MIXER_WRITE_RECSRC. It did 
<br>&gt; not seem to invoke the put function of the kcontrol for selecting recording source<br>&gt; (it's &quot;Master Input Capture&quot;).<br><br>&quot;Master Input Capture&quot; is an uncommon name, and it won't be mapped to 
<br>OSS mixer elements unless you specify via proc file.<br><br><br>&gt; Also, can I add my own IOCTL commands and route control to their implementations?<br><br>No for oss mixer API.&nbsp;&nbsp;Yes for ALSA native API using hwdep device. 
</blockquote>
<div>&nbsp;</div>
<div>Takashi<br><br><br>&gt; Thanks in advance<br>&gt; Aditya<br>&gt;<br>&gt; On 11/7/06, Takashi Iwai &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:tiwai@suse.de" target="_blank">tiwai@suse.de
</a>&gt; wrote:<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; At Mon, 6 Nov 2006 18:21:40 +0530, <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; aditya shankar wrote:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Hi Group,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; I'm integrating OSS mixer API support on a custom ARM based platform (custom
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; audio<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; chip as well). I would like to know if I can add my own IOCTL commands in OSS <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; mixer<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; API and then route them to my implementation. (This is required because there
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; are some<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; features in audio chip and I can't find a mapping to the existing OSS mixer <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; IOCTL<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; commands).<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Also I've observed that some standard IOCTLs such as REC_MASK etc are not
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; getting<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; properly routed to the corresponding kcontrols. <br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; How did you check this exactly?&nbsp;&nbsp;Note that REC_MASK (RECSRC) doesn't<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; always correspond to an ALSA mixer element as 1:1 but often to a group
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; of elements.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Takashi <br>&gt;<br>&gt;<br>&nbsp;</div></div><br>

------=_Part_84482_13121858.1163490410740--


--===============1138661201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1138661201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1138661201==--
