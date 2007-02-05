From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: stac92xx_parse_auto_config() can return 0 on	error?
Date: Mon, 05 Feb 2007 14:29:53 -0800
Message-ID: <1170714593.28278.151.camel@localhost>
References: <Pine.LNX.4.64.0702051624060.26250@dhcp83-20.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-A1/YInV0LbnwDZ5UKrxR"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 70E662F6
	for <alsa-devel@alsa-project.org>; Mon,  5 Feb 2007 23:29:07 +0100 (MET)
In-Reply-To: <Pine.LNX.4.64.0702051624060.26250@dhcp83-20.boston.redhat.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jason Baron <jbaron@redhat.com>
Cc: alsa-devel@alsa-project.org, John Linville <linville@redhat.com>
List-Id: alsa-devel@alsa-project.org


--=-A1/YInV0LbnwDZ5UKrxR
Content-Type: multipart/alternative; boundary="=-EcUTdHu2oARpGmMKSW/P"


--=-EcUTdHu2oARpGmMKSW/P
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2007-02-05 at 16:40 -0500, Jason Baron wrote:

> hi,
> 
> I just ran into a RHEL4 U5 beta kernel oops in snd_hda_input_mux_info(), 
> because the 'imux' parameter pointer was NULL. I traced this back to 
> stac92xx_parse_auto_config(), which can return 0, if 'line_outs' is not 
> set, without having initialized the 'input_mux'.
> 
> The oops does not happen on the upstream kernel on this hardware b/c 
> 'line_outs' was set (additional code has been added since RHEL4 to set 
> it). However, it still appears to me, that if 'line_outs' is not set, we 
> should return an error code, and not 0.
> 
> thanks,
> 
> -Jason

Try this patch to see if it works with your alsa version.  It's a simple
patch that adds the error condition, and should be able to be applied to
older alsa versions.

Summary:  add error for undetected line_outs.

This adds an error condition to stac92xx_parse_auto_config if line_outs
is less than zero.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-EcUTdHu2oARpGmMKSW/P
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
On Mon, 2007-02-05 at 16:40 -0500, Jason Baron wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">hi,</FONT>

<FONT COLOR="#000000">I just ran into a RHEL4 U5 beta kernel oops in snd_hda_input_mux_info(), </FONT>
<FONT COLOR="#000000">because the 'imux' parameter pointer was NULL. I traced this back to </FONT>
<FONT COLOR="#000000">stac92xx_parse_auto_config(), which can return 0, if 'line_outs' is not </FONT>
<FONT COLOR="#000000">set, without having initialized the 'input_mux'.</FONT>

<FONT COLOR="#000000">The oops does not happen on the upstream kernel on this hardware b/c </FONT>
<FONT COLOR="#000000">'line_outs' was set (additional code has been added since RHEL4 to set </FONT>
<FONT COLOR="#000000">it). However, it still appears to me, that if 'line_outs' is not set, we </FONT>
<FONT COLOR="#000000">should return an error code, and not 0.</FONT>

<FONT COLOR="#000000">thanks,</FONT>

<FONT COLOR="#000000">-Jason</FONT>
</PRE>
</BLOCKQUOTE>
Try this patch to see if it works with your alsa version.&nbsp; It's a simple patch that adds the error condition, and should be able to be applied to older alsa versions.<BR>
<BR>
Summary:&nbsp; add error for undetected line_outs.<BR>
<BR>
This adds an error condition to stac92xx_parse_auto_config if line_outs is less than zero.<BR>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<BR>
Signed off by Tobin Davis &lt;tdavis@dsl-only.net&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-EcUTdHu2oARpGmMKSW/P--

--=-A1/YInV0LbnwDZ5UKrxR
Content-Disposition: attachment; filename=stax92xx-autocfg-fix.patch
Content-Type: text/x-patch; name=stax92xx-autocfg-fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r c783393557a8 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Wed Jan 24 16:13:35 2007 +0100
+++ b/pci/hda/patch_sigmatel.c	Mon Feb 05 14:24:57 2007 -0800
@@ -1375,8 +1375,8 @@ static int stac92xx_parse_auto_config(st
 						&spec->autocfg,
 						spec->dmic_nids)) < 0)
 		return err;
-	if (! spec->autocfg.line_outs)
-		return 0; /* can't find valid pin config */
+	if ((err = spec->autocfg.line_outs) < 0)
+		return err; /* can't find valid pin config */
 
 	if ((err = stac92xx_add_dyn_out_pins(codec, &spec->autocfg)) < 0)
 		return err;

--=-A1/YInV0LbnwDZ5UKrxR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-A1/YInV0LbnwDZ5UKrxR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-A1/YInV0LbnwDZ5UKrxR--
