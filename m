From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Conexant CODEC Support In ALSA
Date: Fri, 01 Dec 2006 19:32:00 -0800
Message-ID: <1165030320.32312.31.camel@razman>
References: <71F63FF0233C2545847A726F221A941955A982@nbmail4.nb.conexant.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0281531643=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <71F63FF0233C2545847A726F221A941955A982@nbmail4.nb.conexant.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Eitan David <eitan.david@conexant.com>
Cc: Jonathan Chien <jonathan.chien@conexant.com>, alsa-devel@lists.sourceforge.net, Andrew Webster <andrew.webster@conexant.com>, Stephen McIntyre <steve.mcintyre@conexant.com>
List-Id: alsa-devel@alsa-project.org


--===============0281531643==
Content-Type: multipart/alternative; boundary="=-5wf/lp4hTlI2VZlstd6Q"


--=-5wf/lp4hTlI2VZlstd6Q
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello and welcome. 

 I am the person that has been developing the audio support for your
current products.  Unfortunately, I don't have access to any systems
with your audio codec in them, except through a group of dedicated users
that have been willing to help test my driver.

You are correct in that some systems do not properly mute the speakers,
while other systems do mute the speakers.  I hope this is just an
implementation issue, and not some external hardware thing.  I have a
detailed list of what systems/features work and what doesn't.  Other
issues have been attributed to broken acpi support and that development
team has been notified.

Since this project is open source, any changes/enhancements you would
like to contribute would be greatly welcomed.  At a minimum, I could use
some programming reference guides for the 5045 and 5047 chips (and any
new chips as well).  If I need to sign an NDA, I am personally willing
to do so (I can't speak for the group), as long as it doesn't interfere
with our code development.

I'd also be interested in a test board that can plug into an Intel
motherboard with an HD audio test port.  If you have some, send me some
info on how to get them.

Thanks for your support,

Tobin Davis

On Fri, 2006-12-01 at 15:29 -0800, Eitan David wrote:
> All,
> 
> We at Conexant are interested in getting our customers the best
> possible support for their Linux Audio when using our chipset. We
> would like to understand what it is going to be needed from us in
> order to make sure our latest HD Audio based CODEC is supported by
> ALSA. As HDA is more generic interface, basic audio support is already
> available.
> 
> We would like to cooperate with ALSA and to supply the necessary
> documentation in order to make sure specific platform configurations
> are being supported. We do see today those specific features like
> Speakers to Headphones switching is not working properly on new system
> configurations.
> 
> Please advice on the best way to proceed.
> 
> Regards,
> 
> Eitan David
> 
> Director, PV Products Engineering
> 
> Conexant Systems Inc.
> 
> 
> 
> cnxtsmtp4.conexant.com made the following annotations
> ---------------------------------------------------------------------
> ********************** Legal Disclaimer ****************************
> "This email may contain confidential and privileged material for the
> sole use of the intended recipient. Any unauthorized review, use or
> distribution by others is strictly prohibited. If you have received
> the message in error, please advise the sender by reply email and
> delete the message. Thank you."
> **********************************************************************
> ---------------------------------------------------------------------
> 
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________ Alsa-devel mailing list Alsa-devel@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-5wf/lp4hTlI2VZlstd6Q
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY LINK="#0000ff">
Hello and welcome. <BR>
<BR>
 I am the person that has been developing the audio support for your current products.&nbsp; Unfortunately, I don't have access to any systems with your audio codec in them, except through a group of dedicated users that have been willing to help test my driver.<BR>
<BR>
You are correct in that some systems do not properly mute the speakers, while other systems do mute the speakers.&nbsp; I hope this is just an implementation issue, and not some external hardware thing.&nbsp; I have a detailed list of what systems/features work and what doesn't.&nbsp; Other issues have been attributed to broken acpi support and that development team has been notified.<BR>
<BR>
Since this project is open source, any changes/enhancements you would like to contribute would be greatly welcomed.&nbsp; At a minimum, I could use some programming reference guides for the 5045 and 5047 chips (and any new chips as well).&nbsp; If I need to sign an NDA, I am <U><I>personally</I></U> willing to do so (I can't speak for the group), as long as it doesn't interfere with our code development.<BR>
<BR>
I'd also be interested in a test board that can plug into an Intel motherboard with an HD audio test port.&nbsp; If you have some, send me some info on how to get them.<BR>
<BR>
Thanks for your support,<BR>
<BR>
Tobin Davis<BR>
<BR>
On Fri, 2006-12-01 at 15:29 -0800, Eitan David wrote:
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">All,</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">We at Conexant are interested in getting our customers the best possible support for their Linux Audio when using our chipset. We would like to understand what it is going to be needed from us in order to make sure our latest HD Audio based CODEC is supported by ALSA. As HDA is more generic interface, basic audio support is already available.</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">We would like to cooperate with ALSA and to supply the necessary documentation in order to make sure specific platform configurations are being supported. We do see today those specific features like Speakers to Headphones switching is not working properly on new system configurations.</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">Please advice on the best way to proceed.</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">Regards,</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">Eitan David</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">Director, PV Products Engineering</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">Conexant Systems Inc.</FONT></FONT><BR>
    <BR>
    <BR>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">cnxtsmtp4.conexant.com made the following annotations</FONT><BR>
    <FONT COLOR="#000000">---------------------------------------------------------------------</FONT><BR>
    <FONT COLOR="#000000">********************** Legal Disclaimer **************************** &quot;This email may contain confidential and privileged material for the sole use of the intended recipient. Any unauthorized review, use or distribution by others is strictly prohibited. If you have received the message in error, please advise the sender by reply email and delete the message. Thank you.&quot; ********************************************************************** ---------------------------------------------------------------------</FONT><BR>
    <BR>
    <BR>
<PRE>
<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">opinions on IT &amp; business topics through brief surveys - and earn cash</FONT>
<FONT COLOR="#000000"><A HREF="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</A></FONT>
<FONT COLOR="#000000">_______________________________________________ Alsa-devel mailing list <A HREF="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</A> <A HREF="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</A></FONT>
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

--=-5wf/lp4hTlI2VZlstd6Q--



--===============0281531643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0281531643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0281531643==--
