From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Latest patch for Conexant HD Audio
Date: Tue, 13 Feb 2007 08:02:44 -0800
Message-ID: <1171382564.715.170.camel@localhost.gruemaster.com>
References: <1171323523.715.115.camel@localhost.gruemaster.com>
	<s5h1wkue0jq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1318188585=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h1wkue0jq.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1318188585==
Content-Type: multipart/alternative; boundary="=-tGz4fd3DK4R+55xnppIH"


--=-tGz4fd3DK4R+55xnppIH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-02-13 at 12:53 +0100, Takashi Iwai wrote:

> At Mon, 12 Feb 2007 15:38:43 -0800,
> Tobin Davis wrote:
> > 
> > Summary:  More fixes for Conexant HD Audio support.
> > 
> > Renamed Conexant 5045 to CX20549 (Venice) per Conexant Documentation
> > Renamed Conexant 5047 to CX20551 (Waikiki) per Conexant Documentation
> > Fixed automute on HP Laptops with CX20551 codec.
> > Fixed recording issues on Toshiba Satelite P100/P105 series laptops
> > Added HP DV8000, DV2000Z, Fujitsu Si1520 support
> > 
> > More work to be done on CX20549 based systems, but CX20551 Systems are much better
> > now.
> > 
> > Signed off by Tobin Davis <tdavis@dsl-only.net>
> 
> Applied after minor fixes:
> - fix wrong '&' and '|' to '&&' and '||', together with slight cleanups 
> - fold lines in 80 chars
> 
> Please check whether the latest HG tree is OK for you.
> 
> 

Looks good to me.  I've sent it to the testers for verification and to
update their base code for future work.

Thanks,

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-tGz4fd3DK4R+55xnppIH
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
On Tue, 2007-02-13 at 12:53 +0100, Takashi Iwai wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">At Mon, 12 Feb 2007 15:38:43 -0800,</FONT>
<FONT COLOR="#000000">Tobin Davis wrote:</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Summary:  More fixes for Conexant HD Audio support.</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Renamed Conexant 5045 to CX20549 (Venice) per Conexant Documentation</FONT>
<FONT COLOR="#000000">&gt; Renamed Conexant 5047 to CX20551 (Waikiki) per Conexant Documentation</FONT>
<FONT COLOR="#000000">&gt; Fixed automute on HP Laptops with CX20551 codec.</FONT>
<FONT COLOR="#000000">&gt; Fixed recording issues on Toshiba Satelite P100/P105 series laptops</FONT>
<FONT COLOR="#000000">&gt; Added HP DV8000, DV2000Z, Fujitsu Si1520 support</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; More work to be done on CX20549 based systems, but CX20551 Systems are much better</FONT>
<FONT COLOR="#000000">&gt; now.</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Signed off by Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;</FONT>

<FONT COLOR="#000000">Applied after minor fixes:</FONT>
<FONT COLOR="#000000">- fix wrong '&amp;' and '|' to '&amp;&amp;' and '||', together with slight cleanups </FONT>
<FONT COLOR="#000000">- fold lines in 80 chars</FONT>

<FONT COLOR="#000000">Please check whether the latest HG tree is OK for you.</FONT>


</PRE>
</BLOCKQUOTE>
Looks good to me.&nbsp; I've sent it to the testers for verification and to update their base code for future work.<BR>
<BR>
Thanks,<BR>
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

--=-tGz4fd3DK4R+55xnppIH--



--===============1318188585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1318188585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1318188585==--
