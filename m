From: "Stefano D'Angelo" <zanga.mail@gmail.com>
Subject: Re: Line6 TonePort
Date: Thu, 10 Aug 2006 18:39:37 +0200
Message-ID: <160c13350608100939g6fa6d201r59123dd9764e45e4@mail.gmail.com>
References: <160c13350608100919yee3fc8p14096f59aa0071f7@mail.gmail.com>
	<d9def9db0608100932l20d659b7p416057585eab686b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0138941835=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <d9def9db0608100932l20d659b7p416057585eab686b@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--===============0138941835==
Content-Type: multipart/alternative;
	boundary="----=_Part_26791_2285361.1155227977419"

------=_Part_26791_2285361.1155227977419
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

reverse engineer... but i managed to have it playing good. the problem is
that i used the copy callback and so mmaping was not avaible

Stefano

2006/8/10, Markus Rechberger <mrechberger@gmail.com>:
>
> do you reverse engineer that driver, or do you have any specs?
>
> Markus
>
> On 8/10/06, Stefano D'Angelo <zanga.mail@gmail.com> wrote:
> > I hope this is the last time I write but I don't think so.
> > The problem is quite simple: this USB card does not support DMA
> transfers
> > (yes, seems impossible but that's what it is), so a support for this
> sound
> > card is difficult to obtain working on the snd-usb-audio module, Takashi
> > told me to use an intermediate buffer, but I really don't know how to do
> it.
> > Should I copy data from the buffer (playback) on usb transfer
> completition
> > callbacks? But in such case isn't it the same to just copy data into the
> > urb's transfer buffer?
> > I tried to avoid using this buffer and what I obtain is something that
> > resembles what the card should be playing but with huge noise.
> > Please help!
> >
> > Stefano
> >
> >
>
>
> --
> Markus Rechberger
>

------=_Part_26791_2285361.1155227977419
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

reverse engineer... but i managed to have it playing good. the problem
is that i used the copy callback and so mmaping was not avaible<br><br>Stefano<br><br><div><span class="gmail_quote">2006/8/10, Markus Rechberger &lt;<a href="mailto:mrechberger@gmail.com">mrechberger@gmail.com</a>&gt;:</span>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">do you reverse engineer that driver, or do you have any specs?<br><br>Markus<br><br>On 8/10/06, Stefano D'Angelo &lt;
<a href="mailto:zanga.mail@gmail.com">zanga.mail@gmail.com</a>&gt; wrote:<br>&gt; I hope this is the last time I write but I don't think so.<br>&gt; The problem is quite simple: this USB card does not support DMA transfers
<br>&gt; (yes, seems impossible but that's what it is), so a support for this sound<br>&gt; card is difficult to obtain working on the snd-usb-audio module, Takashi<br>&gt; told me to use an intermediate buffer, but I really don't know how to do it.
<br>&gt; Should I copy data from the buffer (playback) on usb transfer completition<br>&gt; callbacks? But in such case isn't it the same to just copy data into the<br>&gt; urb's transfer buffer?<br>&gt; I tried to avoid using this buffer and what I obtain is something that
<br>&gt; resembles what the card should be playing but with huge noise.<br>&gt; Please help!<br>&gt;<br>&gt; Stefano<br>&gt;<br>&gt;<br><br><br>--<br>Markus Rechberger<br></blockquote></div><br>

------=_Part_26791_2285361.1155227977419--


--===============0138941835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0138941835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0138941835==--
