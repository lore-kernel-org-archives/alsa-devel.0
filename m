From: "aditya shankar" <mc.aditya@gmail.com>
Subject: Re: OSS MIxer API(OSS Emulation mode)
Date: Thu, 9 Nov 2006 15:22:34 +0530
Message-ID: <24a2bfdf0611090152n15efec46me9ea7fadbd882124@mail.gmail.com>
References: <24a2bfdf0611060451l4400868brb45f5668f3504d9a@mail.gmail.com>
	<s5hr6wfe9f6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0088191620=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hr6wfe9f6.wl%tiwai@suse.de>
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

--===============0088191620==
Content-Type: multipart/alternative;
	boundary="----=_Part_29905_23538562.1163065954954"

------=_Part_29905_23538562.1163065954954
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Takashi-san,

We tried invoking an IOCTL on /dev/mixer with command
SOUND_MIXER_WRITE_RECSRC. It did not seem to invoke the put function of the
kcontrol for selecting recording source (it's "Master Input Capture").

Also, can I add my own IOCTL commands and route control to their
implementations?

Thanks in advance
Aditya

On 11/7/06, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Mon, 6 Nov 2006 18:21:40 +0530,
> aditya shankar wrote:
> >
> > Hi Group,
> >
> > I'm integrating OSS mixer API support on a custom ARM based platform
> (custom audio
> > chip as well). I would like to know if I can add my own IOCTL commands
> in OSS mixer
> > API and then route them to my implementation. (This is required because
> there are some
> > features in audio chip and I can't find a mapping to the existing OSS
> mixer IOCTL
> > commands).
> > Also I've observed that some standard IOCTLs such as REC_MASK etc are
> not getting
> > properly routed to the corresponding kcontrols.
>
> How did you check this exactly?  Note that REC_MASK (RECSRC) doesn't
> always correspond to an ALSA mixer element as 1:1 but often to a group
> of elements.
>
>
> Takashi

------=_Part_29905_23538562.1163065954954
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Takashi-san,</div>
<div>&nbsp;</div>
<div>We tried invoking an IOCTL on /dev/mixer with command SOUND_MIXER_WRITE_RECSRC. It did not seem to invoke the put function of the kcontrol for selecting recording source (it's &quot;Master Input Capture&quot;).</div>

<div>&nbsp;</div>
<div>Also, can I add my own IOCTL commands and route control to their implementations?</div>
<div>&nbsp;</div>
<div>Thanks in advance</div>
<div>Aditya</div>
<div>&nbsp;</div>
<div><span class="gmail_quote">On 11/7/06, <b class="gmail_sendername">Takashi Iwai</b> &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">At Mon, 6 Nov 2006 18:21:40 +0530,<br>aditya shankar wrote:<br>&gt;<br>&gt; Hi Group,<br>&gt;<br>&gt; I'm integrating OSS mixer API support on a custom ARM based platform (custom audio
<br>&gt; chip as well). I would like to know if I can add my own IOCTL commands in OSS mixer<br>&gt; API and then route them to my implementation. (This is required because there are some<br>&gt; features in audio chip and I can't find a mapping to the existing OSS mixer IOCTL
<br>&gt; commands).<br>&gt; Also I've observed that some standard IOCTLs such as REC_MASK etc are not getting<br>&gt; properly routed to the corresponding kcontrols.<br><br>How did you check this exactly?&nbsp;&nbsp;Note that REC_MASK (RECSRC) doesn't
<br>always correspond to an ALSA mixer element as 1:1 but often to a group<br>of elements.<br><br><br>Takashi</blockquote>
<div>&nbsp;</div>
<div>&nbsp;</div><br>
<div>&nbsp;</div>
<div>&nbsp;</div><br>&nbsp;</div><br>

------=_Part_29905_23538562.1163065954954--


--===============0088191620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0088191620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0088191620==--
