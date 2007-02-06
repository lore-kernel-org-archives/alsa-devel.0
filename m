From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Relationship between bluttooth audio,
	usb audio	and alsa drivers
Date: Tue, 06 Feb 2007 15:13:44 -0800
Message-ID: <1170803624.28278.310.camel@localhost>
References: <5FD5754DDBA0B1499B5A0B4BB541948585D079@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1650743015=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <5FD5754DDBA0B1499B5A0B4BB541948585D079@fmsmsx411.amr.corp.intel.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Allyn, Mark A" <mark.a.allyn@intel.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1650743015==
Content-Type: multipart/alternative; boundary="=-Ti2zk1Idd8HxYSl7xA6h"


--=-Ti2zk1Idd8HxYSl7xA6h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

There has been a lot of changes to the usb audio drivers since 14rc2
release.  You might try this daily snapshot:
ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/alsa-driver-hg20070206.tar.bz2

I know the usb camera issue was discussed last week, and fixes are in
the repository.

Tobin

On Tue, 2007-02-06 at 14:50 -0800, Allyn, Mark A wrote:
> Hello:
>  
> I am having an interesting situation where I have upgraded the audio
> drivers, library, and utils from 1.0.10 to the current dev release of
> 1.0.14rc2 and ended up breaking the bluetooth audio and usb audio
> drivers.
>  
> The device that I have is an Intel HDA device with
> the STAC 9202 Codec. When I attempted to run alsaconf, it would cause
> a kernel oops within the blutooth audio driver. When I took that audio
> driver out (deleted it and then re-ran depmod), then I found a kernel
> oops in the usb audio driver (which accesses the microphone in a USB
> camera). When I deleted that driver, I was able to run the alsaconf
> command.
>  
> How are the bluetooth and usb audio drivers integrated with alsa? If I
> do a find within alsa, I do not find any source files for the
> bluetooth driver. How does that driver know the data structures of the
> alsa that is installed? What do I have to re-compile upon installing a
> new alsa besides the alsa-driver, alsa-library, and alsa-utils
> components of the newest alsa from the alsa download site?
>  
> Thank you
>  
> Truly,
>  
> Mark Allyn
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier.
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________ Alsa-devel mailing list Alsa-devel@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-Ti2zk1Idd8HxYSl7xA6h
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
There has been a lot of changes to the usb audio drivers since 14rc2 release.&nbsp; You might try this daily snapshot:&nbsp; <A HREF="ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/alsa-driver-hg20070206.tar.bz2">ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/alsa-driver-hg20070206.tar.bz2</A><BR>
<BR>
I know the usb camera issue was discussed last week, and fixes are in the repository.<BR>
<BR>
Tobin<BR>
<BR>
On Tue, 2007-02-06 at 14:50 -0800, Allyn, Mark A wrote:
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Hello:</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">I am having an interesting situation where I have upgraded the audio drivers, library, and utils from 1.0.10 to the current dev release of 1.0.14rc2 and ended up breaking the bluetooth audio and usb audio drivers.</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">The device that I have is an Intel HDA device with the&nbsp;STAC&nbsp;9202&nbsp;Codec. When I attempted to run alsaconf, it would cause a kernel oops within the blutooth audio driver. When I took that audio driver out (deleted it and then re-ran depmod), then I found a kernel oops in the usb audio driver (which accesses the microphone in a USB camera). When I deleted that driver, I was able to run the alsaconf command.</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">How are the bluetooth and usb audio drivers integrated with alsa? If I do a find within&nbsp;alsa, I do not find any source files for the bluetooth driver. How does that driver know the data structures of the alsa that is installed? What do I have to re-compile upon installing a new alsa besides the alsa-driver, alsa-library, and alsa-utils components of the newest alsa from the alsa download site?</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Thank you</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Truly,</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Mark Allyn</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Using Tomcat but need to do more? Need to support web services, security?</FONT>
<FONT COLOR="#000000">Get stuff done quickly with pre-integrated technology to make your job easier.</FONT>
<FONT COLOR="#000000">Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo</FONT>
<FONT COLOR="#000000"><A HREF="http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</A></FONT>
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

--=-Ti2zk1Idd8HxYSl7xA6h--



--===============1650743015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1650743015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1650743015==--
