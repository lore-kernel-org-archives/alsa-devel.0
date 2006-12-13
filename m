From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Intel HDA on Mac Pro
Date: Wed, 13 Dec 2006 07:22:09 -0800
Message-ID: <1166023329.4142.86.camel@razman>
References: <4574866D.5070506@sourcegear.com>
	<45748CF5.8040800@sourcegear.com> <1165275957.32312.103.camel@razman>
	<4574BB17.1020807@sourcegear.com> <1165278602.32312.110.camel@razman>
	<4574EF72.8020207@sourcegear.com> <457828D7.4020908@teamprise.com>
	<1165535200.7530.63.camel@razman>
	<loom.20061211T231028-61@post.gmane.org>
	<1165877711.7530.253.camel@razman>
	<f0d712d60612111704x14717093p6e038641fc6e94e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1307299186=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <f0d712d60612111704x14717093p6e038641fc6e94e6@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Richard Anaya <richard.anaya@gmail.com>, Shaw Terwilliger <sterwill@sourcegear.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1307299186==
Content-Type: multipart/alternative; boundary="=-vWoKwL2zYCCtRHuUz69N"


--=-vWoKwL2zYCCtRHuUz69N
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Could one of you run a little experiment for me?  Here's what I need:

Load the sound drivers.  Unplug headphones, toggle off the headphone
button in alsamixer and type "cat /proc/asound/card0/codec#0 >
without-headphones.codec".  Next, plug in your headphones, toggle the
headphone button and type "cat /proc/asound/card0/codec#0 >
with-headphones.codec".  Send me both files.

The only info I have shows the headphone jack as muted, but I want to
verify that it changes state when the button is toggled.

Thanks.



-- 
Tobin Davis <tdavis@dsl-only.net>

--=-vWoKwL2zYCCtRHuUz69N
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Could one of you run a little experiment for me?&nbsp; Here's what I need:<BR>
<BR>
Load the sound drivers.&nbsp; Unplug headphones, toggle off the headphone button in alsamixer and type &quot;cat /proc/asound/card0/codec#0 &gt; without-headphones.codec&quot;.&nbsp; Next, plug in your headphones, toggle the headphone button and type &quot;cat /proc/asound/card0/codec#0 &gt; with-headphones.codec&quot;.&nbsp; Send me both files.<BR>
<BR>
The only info I have shows the headphone jack as muted, but I want to verify that it changes state when the button is toggled.<BR>
<BR>
Thanks.<BR>
<BR>
<BR>
<BR>
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

--=-vWoKwL2zYCCtRHuUz69N--



--===============1307299186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1307299186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1307299186==--
