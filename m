From: "Aditya Shankar" <mc.aditya@gmail.com>
Subject: Re: OSS MIxer API(OSS Emulation mode)
Date: Wed, 15 Nov 2006 14:27:28 +0530
Message-ID: <24a2bfdf0611150057t7c664c9cj3ae886bd4e16598a@mail.gmail.com>
References: <24a2bfdf0611060451l4400868brb45f5668f3504d9a@mail.gmail.com>
	<s5hr6wfe9f6.wl%tiwai@suse.de>
	<24a2bfdf0611090152n15efec46me9ea7fadbd882124@mail.gmail.com>
	<s5hhcx8vr11.wl%tiwai@suse.de>
	<24a2bfdf0611132346q65ec8a33j9bc439b2a85ea86c@mail.gmail.com>
	<s5hfycm9dwz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1204355549=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hfycm9dwz.wl%tiwai@suse.de>
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

--===============1204355549==
Content-Type: multipart/alternative;
	boundary="----=_Part_101997_17673099.1163581048911"

------=_Part_101997_17673099.1163581048911
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Takashi-san,

I tried giving the name as "Master Capture Route" and it got mapped to the
proper put function of the kcontrol  *:)*. *Thanks* for the suggestion. But
I do not see any new control( for Master Capture Route ) being created when
I run alsamixer. Is there any other change necessary for this?

Regards,
Aditya


On 11/14/06, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Tue, 14 Nov 2006 13:16:50 +0530,
> Aditya Shankar wrote:
> >
> >  Takashi-san,
> >
> >       Thanks for the info on that.
> >      I am trying to invoke the ioctl command SOUND_MIXER_WRITE_RECSRC .
> The name or
> > the identifier string in the kcontrol record is "Master Input Capture
> Route".  But
> > with this also, it's not getting mapped to the put func of the kcontrol.
> Is the
> > name for the kcontrol correct or is there something additional that must
> be done? pls
> > let me know..
>
> Right, "Master Input Capture Route" is a non-standard name and
> wouldn't be referred from OSS mixer emulation layer.  Try
> "Master Capture Route", for example.
>
> But, it'd be better that you show the all control elements, for
> example, via "alsactl store".  The mapping of ALSA <-> OSS mixer
> elements is pretty complex (as you can find in core/oss/mixer_oss.c).
>
>
> Takashi
>

------=_Part_101997_17673099.1163581048911
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Takashi-san,&nbsp;</div>
<div>&nbsp;</div>
<div>I tried giving the name as &quot;Master Capture Route&quot; and it got mapped to the proper put function of the kcontrol&nbsp; <strong>:)</strong>. <strong>Thanks</strong> for the suggestion. But I do not see any new control( for Master Capture Route ) being created when I run alsamixer. Is there any&nbsp;other change necessary for this? 
</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Aditya<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 11/14/06, <b class="gmail_sendername">Takashi Iwai</b> &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">At Tue, 14 Nov 2006 13:16:50 +0530,<br>Aditya Shankar wrote:<br>&gt;<br>&gt;&nbsp;&nbsp;Takashi-san,<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks for the info on that.
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I am trying to invoke the ioctl command SOUND_MIXER_WRITE_RECSRC . The name or<br>&gt; the identifier string in the kcontrol record is &quot;Master Input Capture Route&quot;.&nbsp;&nbsp;But<br>&gt; with this also, it's not getting mapped to the put func of the kcontrol. Is the
<br>&gt; name for the kcontrol correct or is there something additional that must be done? pls<br>&gt; let me know..<br><br>Right, &quot;Master Input Capture Route&quot; is a non-standard name and<br>wouldn't be referred from OSS mixer emulation layer.&nbsp;&nbsp;Try
<br>&quot;Master Capture Route&quot;, for example.<br><br>But, it'd be better that you show the all control elements, for<br>example, via &quot;alsactl store&quot;.&nbsp;&nbsp;The mapping of ALSA &lt;-&gt; OSS mixer<br>elements is pretty complex (as you can find in core/oss/mixer_oss.c).
<br><br><br>Takashi<br></blockquote></div>
<div>&nbsp;</div>
<div><br>&nbsp;</div>

------=_Part_101997_17673099.1163581048911--


--===============1204355549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1204355549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1204355549==--
