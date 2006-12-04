From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Samsung Q1 (Analog Device AD1986A Codec)
	High	Pitched Tone & Inability to Record
Date: Mon, 04 Dec 2006 09:15:16 -0800
Message-ID: <1165252516.32312.74.camel@razman>
References: <5FD5754DDBA0B1499B5A0B4BB541948529241E@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1826161637=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <5FD5754DDBA0B1499B5A0B4BB541948529241E@fmsmsx411.amr.corp.intel.com>
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


--===============1826161637==
Content-Type: multipart/alternative; boundary="=-AgFT6g7lj05ieGIjlfXc"


--=-AgFT6g7lj05ieGIjlfXc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey, Mark.

Have you tried a newer alsa snapshot?  There has been a lot of changes
since 1.0.13.  You can get a daily snapshot here:
ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/
Start with that version, and try some of the different model parameters
(model=laptop and model=laptop-eapd) to see which works best.

Also, please post the subsystem id for that chip.  You can get it with
'lspci -s 0:1b -vn".  I'll get it added to the driver if it isn't
already listed.

Tobin

On Mon, 2006-12-04 at 08:59 -0800, Allyn, Mark A wrote:

> Hello:
>  
> I have a Samsung Q1 Ultra Mobile PC with an Analog Devices AD1986A Codec
> 
> (according to /proc/asound/card0/codec#2). 
>  
> We are using the Alsa 1.0.13 driver. We are unable to record using 
> the built-in internal microphones. 
>  
> Also, when we try to use the internal speakers, we are getting a 
> high pitched sound (above 9 Khz) from the speakers. Using headphones 
> plugged into the headphone jack seems to work okay.
>  
> Has anyone been able to get 1.0.13 working properly on the Samsung Q1?
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

--=-AgFT6g7lj05ieGIjlfXc
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Hey, Mark.<BR>
<BR>
Have you tried a newer alsa snapshot?&nbsp; There has been a lot of changes since 1.0.13.&nbsp; You can get a daily snapshot here:&nbsp; <A HREF="ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/">ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/</A><BR>
Start with that version, and try some of the different model parameters (model=laptop and model=laptop-eapd) to see which works best.<BR>
<BR>
Also, please post the subsystem id for that chip.&nbsp; You can get it with 'lspci -s 0:1b -vn&quot;.&nbsp; I'll get it added to the driver if it isn't already listed.<BR>
<BR>
Tobin<BR>
<BR>
On Mon, 2006-12-04 at 08:59 -0800, Allyn, Mark A wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hello:</FONT>
<FONT COLOR="#000000"> </FONT>
<FONT COLOR="#000000">I have a Samsung Q1 Ultra Mobile PC with an Analog Devices AD1986A Codec</FONT>

<FONT COLOR="#000000">(according to /proc/asound/card0/codec#2). </FONT>
<FONT COLOR="#000000"> </FONT>
<FONT COLOR="#000000">We are using the Alsa 1.0.13 driver. We are unable to record using </FONT>
<FONT COLOR="#000000">the built-in internal microphones. </FONT>
<FONT COLOR="#000000"> </FONT>
<FONT COLOR="#000000">Also, when we try to use the internal speakers, we are getting a </FONT>
<FONT COLOR="#000000">high pitched sound (above 9 Khz) from the speakers. Using headphones </FONT>
<FONT COLOR="#000000">plugged into the headphone jack seems to work okay.</FONT>
<FONT COLOR="#000000"> </FONT>
<FONT COLOR="#000000">Has anyone been able to get 1.0.13 working properly on the Samsung Q1?</FONT>
<FONT COLOR="#000000"> </FONT>
<FONT COLOR="#000000">Thank you</FONT>
<FONT COLOR="#000000"> </FONT>
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

--=-AgFT6g7lj05ieGIjlfXc--



--===============1826161637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1826161637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1826161637==--
