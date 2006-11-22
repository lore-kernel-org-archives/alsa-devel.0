From: "Aditya Shankar" <mc.aditya@gmail.com>
Subject: Re: OSS MIxer API(OSS Emulation mode)
Date: Wed, 22 Nov 2006 17:56:59 +0530
Message-ID: <24a2bfdf0611220426k19dc7a75s17718075e70adca4@mail.gmail.com>
References: <24a2bfdf0611060451l4400868brb45f5668f3504d9a@mail.gmail.com>
	<s5hr6wfe9f6.wl%tiwai@suse.de>
	<24a2bfdf0611090152n15efec46me9ea7fadbd882124@mail.gmail.com>
	<s5hhcx8vr11.wl%tiwai@suse.de>
	<24a2bfdf0611132346q65ec8a33j9bc439b2a85ea86c@mail.gmail.com>
	<s5hfycm9dwz.wl%tiwai@suse.de>
	<24a2bfdf0611150057t7c664c9cj3ae886bd4e16598a@mail.gmail.com>
	<s5hr6vwissg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0856124836=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hr6vwissg.wl%tiwai@suse.de>
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

--===============0856124836==
Content-Type: multipart/alternative;
	boundary="----=_Part_22620_15026375.1164198419756"

------=_Part_22620_15026375.1164198419756
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 Yes in alsamixer window I have a control component as  "Master" which is a
result of a kcontrol element "Master Capture Volume". But I see no control
component in alsamixer due to "Master Capture Route".

The command amixer controls shows the following corresponding to capture,

numid=6,iface=MIXER,name='Master Capture Route'
numid=5,iface=MIXER,name='Master Capture Volume'

Regards,
Aditya

On 11/21/06, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Wed, 15 Nov 2006 14:27:28 +0530,
> Aditya Shankar wrote:
> >
>
> > Takashi-san,
> >
> > I tried giving the name as "Master Capture Route" and it got mapped to
> the proper put
> > function of the kcontrol  :). Thanks for the suggestion. But I do not
> see any new
> > control( for Master Capture Route ) being created when I run alsamixer.
> Is there
> > any other change necessary for this?
>
> I guess you see "Master" in alsamixer's capture mode?
> What does amixer show?
>
>
> Takashi
>

------=_Part_22620_15026375.1164198419756
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>&nbsp;Yes in alsamixer window I&nbsp;have a control component as &nbsp;&quot;Master&quot; which is a result of a kcontrol element &quot;Master Capture Volume&quot;. But I see no control component in alsamixer due to &quot;Master Capture Route&quot;.
<br>&nbsp;</div>
<div>The command amixer controls&nbsp;shows the&nbsp;following corresponding to capture,</div>
<div>&nbsp;</div>
<div>numid=6,iface=MIXER,name='Master Capture Route'<br>numid=5,iface=MIXER,name='Master Capture Volume' </div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Aditya<br>&nbsp;</div>
<div><span class="gmail_quote">On 11/21/06, <b class="gmail_sendername">Takashi Iwai</b> &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">At Wed, 15 Nov 2006 14:27:28 +0530,<br>Aditya Shankar wrote:<br>&gt;<br><br>&gt; Takashi-san,<br>&gt;<br>&gt; I tried giving the name as &quot;Master Capture Route&quot; and it got mapped to the proper put
<br>&gt; function of the kcontrol&nbsp;&nbsp;:). Thanks for the suggestion. But I do not see any new<br>&gt; control( for Master Capture Route ) being created when I run alsamixer. Is there<br>&gt; any other change necessary for this?
<br><br>I guess you see &quot;Master&quot; in alsamixer's capture mode?<br>What does amixer show?<br><br><br>Takashi<br></blockquote></div><br>

------=_Part_22620_15026375.1164198419756--


--===============0856124836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0856124836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0856124836==--
