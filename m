From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Intel HDA on Mac Pro
Date: Mon, 11 Dec 2006 09:43:59 -0800
Message-ID: <1165859039.7530.231.camel@razman>
References: <4574866D.5070506@sourcegear.com>
	<1165265511.32312.86.camel@razman>	<45748CF5.8040800@sourcegear.com>
	<1165275957.32312.103.camel@razman>	<4574BB17.1020807@sourcegear.com>
	<1165278602.32312.110.camel@razman> <4574EF72.8020207@sourcegear.com>
	<457828D7.4020908@teamprise.com> <1165535200.7530.63.camel@razman>
	<4579BF60.8000601@sourcegear.com> <1165767364.7530.148.camel@razman>
	<457D6E99.2000207@sourcegear.com> <1165854833.7530.205.camel@razman>
	<457D8CDC.4090501@sourcegear.com> <1165856707.7530.209.camel@razman>
	<457D91BE.9010409@sourcegear.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1476628682=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <457D91BE.9010409@sourcegear.com>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1476628682==
Content-Type: multipart/alternative; boundary="=-10gmIQyS/1wW7lX9wBZA"


--=-10gmIQyS/1wW7lX9wBZA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Could you send me the new output from 'cat /proc/asound/card0/codec#0'?
This might tell me why headphones aren't working.

By default, the jack that your system reported as headphones (when
model=auto) is normally the microphone jack.  I may need to add a verb
that reverses the signal making it an output.  This is a very minor
change, and if it works, I'll get it added to the next alsa release.

Tobin

On Mon, 2006-12-11 at 11:13 -0600, Shaw Terwilliger wrote:

> Tobin Davis wrote:
> > Oops.  I had the mixer bindings wrong.  Try this one.
> 
> My sound is back, and correctly labeled Front in the mixer!  Line-in is
> also controlled correctly.  Still no headphone noise from the front of
> the chassis (with or without headphone switch enabled).  Not a big deal
> for me since I built a stereo switch box to plug into above the desk.
> 
> Thanks for all your hacking.
> 

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-10gmIQyS/1wW7lX9wBZA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Could you send me the new output from 'cat /proc/asound/card0/codec#0'?&nbsp; This might tell me why headphones aren't working.<BR>
<BR>
By default, the jack that your system reported as headphones (when model=auto) is normally the microphone jack.&nbsp; I may need to add a verb that reverses the signal making it an output.&nbsp; This is a very minor change, and if it works, I'll get it added to the next alsa release.<BR>
<BR>
Tobin<BR>
<BR>
On Mon, 2006-12-11 at 11:13 -0600, Shaw Terwilliger wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Tobin Davis wrote:</FONT>
<FONT COLOR="#000000">&gt; Oops.  I had the mixer bindings wrong.  Try this one.</FONT>

<FONT COLOR="#000000">My sound is back, and correctly labeled Front in the mixer!  Line-in is</FONT>
<FONT COLOR="#000000">also controlled correctly.  Still no headphone noise from the front of</FONT>
<FONT COLOR="#000000">the chassis (with or without headphone switch enabled).  Not a big deal</FONT>
<FONT COLOR="#000000">for me since I built a stereo switch box to plug into above the desk.</FONT>

<FONT COLOR="#000000">Thanks for all your hacking.</FONT>

</PRE>
</BLOCKQUOTE>
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

--=-10gmIQyS/1wW7lX9wBZA--



--===============1476628682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1476628682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1476628682==--
