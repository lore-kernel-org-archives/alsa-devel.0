From: Gabe Widmer <GWidmer@SigmaTel.com>
Subject: AC'97 HP out Register tied to Master out
Date: Thu, 27 Jun 2002 18:21:39 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F10A1AAA9A92D511B344000347426999CD7B00@SIGNTXCH01.sigmatel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C21E31.63BBD480"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from signtxch01.sigmatel.com (mail.sigmatel.com [65.240.84.54] (may be forged))
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA09107
	for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2002 01:24:14 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
Cc: David Roach <DRoach@SigmaTel.com>
List-Id: alsa-devel@alsa-project.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C21E31.63BBD480
Content-Type: text/plain;
	charset="ISO-8859-1"

I have to make a code change to the current released source to enable audio
so it will work correctly with the common mixers in most distros.  All AC'97
Windows drivers do this.  I'll spit the code back once I am done.  Many
AC'97 audio designs use the HPout pin instead of the Master out.  I also
noticed that there is a switch to enable this through amixer.  Anyway, the
code I change will be delivered to my customers and I will feed the code
back to you all.
 
Thanks, 

Gabe Widmer 
Software Developer 
SigmaTel Inc. 
gwidmer@sigmatel.com <mailto:gwidmer@sigmatel.com> 
512-381-3746 

 

------_=_NextPart_001_01C21E31.63BBD480
Content-Type: text/html;
	charset="ISO-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">


<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY>
<DIV><SPAN class=458331823-27062002><FONT size=2>I have to make a code change to 
the current released source to enable audio so it will work correctly with the 
common mixers in most distros.&nbsp; All AC'97 Windows drivers do this.&nbsp; 
I'll spit the code back once I am done.&nbsp; Many AC'97 audio designs use the 
HPout pin instead of the Master out.&nbsp; I also noticed that there is a switch 
to enable this through amixer.&nbsp; Anyway, the code I change will be delivered 
to my customers and I will feed the code back to you all.</FONT></SPAN></DIV>
<DIV><SPAN class=458331823-27062002><FONT size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=458331823-27062002><FONT 
size=2>Thanks,</FONT>&nbsp;</SPAN></DIV>
<P><FONT size=1><FONT color=#808000><FONT color=#000000 size=2>Gabe Widmer 
<BR>Software Developer <BR>SigmaTel Inc. <BR><A 
href="mailto:gwidmer@sigmatel.com">gwidmer@sigmatel.com</A></FONT></FONT></FONT><FONT 
size=1><FONT color=#808000><FONT color=#000000 size=2><BR>512-381-3746</FONT> 
</FONT></FONT></P>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C21E31.63BBD480--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
