From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Conexant
Date: Thu, 01 Feb 2007 16:34:06 -0800
Message-ID: <1170376446.8637.106.camel@localhost>
References: <loom.20070202T005635-102@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-nk6BW+Ar+1Gqyk3vOhYV"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <loom.20070202T005635-102@post.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ligu <theligu@gmail.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-nk6BW+Ar+1Gqyk3vOhYV
Content-Type: multipart/alternative; boundary="=-hOXEh4wxEyCSUgDsL722"


--=-hOXEh4wxEyCSUgDsL722
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2007-02-02 at 00:08 +0000, ligu wrote:

> ot sound today!
> I have a Toshiba P100-293 with the Conexant chip.
> After a bios update (3.30 from toshibas eu site),
> alsa 1.0.14rc2 (--with-cards=hda-intel) and
> a fixed dsdt, now I have sound even with acpi=on.
> The sound is not of the best quality but working! 

Glad to hear it.  I'm currently working on the driver (now that I have
documentation), and would welcome your input on what works/doesn't work.

Here's a checklist I'm sending to the other testers.  Fill it out and
send it directly to me (don't need to flood the devel mailing list).

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-hOXEh4wxEyCSUgDsL722
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
On Fri, 2007-02-02 at 00:08 +0000, ligu wrote:<BR>
<BLOCKQUOTE TYPE=CITE>
    <TT><FONT COLOR="#000000">ot sound today!</FONT></TT><BR>
    <TT><FONT COLOR="#000000">I have a Toshiba P100-293 with the Conexant chip.</FONT></TT><BR>
    <TT><FONT COLOR="#000000">After a bios update (3.30 from toshibas eu site),</FONT></TT><BR>
    <TT><FONT COLOR="#000000">alsa 1.0.14rc2 (--with-cards=hda-intel) and</FONT></TT><BR>
    <TT><FONT COLOR="#000000">a fixed dsdt, now I have sound even with acpi=on.</FONT></TT><BR>
    <TT><FONT COLOR="#000000">The sound is not of the best quality but working!</FONT></TT><FONT COLOR="#000000"> </FONT><BR>
</BLOCKQUOTE>
Glad to hear it.&nbsp; I'm currently working on the driver (now that I have documentation), and would welcome your input on what works/doesn't work.<BR>
<BR>
Here's a checklist I'm sending to the other testers.&nbsp; Fill it out and send it directly to me (don't need to flood the devel mailing list).<BR>
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

--=-hOXEh4wxEyCSUgDsL722--

--=-nk6BW+Ar+1Gqyk3vOhYV
Content-Disposition: attachment; filename=checklist.txt
Content-Type: text/plain; name=checklist.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

+------------------------------------------------------------------------------+
| System Model  			   |                                   |
+------------------------------------------------------------------------------+
|                               Internal Speakers                              |
+------------------------------------------+-----------------------------------+
| Produce sound?                           |                                   |
+------------------------------------------+-----------------------------------+
| Volume controlled by the Master channel? |                                   |
+------------------------------------------+-----------------------------------+
| Muted by muting the Master channel?      |                                   |
+------------------------------------------+-----------------------------------+
| Volume controlled by any other channel?  |                                   |
+------------------------------------------+-----------------------------------+
| Muted by muting any other channel?       |                                   |
+------------------------------------------+-----------------------------------+

+------------------------------------------------------------------------------+
|                               External Speakers                              |
+----------------------------------------------+-------------------------------+
| Produce sound?                               |                               |
+----------------------------------------------+-------------------------------+
| Volume controlled by the Headphones channel? |                               |
+----------------------------------------------+-------------------------------+
| Muted by muting the Headphones channel?      |                               |
+----------------------------------------------+-------------------------------+
| Volume controlled by any other channel?      |                               |
+----------------------------------------------+-------------------------------+
| Muted by muting any other channel?           |                               |
+----------------------------------------------+-------------------------------+

+------------------------------------------------------------------------------+
|                                  Internal Mic                                |
+------------------------------------------+-----------------------------------+
| Captures sound?                          |                                   |
+------------------------------------------+-----------------------------------+
| Volume controlled by the IntMic channel? |                                   |
+------------------------------------------+-----------------------------------+
| Muted by muting the IntMic channel?      |                                   |
+------------------------------------------+-----------------------------------+
| Mutes ExtMic when selected?              |                                   |
+------------------------------------------+-----------------------------------+

+------------------------------------------------------------------------------+
|                                  External Mic                                |
+------------------------------------------+-----------------------------------+
| Captures sound?                          |                                   |
+------------------------------------------+-----------------------------------+
| Volume controlled by the ExtMic channel? |                                   |
+------------------------------------------+-----------------------------------+
| Muted by muting the ExtMic channel?      |                                   |
+------------------------------------------+-----------------------------------+
| Mutes IntMic when selected?              |                                   |
+------------------------------------------+-----------------------------------+

+------------------------------------------------------------------------------+
|                               Physical Controls                              |
+--------------------------------------------------------+---------------------+
| Mute works on selected channel (Master or Headphones)? |                     |
+--------------------------------------------------------+---------------------+
| Volume controlled by Up/Down buttons?                  |                     |
+--------------------------------------------------------+---------------------+
| The Up button unmutes channel if it was muted?         |                     |
+--------------------------------------------------------+---------------------+
| The Down button mutes channel if volume reaches 0%?    |                     |
+--------------------------------------------------------+---------------------+

--=-nk6BW+Ar+1Gqyk3vOhYV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-nk6BW+Ar+1Gqyk3vOhYV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-nk6BW+Ar+1Gqyk3vOhYV--
