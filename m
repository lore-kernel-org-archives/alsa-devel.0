From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Samsung Audio Problem (update)
Date: Tue, 05 Dec 2006 07:26:17 -0800
Message-ID: <1165332377.32312.142.camel@razman>
References: <5FD5754DDBA0B1499B5A0B4BB5419485292880@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0755947515=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <5FD5754DDBA0B1499B5A0B4BB5419485292880@fmsmsx411.amr.corp.intel.com>
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


--===============0755947515==
Content-Type: multipart/alternative; boundary="=-OgA6PXoHLHf+SarPRsAV"


--=-OgA6PXoHLHf+SarPRsAV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Could you send a couple of things to the mailing list?  Specifically,
recompile the driver with "--with-debug=detect", reinstall it, and send
the output from dmesg after installing the driver.  Also, send the
output from 'cat /proc/asound/card0/codec*'.

I have a laptop (Asus Z62F) with the exact same codec,   and I had to do
some fiddling with the alsamixer controls before I could use either the
internal mic or the external mic.  You might also check that.  The mic
gain is listed as an output for some reason (it's been marked as "fixme"
in the code for quite some time).

Tobin

On Mon, 2006-12-04 at 13:43 -0800, Allyn, Mark A wrote:

> Hello:
>  
> With thanks to Tobin Davis, I was able to resolve part of my problem.
> 
> With using the latest snapshot of the alsa driver as well as adding
> 
> options snd-hda-intel model=laptop-eapd
> 
> to the /etc/modprobe.conf file, I was able to get rid of the high
> pitched
> squeal and have proper audio playback on the internal speakers.
> 
> I am still unable to record. For your benefit, I do have some more
> Information on the audio device. From the lspci -qn, I got:
> 
> Class: 0403
> 8086:2668	rev03
> Subsystem: 144D:C027
> 
> Has anyone got audio recording working on this codec and subsystem?
> 
> Thank you
> 
> Mark Allyn
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-OgA6PXoHLHf+SarPRsAV
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Could you send a couple of things to the mailing list?&nbsp; Specifically, recompile the driver with &quot;--with-debug=detect&quot;, reinstall it, and send the output from dmesg after installing the driver.&nbsp; Also, send the output from 'cat /proc/asound/card0/codec*'.<BR>
<BR>
I have a laptop (Asus Z62F) with the exact same codec,&nbsp;&nbsp; and I had to do some fiddling with the alsamixer controls before I could use either the internal mic or the external mic.&nbsp; You might also check that.&nbsp; The mic gain is listed as an output for some reason (it's been marked as &quot;fixme&quot; in the code for quite some time).<BR>
<BR>
Tobin<BR>
<BR>
On Mon, 2006-12-04 at 13:43 -0800, Allyn, Mark A wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hello:</FONT>
<FONT COLOR="#000000"> </FONT>
<FONT COLOR="#000000">With thanks to Tobin Davis, I was able to resolve part of my problem.</FONT>

<FONT COLOR="#000000">With using the latest snapshot of the alsa driver as well as adding</FONT>

<FONT COLOR="#000000">options snd-hda-intel model=laptop-eapd</FONT>

<FONT COLOR="#000000">to the /etc/modprobe.conf file, I was able to get rid of the high</FONT>
<FONT COLOR="#000000">pitched</FONT>
<FONT COLOR="#000000">squeal and have proper audio playback on the internal speakers.</FONT>

<FONT COLOR="#000000">I am still unable to record. For your benefit, I do have some more</FONT>
<FONT COLOR="#000000">Information on the audio device. From the lspci -qn, I got:</FONT>

<FONT COLOR="#000000">Class: 0403</FONT>
<FONT COLOR="#000000">8086:2668	rev03</FONT>
<FONT COLOR="#000000">Subsystem: 144D:C027</FONT>

<FONT COLOR="#000000">Has anyone got audio recording working on this codec and subsystem?</FONT>

<FONT COLOR="#000000">Thank you</FONT>

<FONT COLOR="#000000">Mark Allyn</FONT>

<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">opinions on IT &amp; business topics through brief surveys - and earn cash</FONT>
<FONT COLOR="#000000"><A HREF="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</A></FONT>
<FONT COLOR="#000000">_______________________________________________</FONT>
<FONT COLOR="#000000">Alsa-devel mailing list</FONT>
<FONT COLOR="#000000"><A HREF="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</A></FONT>
<FONT COLOR="#000000"><A HREF="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</A></FONT>
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

--=-OgA6PXoHLHf+SarPRsAV--



--===============0755947515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0755947515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0755947515==--
