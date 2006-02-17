From: boku <boku0712@gmail.com>
Subject: Re: How to compile kernel with adding new alsa driver?
Date: Fri, 17 Feb 2006 16:35:50 +0800
Message-ID: <715d90900602170035i137aa468k918c72592906b7c2@mail.gmail.com>
References: <715d90900602131740v4e98723ak26c1fbe793322829@mail.gmail.com>
	 <20060215113734.GA6465@palantir8>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10160_25690128.1140165350282"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.205])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 885EA1CC
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2006 09:35:51 +0100 (MET)
Received: by zproxy.gmail.com with SMTP id i28so349664nzi
        for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2006 00:35:50 -0800 (PST)
In-Reply-To: <20060215113734.GA6465@palantir8>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_10160_25690128.1140165350282
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks, Martin,
    Could I ask you another Q? I studied pcm's functions and found
xxx_pcm_trigger()?
What kind of fuction it provides in general? Thanks a lot!~

Best Regards,


On 2/15/06, Martin Habets <errandir_news@mph.eclipse.co.uk> wrote:
>
> On Tue, Feb 14, 2006 at 09:40:16AM +0800, boku wrote:
> > Dear all,
> >      How to compile linux kernel with adding my driver into alsa?
>
> Do you build alsa inside or outside the kernel structure? If it's a
> part of the normal kernel build, you only need entries in Kconfig
> and Makefile in the 'arm' subdirectory.
> If you're building alsa outside the kernel, more may be needed. See below=
.
>
>
> > If my
> > platform is ARM's Integrator, do I need to set any configs before
> compiling
> > for my new alsa driver? Or where I can find such information? Thank you
> very
> > much~
>
> Sorry, I am not familiar with the ARM Integrator platform. What cpu does
> it use?
> If is's not supported yet the configure script would need some changes.
> No problem if you know you're autoconf stuff. I didn't, so the experts
> did this part for me.
>
> I do not recall any documentation on alsa's platform support, but then I
> would not expect anything. It's standard autoconf stuff.
> There is the excellent "Writing an alsa driver" and more at
> http://www.alsa-project.org/documentation.php
> See chapter 15 especially.
>
> --
> Martin
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>

------=_Part_10160_25690128.1140165350282
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Thanks, Martin,</div>
<div>&nbsp;&nbsp;&nbsp; Could I ask you another Q? I studied pcm's function=
s and found <font color=3D"#000000">xxx_pcm_trigger()? What kind of fuction=
 it provides in general? Thanks a lot!~</font></div>
<div>&nbsp;</div>
<div>Best Regards,</div>
<div><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 2/15/06, <b class=3D"gmail_sendername">=
Martin Habets</b> &lt;<a onclick=3D"return top.js.OpenExtLink(window,event,=
this)" href=3D"mailto:errandir_news@mph.eclipse.co.uk" target=3D"_blank">er=
randir_news@mph.eclipse.co.uk
</a>&gt; wrote:</span>=20
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Tue, Feb 14, 2006 at 09:40:16=
AM +0800, boku wrote:<br>&gt; Dear all,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;How to compile linux kernel with adding my driver into alsa?=20
<br><br>Do you build alsa inside or outside the kernel structure? If it's a=
<br>part of the normal kernel build, you only need entries in Kconfig<br>an=
d Makefile in the 'arm' subdirectory.<br>If you're building alsa outside th=
e kernel, more may be needed. See below.=20
<br><br>&gt; If my<br>&gt; platform is ARM's Integrator, do I need to set a=
ny configs before compiling<br>&gt; for my new alsa driver? Or where I can =
find such information? Thank you very<br>&gt; much~<br><br>Sorry, I am not =
familiar with the ARM Integrator platform. What cpu does=20
<br>it use?<br>If is's not supported yet the configure script would need so=
me changes.<br>No problem if you know you're autoconf stuff. I didn't, so t=
he experts<br>did this part for me.<br><br>I do not recall any documentatio=
n on alsa's platform support, but then I=20
<br>would not expect anything. It's standard autoconf stuff.<br>There is th=
e excellent &quot;Writing an alsa driver&quot; and more at<br><a onclick=3D=
"return top.js.OpenExtLink(window,event,this)" href=3D"http://www.alsa-proj=
ect.org/documentation.php" target=3D"_blank">
http://www.alsa-project.org/documentation.php </a><br>See chapter 15 especi=
ally.<br><br>--<br>Martin<br><br><br>--------------------------------------=
-----------------<br>This SF.net email is sponsored by: Splunk Inc. Do you =
grep through log files
<br>for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search =
engine that makes <br>searching your log files as easy as surfing the&nbsp;=
&nbsp;web.&nbsp;&nbsp;DOWNLOAD SPLUNK!<br><a onclick=3D"return top.js.OpenE=
xtLink(window,event,this)" href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dln=
k&amp;kid=3D103432&amp;bid=3D230486&amp;dat=3D121642" target=3D"_blank">
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D103432&amp;bid=3D230486=
&amp;dat=3D121642 </a><br>_______________________________________________<b=
r>Alsa-devel mailing list<br><a onclick=3D"return top.js.OpenExtLink(window=
,event,this)" href=3D"mailto:Alsa-devel@lists.sourceforge.net" target=3D"_b=
lank">
Alsa-devel@lists.sourceforge.net</a><br><a onclick=3D"return top.js.OpenExt=
Link(window,event,this)" href=3D"https://lists.sourceforge.net/lists/listin=
fo/alsa-devel" target=3D"_blank">https://lists.sourceforge.net/lists/listin=
fo/alsa-devel
</a><br></blockquote></div><br>

------=_Part_10160_25690128.1140165350282--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
