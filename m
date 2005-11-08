From: Tehn Yit Chin <tehn.yit.chin@gmail.com>
Subject: Re: behaviour of the trigger operation
Date: Tue, 8 Nov 2005 17:15:51 +1100
Message-ID: <bf04f99c0511072215hc240364o4de40a743c6f3e47@mail.gmail.com>
References: <bf04f99c0511062057t599036d5g62582ee1cda7d050@mail.gmail.com>
	 <1131359507.436f2d131d628@webmail.uni-halle.de>
	 <bf04f99c0511071723n50c1e630y719e369a0b5d2fed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_29078_15749195.1131430551688"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <bf04f99c0511071723n50c1e630y719e369a0b5d2fed@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_29078_15749195.1131430551688
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 11/8/05, Tehn Yit Chin <tehn.yit.chin@gmail.com> wrote:
>
>
> On 11/7/05, Clemens Ladisch <clemens@ladisch.de > wrote:
> >
> > Tehn Yit Chin wrote:
> > > I am trying to understand how the trigger operation behaves.
> > >
> > > The behaviour that I am observing is that when ALSA starts up, it
> > seems to
> > > be going through a few cycles of prepare, trigger_start and
> > trigger_stop
> > > before it starts to streams data through to the codec. Is this normal
> > > behaviour?
> >
> > No. Which hardware and software are you using?
> >
> >
> > Regards,
> > Clemens
> >
>
> We are using ALSA on an ARM platform with a CS43L43 codec. The kernel is
> 2.6.11 cross-compiled for ARM. The driver code for the CS43L43 is written
> by us, and probably require some improvements. Apart from a couple of sma=
ll
> problems, the codec code is pretty stable.
>
> Looking through the ALSA code further, I noticed that in the function
> snd_pcm_lib_write1() in core/pcm_lib.c, it could potentially start the
> trigger sequences if start_threshold is not set correctly as it is in a
> while() loop.
>
> What is the purpose of start_threshold?
>
> thanks,


Tracing the code further, the trigger stop event was triggerred by the
function snd_pcm_update_hw_ptr_post() as it found that amount of available
frames is the same runtime->stop_threshold and proceed to call xrun().

I don't quite understand what stop_threshold is suppose to do. Is it suppos=
e
to be a method of stopping the stream automatically?

thanks,

------=_Part_29078_15749195.1131430551688
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">On 11/8/05, <b class=3D"gmail_send=
ername">Tehn Yit Chin</b> &lt;<a href=3D"mailto:tehn.yit.chin@gmail.com">te=
hn.yit.chin@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote=
" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0=
.8ex; padding-left: 1ex;">
<div><span class=3D"e" id=3D"q_1076d78d72239dee_0"><br><div><span class=3D"=
gmail_quote">On 11/7/05, <b class=3D"gmail_sendername">Clemens Ladisch</b> =
&lt;<a href=3D"mailto:clemens@ladisch.de" target=3D"_blank" onclick=3D"retu=
rn top.js.OpenExtLink(window,event,this)">
clemens@ladisch.de
</a>&gt; wrote:
</span><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rg=
b(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Tehn Yit C=
hin wrote:<br>&gt; I am trying to understand how the trigger operation beha=
ves.
<br>&gt;<br>&gt; The behaviour that I am observing is that when ALSA starts=
 up, it seems to<br>&gt; be going through a few cycles of prepare, trigger_=
start and trigger_stop<br>&gt; before it starts to streams data through to =
the codec. Is this normal
<br>&gt; behaviour?<br><br>No.&nbsp;&nbsp;Which hardware and software are y=
ou using?<br><br><br>Regards,<br>Clemens<br></blockquote></div><br></span><=
/div>
We are using ALSA on an ARM platform with a CS43L43 codec. The kernel
is 2.6.11 cross-compiled for ARM. The driver code for the CS43L43 is
written by us, and probably require some improvements. Apart from a
couple of small problems, the codec code is pretty stable.<br>
<br>
Looking through the ALSA code further, I noticed that in the function
snd_pcm_lib_write1() in core/pcm_lib.c, it could potentially start the
trigger sequences if start_threshold is not set correctly as it is in a
while() loop.<br>
<br>
What is the purpose of start_threshold?<br>
<br>
thanks,</blockquote><div><br>
Tracing the code further, the trigger stop event was triggerred by the
function snd_pcm_update_hw_ptr_post() as it found that amount of
available frames is the same runtime-&gt;stop_threshold and proceed to
call xrun().<br>
<br>
I don't quite understand what stop_threshold is suppose to do. Is it
suppose to be a method of stopping the stream automatically?<br>
<br>
thanks,<br>
<br>
</div></div>

------=_Part_29078_15749195.1131430551688--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
