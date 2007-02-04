From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: HDA-Intel headphone problem
Date: Sun, 04 Feb 2007 08:37:03 -0800
Message-ID: <1170607023.17686.15.camel@localhost>
References: <1170583847.6557.11.camel@hersel-r>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0178984387=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1170583847.6557.11.camel@hersel-r>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ralf Hersel <ralf.hersel@gmx.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0178984387==
Content-Type: multipart/alternative; boundary="=-ThMAVZUP8NsW+bk2hKH+"


--=-ThMAVZUP8NsW+bk2hKH+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2007-02-04 at 11:10 +0100, Ralf Hersel wrote:

> Hello
> 
> After reading hunderts of forum messages with no result I would like to
> ask you.
> 
> I'm not able to switch on the headphone jacks on my notebook.
> 
> Configuration:
> Notebook: HP Pavilion dv9097ea
> Jack layout on front: 1 Mic-in, 1 Audio-out chinch, 1 Audio-SPDIF-out
> chinch
> 
> Soundcard and Codec:
> 	ralf@hersel-r:~$ cat /proc/asound/cards
> 	0 [Intel ]: HDA-Intel - HDA Intel
> 	HDA Intel at 0xde300000 irq 66
> 	1 [Headset ]: USB-Audio - Logitech USB Headset
> 	Logitech Logitech USB Headset at usb-0000:00:1d.0-2, full speed
> 
> 	ralf@hersel-r:~$ head -n 1 /proc/asound/card0/codec*
> 	Codec: Generic 14f1 ID 50
> 


Based on this line, you are running an older version of alsa-driver.
Partial support has been added in alsa-driver-1.0.14rc2, and I am
currently working on full functionality at this time.  I have added you
to my tester's mailing list, so you can be kept up with the development.
Email me directly if you have issues.

Start by downloading alsa-driver-1.0.14rc2.tar.bz2.  I'll send you a
separate email with instructions and the latest test patch.


-- 
Tobin Davis <tdavis@dsl-only.net>

--=-ThMAVZUP8NsW+bk2hKH+
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
On Sun, 2007-02-04 at 11:10 +0100, Ralf Hersel wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hello</FONT>

<FONT COLOR="#000000">After reading hunderts of forum messages with no result I would like to</FONT>
<FONT COLOR="#000000">ask you.</FONT>

<FONT COLOR="#000000">I'm not able to switch on the headphone jacks on my notebook.</FONT>

<FONT COLOR="#000000">Configuration:</FONT>
<FONT COLOR="#000000">Notebook: HP Pavilion dv9097ea</FONT>
<FONT COLOR="#000000">Jack layout on front: 1 Mic-in, 1 Audio-out chinch, 1 Audio-SPDIF-out</FONT>
<FONT COLOR="#000000">chinch</FONT>

<FONT COLOR="#000000">Soundcard and Codec:</FONT>
<FONT COLOR="#000000">	ralf@hersel-r:~$ cat /proc/asound/cards</FONT>
<FONT COLOR="#000000">	0 [Intel ]: HDA-Intel - HDA Intel</FONT>
<FONT COLOR="#000000">	HDA Intel at 0xde300000 irq 66</FONT>
<FONT COLOR="#000000">	1 [Headset ]: USB-Audio - Logitech USB Headset</FONT>
<FONT COLOR="#000000">	Logitech Logitech USB Headset at usb-0000:00:1d.0-2, full speed</FONT>

<FONT COLOR="#000000">	ralf@hersel-r:~$ head -n 1 /proc/asound/card0/codec*</FONT>
<FONT COLOR="#000000">	Codec: Generic 14f1 ID 50</FONT>

</PRE>
</BLOCKQUOTE>
<BR>
Based on this line, you are running an older version of alsa-driver.&nbsp; Partial support has been added in alsa-driver-1.0.14rc2, and I am currently working on full functionality at this time.&nbsp; I have added you to my tester's mailing list, so you can be kept up with the development.&nbsp; Email me directly if you have issues.<BR>
<BR>
Start by downloading alsa-driver-1.0.14rc2.tar.bz2.&nbsp; I'll send you a separate email with instructions and the latest test patch.<BR>
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

--=-ThMAVZUP8NsW+bk2hKH+--



--===============0178984387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0178984387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0178984387==--
