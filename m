From: "Alexander Indenbaum" <alexander.indenbaum@gmail.com>
Subject: Re: [alsa-devel] /usr/share/alsa/alsa.conf :and file
	extention
Date: Tue, 18 Mar 2008 03:36:53 +0200
Message-ID: <cab05a880803171836j1972ff0tb107f371e410c822@mail.gmail.com>
References: <cab05a880803161957j7a82e04cma094afda62d5cdab@mail.gmail.com>
	<47DDE2F7.7000904@keyaccess.nl> <s5hmyoxu66g.wl%tiwai@suse.de>
	<cab05a880803171727u6df4897an677d197eec4c28e6@mail.gmail.com>
	<75b66ecd0803171745u52e4e3e3u2a959d1f3676902c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0459937360=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <75b66ecd0803171745u52e4e3e3u2a959d1f3676902c@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user <alsa-user@lists.sourceforge.net>, Rene Herman <rene.herman@keyaccess.nl>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============0459937360==
Content-Type: multipart/alternative;
	boundary="----=_Part_11208_20779980.1205804213890"

------=_Part_11208_20779980.1205804213890
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Mar 18, 2008 at 2:45 AM, Lee Revell <rlrevell@joe-job.com> wrote:

>
> Please strace aplay and see what files it's trying to open.
>

You're absolutely right.  I was missing /dev device files.
So my test goes like this:
- run snddevices script to create  /dev
- load snd drivers with Dummy compiled in
- open browser on YouTube clip

 Now there is no error messages. From other hand I do not see /tmp/pcm.out.
I tried to "touch" this file but it stays zero length.

So what next?


> Lee
>



-- 
Alexander Indenbaum

------=_Part_11208_20779980.1205804213890
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Mar 18, 2008 at 2:45 AM, Lee Revell &lt;<a href="mailto:rlrevell@joe-job.com">rlrevell@joe-job.com</a>&gt; wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d"><br>
</div>Please strace aplay and see what files it&#39;s trying to open.<br>
<font color="#888888"></font></blockquote><div><br>You&#39;re absolutely right.&nbsp; I was missing /dev device files.<br>So my test goes like this: <br>- run snddevices script to create&nbsp; /dev<br>- load snd drivers with Dummy compiled in<br>
- open browser on YouTube clip<br><br>&nbsp;Now there is no error messages. From other hand I do not see /tmp/pcm.out. I tried to &quot;touch&quot; this file but it stays zero length.<br><br>So what next?<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<font color="#888888"><br>
Lee<br>
</font></blockquote></div><br><br clear="all"><br>-- <br>Alexander Indenbaum

------=_Part_11208_20779980.1205804213890--


--===============0459937360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0459937360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============0459937360==--
