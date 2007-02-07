From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Bluetooth audio driver causing kernel oops
	with	alsa-driver-hg20070206
Date: Wed, 07 Feb 2007 10:53:25 -0800
Message-ID: <1170874405.28278.352.camel@localhost>
References: <5FD5754DDBA0B1499B5A0B4BB541948585D5D7@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0696565380=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <5FD5754DDBA0B1499B5A0B4BB541948585D5D7@fmsmsx411.amr.corp.intel.com>
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


--===============0696565380==
Content-Type: multipart/alternative; boundary="=-Qlg/LyYN9ewJs7Zx3YEr"


--=-Qlg/LyYN9ewJs7Zx3YEr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

It appears to be a dead project on sourceforge.  Here's the link:
http://bluetooth-alsa.sourceforge.net/

Tobin

On Wed, 2007-02-07 at 10:06 -0800, Allyn, Mark A wrote:
> Hello:
>  
> I have tried the snapshot, alsa-driver-hg20070206, on a system running
> Red Flag and that has a sigmatel 2202 Codec on the Intel-hda device.
> The kernel is 2.6.17.
>  
> The enclosed dmesg output shows a kernel oops that happened when I
> tried to run the alsaconf command. It appears that the problem is in
> the snd_bt_sco_volume_get function (which is within the btsco
> driver). 
>  
> I am wondering, can this be due to a structure mismatch between the
> btsco driver and the Alsa tree? I tried searching for btsco within
> alsa and could not find it. 
>  
> Who is responsible for the btsco audio driver?
>  
> Thank you
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

--=-Qlg/LyYN9ewJs7Zx3YEr
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
It appears to be a dead project on sourceforge.&nbsp; Here's the link:&nbsp; <A HREF="http://bluetooth-alsa.sourceforge.net/">http://bluetooth-alsa.sourceforge.net/</A><BR>
<BR>
Tobin<BR>
<BR>
On Wed, 2007-02-07 at 10:06 -0800, Allyn, Mark A wrote:
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Hello:</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">I have tried the snapshot, alsa-driver-hg20070206, on a system running Red Flag and that has a sigmatel 2202 Codec on the Intel-hda device. The kernel is 2.6.17.</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">The enclosed dmesg output shows a kernel oops that happened when I tried to run the alsaconf command. It appears that the problem is in the snd_bt_sco_volume_get function (which is within the btsco driver). </FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">I am wondering, can this be due to a structure mismatch between the btsco driver and the Alsa tree? I tried searching for btsco within alsa and could not find it. </FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Who is responsible for the btsco audio driver?</FONT></FONT>
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

--=-Qlg/LyYN9ewJs7Zx3YEr--



--===============0696565380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0696565380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0696565380==--
