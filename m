From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Intel HDA on Mac Pro
Date: Wed, 13 Dec 2006 09:11:44 -0800
Message-ID: <1166029904.4142.94.camel@razman>
References: <4574866D.5070506@sourcegear.com>
	<45748CF5.8040800@sourcegear.com> <1165275957.32312.103.camel@razman>
	<4574BB17.1020807@sourcegear.com> <1165278602.32312.110.camel@razman>
	<4574EF72.8020207@sourcegear.com> <457828D7.4020908@teamprise.com>
	<1165535200.7530.63.camel@razman>
	<loom.20061211T231028-61@post.gmane.org>
	<1165877711.7530.253.camel@razman>
	<f0d712d60612111704x14717093p6e038641fc6e94e6@mail.gmail.com>
	<1166023329.4142.86.camel@razman>  <45802C28.1020401@sourcegear.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0056029565=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45802C28.1020401@sourcegear.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Shaw Terwilliger <sterwill@sourcegear.com>
Cc: Richard Anaya <richard.anaya@gmail.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============0056029565==
Content-Type: multipart/alternative; boundary="=-jOuo0iM4za1+PpiZrMN3"


--=-jOuo0iM4za1+PpiZrMN3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-12-13 at 10:36 -0600, Shaw Terwilliger wrote:

> Tobin Davis wrote:
> > Could one of you run a little experiment for me?  Here's what I need:
> > 
> > Load the sound drivers.  Unplug headphones, toggle off the headphone
> > button in alsamixer and type "cat /proc/asound/card0/codec#0 >
> > without-headphones.codec".  Next, plug in your headphones, toggle the
> > headphone button and type "cat /proc/asound/card0/codec#0 >
> > with-headphones.codec".  Send me both files.
> 
> Attached.  Quick diff for your instant gratification:
> 
> hansen:~% diff without-headphones.codec with-headphones.codec
> 156c156
> <   Amp-Out vals:  [0x80 0x80]
> ---
> >   Amp-Out vals:  [0x00 0x00]

That was exactly what I was looking for (and hoping was not happening).
Essentially, the headphone switch is correctly muting the jack (0x80,
left and right channel).  Just no volume.

Back to the manual.  I'll try to get another patch out today.

Thanks,
-- 
Tobin Davis <tdavis@dsl-only.net>

--=-jOuo0iM4za1+PpiZrMN3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
On Wed, 2006-12-13 at 10:36 -0600, Shaw Terwilliger wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Tobin Davis wrote:</FONT>
<FONT COLOR="#000000">&gt; Could one of you run a little experiment for me?  Here's what I need:</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Load the sound drivers.  Unplug headphones, toggle off the headphone</FONT>
<FONT COLOR="#000000">&gt; button in alsamixer and type &quot;cat /proc/asound/card0/codec#0 &gt;</FONT>
<FONT COLOR="#000000">&gt; without-headphones.codec&quot;.  Next, plug in your headphones, toggle the</FONT>
<FONT COLOR="#000000">&gt; headphone button and type &quot;cat /proc/asound/card0/codec#0 &gt;</FONT>
<FONT COLOR="#000000">&gt; with-headphones.codec&quot;.  Send me both files.</FONT>

<FONT COLOR="#000000">Attached.  Quick diff for your instant gratification:</FONT>

<FONT COLOR="#000000">hansen:~% diff without-headphones.codec with-headphones.codec</FONT>
<FONT COLOR="#000000">156c156</FONT>
<FONT COLOR="#000000">&lt;   Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">---</FONT>
<FONT COLOR="#000000">&gt;   Amp-Out vals:  [0x00 0x00]</FONT>
</PRE>
</BLOCKQUOTE>
That was exactly what I was looking for (and hoping was not happening).&nbsp; Essentially, the headphone switch is correctly muting the jack (0x80, left and right channel).&nbsp; Just no volume.<BR>
<BR>
Back to the manual.&nbsp; I'll try to get another patch out today.<BR>
<BR>
Thanks,<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-jOuo0iM4za1+PpiZrMN3--



--===============0056029565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0056029565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0056029565==--
