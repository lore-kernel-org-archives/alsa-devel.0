From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: emu10k1 patches for 1.0.11
Date: Fri, 16 Dec 2005 22:27:53 +0000
Message-ID: <ad2655cb0512161427m1fa559eax@mail.gmail.com>
References: <1134771473.19091.16.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11841_17794961.1134772073653"
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

------=_Part_11841_17794961.1134772073653
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
>
Lee,

Changing Unknown to Side is ok, but the PCI IDs look very wrong at the
moment.
I am still waiting for confirmation from the users that the patch fixes the
problem.
the entry for the "Audigy 4 64bit [SB0610]" is just plain wrong.

I think it would be better to separate up the patch, one for p16v changes,
and then separate ones for each PCI IDs change.

James

------=_Part_11841_17794961.1134772073653
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
mailto:rlrevell@joe-job.com">rlrevell@joe-job.com</a>&gt;<br><br></blockquo=
te>
</div><br>Lee,<br><br>Changing Unknown to Side is ok, but the PCI IDs look =
very wrong at the moment.<br>I am still waiting for confirmation from the u=
sers that the patch fixes the problem.<br>the entry for the &quot;Audigy 4 =
64bit [SB0610]&quot; is just plain wrong.
<br><br>I think it would be better to separate up the patch, one for p16v c=
hanges, and then separate ones for each PCI IDs change.<br><br>James<br><br=
>

------=_Part_11841_17794961.1134772073653--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
