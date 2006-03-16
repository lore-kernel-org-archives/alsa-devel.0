From: boku <boku0712@gmail.com>
Subject: Fwd: memory allocate for substream->runtime->dma_area
Date: Thu, 16 Mar 2006 13:21:45 +0800
Message-ID: <715d90900603152121t40c2c5ddg4e6bce9df9f6e5a9@mail.gmail.com>
References: <715d90900603141942y6c409027sb5a99be13f5ec462@mail.gmail.com>
	 <715d90900603141943h423c0ffdydedec3f1ed50a375@mail.gmail.com>
	 <1142394842.24603.77.camel@mindpipe>
	 <715d90900603142003jd1b1d00he8daf7331cc72237@mail.gmail.com>
	 <1142454177.1671.38.camel@mindpipe>
	 <715d90900603151909o6bb834efv401392e5239a0435@mail.gmail.com>
	 <715d90900603152107q30b76a85l4b428167d515ee8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_637_9405927.1142486505621"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <715d90900603152107q30b76a85l4b428167d515ee8c@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_637_9405927.1142486505621
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 Dear all,
     Could you please tell me what the "frame" and "period" mean in alsa?
I saw snd_pcm_hardware_t struct has period_min,max, period_bytes_min,max et=
c
but quite confused of their meaning. So is the fifo size.
    And btw, which data struct has the info of how many bits per channel fo=
r
the wav bitstream from alsa application aplay etc? Such as 16-bits, 24 or
32-bits.
Thanks for your great help~


 On 3/16/06, Lee Revell <rlrevell@joe-job.com > wrote:
>
> On Wed, 2006-03-15 at 12:03 +0800, boku wrote:
> > Hi, Lee,
> >      Thanks for quick response. Currently I'm designing the sound
> > driver for an ARM integrator/ap-like platform. But in the platform,
> > the audio controller is designated to move data only from a specific
> > address space. Therefore, doesn't it mean that i need to constrain the
> > runtime->dma_area to the specified address so that the AIC can start
> > to do DMA access?
> > Sorry about the code still not done and thanks in advance.
>
> Sorry I'm not really an ARM expert, but this has come up in the list
> archive before.  You should look at some of the other ARM drivers in the
> tree...
>
> Lee
>
>
>

------=_Part_637_9405927.1142486505621
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<span class=3D"gmail_quote"><br></span>
<div style=3D"DIRECTION: ltr">
<div style=3D"DIRECTION: ltr">
<div>Dear all,</div></div>
<div style=3D"DIRECTION: ltr"><span class=3D"q">
<div>&nbsp;&nbsp;&nbsp; Could you please tell me what the &quot;frame&quot;=
 and &quot;period&quot; mean in alsa? </div>
<div>I saw snd_pcm_hardware_t struct has period_min,max, period_bytes_min,m=
ax etc but quite confused of their meaning. So is the fifo size.</div>
<div>&nbsp;&nbsp;&nbsp; And btw, which data struct has the info of how many=
 bits per channel for the wav bitstream from alsa application aplay etc? Su=
ch as 16-bits, 24 or 32-bits. </div>
<div>Thanks for your great help~</div></span></div>
<div style=3D"DIRECTION: ltr"></div>
<div style=3D"DIRECTION: ltr"><span>
<div></div></span><span></span>&nbsp;</div>
<div><span>&nbsp;</span></div>
<div style=3D"DIRECTION: ltr"></div>
<div style=3D"DIRECTION: ltr"><span class=3D"q">
<div><span class=3D"gmail_quote">On 3/16/06, <b class=3D"gmail_sendername">=
Lee Revell</b> &lt;<a onclick=3D"return top.js.OpenExtLink(window,event,thi=
s)" href=3D"mailto:rlrevell@joe-job.com" target=3D"_blank">rlrevell@joe-job=
.com</a>
 &gt; wrote:</span>=20
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Wed, 2006-03-15 at 12:03 +080=
0, boku wrote:<br>&gt; Hi, Lee,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
Thanks for quick response. Currently I'm designing the sound=20
<br>&gt; driver for an ARM integrator/ap-like platform. But in the platform=
,<br>&gt; the audio controller is designated to move data only from a speci=
fic<br>&gt; address space. Therefore, doesn't it mean that i need to constr=
ain the=20
<br>&gt; runtime-&gt;dma_area to the specified address so that the AIC can =
start<br>&gt; to do DMA access?<br>&gt; Sorry about the code still not done=
 and thanks in advance.<br><br>Sorry I'm not really an ARM expert, but this=
 has come up in the list=20
<br>archive before.&nbsp;&nbsp;You should look at some of the other ARM dri=
vers in the<br>tree...<br><br>Lee<br><br><br></blockquote></div><br></span>=
</div>
<div style=3D"DIRECTION: ltr"></div></div>

------=_Part_637_9405927.1142486505621--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
