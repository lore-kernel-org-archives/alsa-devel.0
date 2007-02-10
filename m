From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Questions on STAC 9202
Date: Fri, 09 Feb 2007 16:07:56 -0800
Message-ID: <1171066076.12040.15.camel@razman.gruemaster.com>
References: <5FD5754DDBA0B1499B5A0B4BB54194858D0D3B@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0394725935=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <5FD5754DDBA0B1499B5A0B4BB54194858D0D3B@fmsmsx411.amr.corp.intel.com>
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


--===============0394725935==
Content-Type: multipart/alternative; boundary="=-h1Hi9AEvKga1w84mG/X2"


--=-h1Hi9AEvKga1w84mG/X2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I added that section of code, and at the time I didn't have any systems
with the dmic.  It could easily be added into the 9250 section, as the
9251 has it also.

Tobin

On Fri, 2007-02-09 at 14:55 -0800, Allyn, Mark A wrote:
> Hi:
>  
> I am working on a system with a STAC 9202 device.
>  
> Looking at the code in the 1.0.14rc2 release, in the patch_sigmatel
> file, I notice that the STAC 9202 configurations are bundled together
> with the STAC 9250 series. 
>  
> Although the NID's seem to be the same for the input and output pins,
> the information on the DMIC pin seems to be missing from the
> definitions on the stac 9250 series. (The NID for the digital mic is
> 0x15). 
>  
> The device I have uses the DMIC for the only input; none of the other
> pins are used for an input.
>  
> I am attempting to create another section in the patch_sigmatel file
> specifically for the STAC 9202 device that includes the DMIC nid. 
>  
> Do any of you know if alsa has sucessfuly supported a sigmatel codec
> with a DMIC input?
>  
> Thank you
>  
> Mark
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier.
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________ Alsa-devel mailing list Alsa-devel@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-h1Hi9AEvKga1w84mG/X2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
I added that section of code, and at the time I didn't have any systems with the dmic.&nbsp; It could easily be added into the 9250 section, as the 9251 has it also.<BR>
<BR>
Tobin<BR>
<BR>
On Fri, 2007-02-09 at 14:55 -0800, Allyn, Mark A wrote:
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Hi:</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">I am working on a system with a&nbsp;STAC 9202 device.</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Looking at the code in the 1.0.14rc2 release, in the patch_sigmatel file, I notice that the STAC 9202 configurations are bundled together with the STAC 9250 series. </FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Although the NID's seem to be the same for the input and output pins, the information on the DMIC pin seems to be missing from the definitions on the stac 9250 series. (The NID for the digital mic is 0x15). </FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">The device I have uses the DMIC for the only input; none of the other pins are used for an input.</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">I am attempting to create another section in the patch_sigmatel file specifically for the STAC 9202 device that includes the DMIC nid. </FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Do any of you know if alsa has sucessfuly supported a sigmatel codec with a DMIC input?</FONT></FONT>
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
    <FONT SIZE="2"><FONT COLOR="#000000">Mark</FONT></FONT>
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

--=-h1Hi9AEvKga1w84mG/X2--



--===============0394725935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0394725935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0394725935==--
