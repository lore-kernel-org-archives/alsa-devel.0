From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: emu10k1 patches for 1.0.11
Date: Fri, 16 Dec 2005 22:29:10 +0000
Message-ID: <ad2655cb0512161429m5dfb532cs@mail.gmail.com>
References: <1134771473.19091.16.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11845_18624368.1134772150622"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1134771473.19091.16.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, James Courtier-Dutton <James@superbug.co.uk>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

------=_Part_11845_18624368.1134772150622
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 16/12/05, Lee Revell <rlrevell@joe-job.com> wrote:
>
> These were in my CVS tree.
>
> Add some new PCI IDs.
>
> p16v: Change Unknown to Side channels.
>
> Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
>
> Index: alsa-kernel/pci/emu10k1/emu10k1_main.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
> retrieving revision 1.79
> diff -u -r1.79 emu10k1_main.c
> --- alsa-kernel/pci/emu10k1/emu10k1_main.c      6 Dec 2005 14:10:57
> -0000       1.79
> +++ alsa-kernel/pci/emu10k1/emu10k1_main.c      16 Dec 2005 22:13:47 -000=
0
> @@ -728,7 +728,17 @@
>         return snd_emu10k1_free(emu);
> }
>
> -static struct snd_emu_chip_details emu_chip_details[] =3D {
> +static emu_chip_details_t emu_chip_details[] =3D {
>

emu_chip_details_t is wrong.

------=_Part_11845_18624368.1134772150622
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 16/12/05, <b class=3D"gmail_sendername">Lee Revell</b> &lt;<a href=3D"ma=
ilto:rlrevell@joe-job.com">rlrevell@joe-job.com</a>&gt; wrote:<div><span cl=
ass=3D"gmail_quote"></span><blockquote class=3D"gmail_quote" style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;">
These were in my CVS tree.<br><br>Add some new PCI IDs.<br><br>p16v: Change=
 Unknown to Side channels.<br><br>Signed-Off-By: Lee Revell &lt;<a href=3D"=
mailto:rlrevell@joe-job.com">rlrevell@joe-job.com</a>&gt;<br><br>Index: als=
a-kernel/pci/emu10k1/emu10k1_main.c
<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>RCS file: /cvs=
root/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v<br>retrieving revision 1=
.79<br>diff -u -r1.79 emu10k1_main.c<br>--- alsa-kernel/pci/emu10k1/emu10k1=
_main.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6 Dec 2005 14:10:57 -0000&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1.79<br>+++ alsa-kernel/pci/emu10k1/emu10k1_main.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;16 Dec 2005 22:13:47 -0000<br>@@ -728,7 +728,17 @@<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return snd_emu10k1_free(emu);<br> }<b=
r><br>-static struct snd_emu_chip_details emu_chip_details[] =3D {<br>
+static emu_chip_details_t emu_chip_details[] =3D {<br></blockquote></div><=
br>emu_chip_details_t is wrong.<br><br>

------=_Part_11845_18624368.1134772150622--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
