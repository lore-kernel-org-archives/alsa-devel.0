From: "Alexander Indenbaum" <alexander.indenbaum@gmail.com>
Subject: Re: [alsa-devel] /usr/share/alsa/alsa.conf :and file
	extention
Date: Tue, 18 Mar 2008 06:28:28 +0200
Message-ID: <cab05a880803172128m1a422272ua7168d872a9fc46a@mail.gmail.com>
References: <cab05a880803161957j7a82e04cma094afda62d5cdab@mail.gmail.com>
	<47DDE2F7.7000904@keyaccess.nl> <s5hmyoxu66g.wl%tiwai@suse.de>
	<cab05a880803171727u6df4897an677d197eec4c28e6@mail.gmail.com>
	<47DF1E20.6040706@keyaccess.nl>
	<cab05a880803171906y4c9f87bbtd0bd59a8376f9c77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1798047848=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <cab05a880803171906y4c9f87bbtd0bd59a8376f9c77@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Rene Herman <rene.herman@keyaccess.nl>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-user <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============1798047848==
Content-Type: multipart/alternative;
	boundary="----=_Part_11588_32237374.1205814508746"

------=_Part_11588_32237374.1205814508746
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Mar 18, 2008 at 4:06 AM, Alexander Indenbaum <
alexander.indenbaum@gmail.com> wrote:

> On Tue, Mar 18, 2008 at 3:42 AM, Rene Herman <rene.herman@keyaccess.nl>
> wrote:
>
> > Yes, aplay would've worked. What you are using is trying to open
> > controls
> > for the card though and non are defined. If you will be using the dummy
> > driver anyway, use:
> >
> > pcm.!default {
> >        type    file
> >        slave   {
> >                 pcm     "hw:0"
> >        }
> >        file    "/tmp/pcm.out"
> > }
> >
> >
> > with snd-dummy having index 0. I tested this just now with firefox and
> > the
> > flash plugin on youtube and it works for me.
> >
>
OK, it works on Linux 2.6 but silently fails on Linux 2.4.
Unfortunately, I need it to work on  Linux 2.4 :)
So what can be done?

-- 
Alexander Indenbaum

------=_Part_11588_32237374.1205814508746
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Mar 18, 2008 at 4:06 AM, Alexander Indenbaum &lt;<a href="mailto:alexander.indenbaum@gmail.com">alexander.indenbaum@gmail.com</a>&gt; wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Tue, Mar 18, 2008 at 3:42 AM, Rene Herman &lt;<a href="mailto:rene.herman@keyaccess.nl" target="_blank">rene.herman@keyaccess.nl</a>&gt; wrote:<br></div><div class="gmail_quote"><div class="Ih2E3d">
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Yes, aplay would&#39;ve worked. What you are using is trying to open controls<br>
for the card though and non are defined. If you will be using the dummy<br>
driver anyway, use:<br>
<div><br>
pcm.!default {<br>
 &nbsp; &nbsp; &nbsp; &nbsp;type &nbsp; &nbsp;file<br>
 &nbsp; &nbsp; &nbsp; &nbsp;slave &nbsp; {<br>
</div> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pcm &nbsp; &nbsp; &quot;hw:0&quot;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
 &nbsp; &nbsp; &nbsp; &nbsp;file &nbsp; &nbsp;&quot;/tmp/pcm.out&quot;<br>
}<br>
<br>
<br>
with snd-dummy having index 0. I tested this just now with firefox and the<br>
flash plugin on youtube and it works for me.<br>
</blockquote></div></div></blockquote></div><br>OK, it works on Linux 2.6 but silently fails on Linux 2.4.<br>Unfortunately, I need it to work on&nbsp; Linux 2.4 :)<br>So what can be done? <br clear="all"><br>-- <br>Alexander Indenbaum

------=_Part_11588_32237374.1205814508746--


--===============1798047848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1798047848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============1798047848==--
