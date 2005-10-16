From: Tehn Yit Chin <tehn.yit.chin@gmail.com>
Subject: Re: how does alsa keep passing data into driver?
Date: Mon, 17 Oct 2005 00:00:11 +1000
Message-ID: <bf04f99c0510160700y490bc9b6q8db1bd77957de4c2@mail.gmail.com>
References: <bf04f99c0510131947m1a5e0a68n631b761818887222@mail.gmail.com>
	 <XFMail.20051014093633.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5170_25769102.1129471211283"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20051014093633.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_5170_25769102.1129471211283
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 10/14/05, Giuliano Pochini <pochini@shiny.it> wrote:
>
>
> On 14-Oct-2005 Tehn Yit Chin wrote:
>
> > I am trying to understand how the ALSA pass PCM data to the driver. I
> have
> > understand that when the driver starts up, a start trigger event is
> created
> > and some PCM data is passed in. After that, how does the subsequent PCM
> data
> > get pass into the driver?
>
> The ALSA middle layer passes PCM data to the driver only if the driver
> attaches a function to the .copy() callback. Otherwise (and this is the
> most common case) the ALSA ml copies data to/from the buffer on its own.


So when would it appropriate to attached a function to the .copy callback?
Are you able to give me a clue which function actual performs the copying i=
n
the ALSA middle layer?

Thanks for you reponse thus far.

------=_Part_5170_25769102.1129471211283
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">On 10/14/05, <b class=3D"gmail_sen=
dername">Giuliano Pochini</b> &lt;<a href=3D"mailto:pochini@shiny.it">pochi=
ni@shiny.it</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D=
"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padd=
ing-left: 1ex;">
<br>On 14-Oct-2005 Tehn Yit Chin wrote:<br><br>&gt; I am trying to understa=
nd how the ALSA pass PCM data to the driver. I have<br>&gt; understand that=
 when the driver starts up, a start trigger event is created<br>&gt; and so=
me PCM data is passed in. After that, how does the subsequent PCM data
<br>&gt; get pass into the driver?<br><br>The ALSA middle layer passes PCM =
data to the driver only if the driver<br>attaches a function to the .copy()=
 callback. Otherwise (and this is the<br>most common case) the ALSA ml copi=
es data to/from the buffer on its own.
</blockquote><div><br>
So when would it appropriate to attached a function to the .copy
callback? Are you able to give me a clue which function actual performs
the copying in the ALSA middle layer?<br>
<br>
Thanks for you reponse thus far.<br>
<br>
&nbsp;</div><br></div><br>

------=_Part_5170_25769102.1129471211283--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
