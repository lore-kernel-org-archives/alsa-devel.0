From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Digital Microphones (DMICS) on Intel HD
	Audiowith	Sigmatel Codecs
Date: Fri, 23 Feb 2007 20:13:00 -0800
Message-ID: <1172290380.1575.52.camel@razman.gruemaster.com>
References: <5FD5754DDBA0B1499B5A0B4BB54194859F6C08@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1041032697=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <5FD5754DDBA0B1499B5A0B4BB54194859F6C08@fmsmsx411.amr.corp.intel.com>
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


--===============1041032697==
Content-Type: multipart/alternative; boundary="=-1+BKDRYFjHX9IkDJ613R"


--=-1+BKDRYFjHX9IkDJ613R
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ok, I'll look into it.  Probably a misconfiguration in autoconfig.  Your
earlier email listed this as a 9202 codec.  I'll get the documentation
and go from there.

I'll still need the pci subsystem ID though.  
lspci -s 0:1b -vn will give you that.  

Tobin

On Fri, 2007-02-23 at 18:19 -0800, Allyn, Mark A wrote:

> Tobin:
>  
> I was unable to load the driver on this system. There was an error
> message from ALSA 
> (which I sent an earlier email on the list.
>  
> The lspci entry for the device is:
>  
> 00:1b.0 Class 0403: Intel Corporation 82801G (ICH7 Family) High
> Definition Audio
>  Controller (rev 02)
>  
> Here is the dmesg output from alsa when I attempted to get at the
> device. Because of 
> this, there is nothing in /proc/asound/card0 as /proc/asound/cards shows
> no cards.
> 
> ========================================================================
> ===
> 
> [17179585.428000] ALSA
> /mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
> ../alsa-kernel/pci/hda/hda_intel.c:696: codec_mask = 0x1
> [17179585.536000] ALSA
> /mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
> ../alsa-kernel/pci/hda/patch_sigmatel.c:1802: hda_codec: Unknown model
> for STAC9
> 25x, using BIOS defaults
> [17179585.540000] ALSA
> /mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
> ../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 07 bios
> pin conf
> ig 01c10014
> [17179585.544000] ALSA
> /mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
> ../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 08 bios
> pin conf
> ig 01410013
> [17179585.548000] ALSA
> /mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
> ../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0a bios
> pin conf
> ig 01210011
> [17179585.552000] ALSA
> /mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
> ../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0b bios
> pin conf
> ig 01a10021
> [17179585.556000] ALSA
> /mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
> ../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0c bios
> pin conf
> ig 01810022
> [17179585.560000] ALSA
> /mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
> ../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0d bios
> pin conf
> ig 01010012
> [17179585.564000] ALSA
> /mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
> ../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 10 bios
> pin conf
> ig 01010031
> [17179585.568000] ALSA
> /mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
> ../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 11 bios
> pin conf
> ig 01310023
> [17179585.608000] ALSA
> /mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda
> _codec.c:2171: autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0)
> [17179585.608000] ALSA
> /mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda
> _codec.c:2175:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [17179585.608000] ALSA
> /mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda
> _codec.c:2179:    hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
> [17179585.608000] ALSA
> /mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda
> _codec.c:2187:    inputs: mic=0xb, fmic=0x0, line=0xc, fline=0x0,
> cd=0x11, aux=0
> x0
> [17179585.696000] ALSA
> /mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/acore/contr
> ol.c:333: control 2:0:0:Master Playback Volume:0 is already present
> [17179585.696000] HDA Intel: probe of 0000:00:1b.0 failed with error -16
> 
> Mark
> 
> ________________________________
> 
> From: Tobin Davis [mailto:tdavis@dsl-only.net] 
> Sent: Friday, February 23, 2007 3:54 PM
> To: Allyn, Mark A
> Cc: alsa-devel@lists.sourceforge.net; mporter@embeddedalley.com
> Subject: Re: [Alsa-devel] Digital Microphones (DMICS) on Intel HD
> Audiowith Sigmatel Codecs
> 
> 
> I think Matt Porter was working on some systems with that last year.
> Not sure what happened to him, as I haven't seen any patches since early
> January.  He submitted some digital mic patches against the 9205 codec
> code.
> 
> I could probably whip something together for you next week.  Send me the
> system specs (lspci -s 0:1b -vn and cat /proc/asound/card0/codec*) and
> I'll get on it.
> 
> Tobin
> 
> On Fri, 2007-02-23 at 15:37 -0800, Allyn, Mark A wrote: 
> 
> 	Hello:
> 	 
> 	Do any of you know if anyone has ever had alsa working with a
> digital
> 	microphone
> 	on a Sigmatel Codec within the Intel HAD device working; ie; a
> digital
> 	microphone
> 	only, that does not go through the normal analog input and mux?
> 	
> 	Thank you
> 	
> 	Mark Allyn
> 	
> 	
> ------------------------------------------------------------------------
> -
> 	Take Surveys. Earn Cash. Influence the Future of IT
> 	Join SourceForge.net's Techsay panel and you'll get the chance
> to share your
> 	opinions on IT & business topics through brief surveys-and earn
> cash
> 	
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
> V
> 	_______________________________________________
> 	Alsa-devel mailing list
> 	Alsa-devel@lists.sourceforge.net
> 	https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 	
> 

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-1+BKDRYFjHX9IkDJ613R
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
Ok, I'll look into it.&nbsp; Probably a misconfiguration in autoconfig.&nbsp; Your earlier email listed this as a 9202 codec.&nbsp; I'll get the documentation and go from there.<BR>
<BR>
I'll still need the pci subsystem ID though.&nbsp; <BR>
lspci -s 0:1b -vn will give you that.&nbsp; <BR>
<BR>
Tobin<BR>
<BR>
On Fri, 2007-02-23 at 18:19 -0800, Allyn, Mark A wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Tobin:</FONT>
<FONT COLOR="#000000"> </FONT>
<FONT COLOR="#000000">I was unable to load the driver on this system. There was an error</FONT>
<FONT COLOR="#000000">message from ALSA </FONT>
<FONT COLOR="#000000">(which I sent an earlier email on the list.</FONT>
<FONT COLOR="#000000"> </FONT>
<FONT COLOR="#000000">The lspci entry for the device is:</FONT>
<FONT COLOR="#000000"> </FONT>
<FONT COLOR="#000000">00:1b.0 Class 0403: Intel Corporation 82801G (ICH7 Family) High</FONT>
<FONT COLOR="#000000">Definition Audio</FONT>
<FONT COLOR="#000000"> Controller (rev 02)</FONT>
<FONT COLOR="#000000"> </FONT>
<FONT COLOR="#000000">Here is the dmesg output from alsa when I attempted to get at the</FONT>
<FONT COLOR="#000000">device. Because of </FONT>
<FONT COLOR="#000000">this, there is nothing in /proc/asound/card0 as /proc/asound/cards shows</FONT>
<FONT COLOR="#000000">no cards.</FONT>

<FONT COLOR="#000000">========================================================================</FONT>
<FONT COLOR="#000000">===</FONT>

<FONT COLOR="#000000">[17179585.428000] ALSA</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../</FONT>
<FONT COLOR="#000000">../alsa-kernel/pci/hda/hda_intel.c:696: codec_mask = 0x1</FONT>
<FONT COLOR="#000000">[17179585.536000] ALSA</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../</FONT>
<FONT COLOR="#000000">../alsa-kernel/pci/hda/patch_sigmatel.c:1802: hda_codec: Unknown model</FONT>
<FONT COLOR="#000000">for STAC9</FONT>
<FONT COLOR="#000000">25x, using BIOS defaults</FONT>
<FONT COLOR="#000000">[17179585.540000] ALSA</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../</FONT>
<FONT COLOR="#000000">../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 07 bios</FONT>
<FONT COLOR="#000000">pin conf</FONT>
<FONT COLOR="#000000">ig 01c10014</FONT>
<FONT COLOR="#000000">[17179585.544000] ALSA</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../</FONT>
<FONT COLOR="#000000">../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 08 bios</FONT>
<FONT COLOR="#000000">pin conf</FONT>
<FONT COLOR="#000000">ig 01410013</FONT>
<FONT COLOR="#000000">[17179585.548000] ALSA</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../</FONT>
<FONT COLOR="#000000">../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0a bios</FONT>
<FONT COLOR="#000000">pin conf</FONT>
<FONT COLOR="#000000">ig 01210011</FONT>
<FONT COLOR="#000000">[17179585.552000] ALSA</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../</FONT>
<FONT COLOR="#000000">../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0b bios</FONT>
<FONT COLOR="#000000">pin conf</FONT>
<FONT COLOR="#000000">ig 01a10021</FONT>
<FONT COLOR="#000000">[17179585.556000] ALSA</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../</FONT>
<FONT COLOR="#000000">../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0c bios</FONT>
<FONT COLOR="#000000">pin conf</FONT>
<FONT COLOR="#000000">ig 01810022</FONT>
<FONT COLOR="#000000">[17179585.560000] ALSA</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../</FONT>
<FONT COLOR="#000000">../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0d bios</FONT>
<FONT COLOR="#000000">pin conf</FONT>
<FONT COLOR="#000000">ig 01010012</FONT>
<FONT COLOR="#000000">[17179585.564000] ALSA</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../</FONT>
<FONT COLOR="#000000">../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 10 bios</FONT>
<FONT COLOR="#000000">pin conf</FONT>
<FONT COLOR="#000000">ig 01010031</FONT>
<FONT COLOR="#000000">[17179585.568000] ALSA</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../</FONT>
<FONT COLOR="#000000">../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 11 bios</FONT>
<FONT COLOR="#000000">pin conf</FONT>
<FONT COLOR="#000000">ig 01310023</FONT>
<FONT COLOR="#000000">[17179585.608000] ALSA</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda</FONT>
<FONT COLOR="#000000">_codec.c:2171: autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0)</FONT>
<FONT COLOR="#000000">[17179585.608000] ALSA</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda</FONT>
<FONT COLOR="#000000">_codec.c:2175:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)</FONT>
<FONT COLOR="#000000">[17179585.608000] ALSA</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda</FONT>
<FONT COLOR="#000000">_codec.c:2179:    hp_outs=1 (0xa/0x0/0x0/0x0/0x0)</FONT>
<FONT COLOR="#000000">[17179585.608000] ALSA</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda</FONT>
<FONT COLOR="#000000">_codec.c:2187:    inputs: mic=0xb, fmic=0x0, line=0xc, fline=0x0,</FONT>
<FONT COLOR="#000000">cd=0x11, aux=0</FONT>
<FONT COLOR="#000000">x0</FONT>
<FONT COLOR="#000000">[17179585.696000] ALSA</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/acore/contr</FONT>
<FONT COLOR="#000000">ol.c:333: control 2:0:0:Master Playback Volume:0 is already present</FONT>
<FONT COLOR="#000000">[17179585.696000] HDA Intel: probe of 0000:00:1b.0 failed with error -16</FONT>

<FONT COLOR="#000000">Mark</FONT>

<FONT COLOR="#000000">________________________________</FONT>

<FONT COLOR="#000000">From: Tobin Davis [mailto:<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>] </FONT>
<FONT COLOR="#000000">Sent: Friday, February 23, 2007 3:54 PM</FONT>
<FONT COLOR="#000000">To: Allyn, Mark A</FONT>
<FONT COLOR="#000000">Cc: <A HREF="mailto:alsa-devel@lists.sourceforge.net">alsa-devel@lists.sourceforge.net</A>; <A HREF="mailto:mporter@embeddedalley.com">mporter@embeddedalley.com</A></FONT>
<FONT COLOR="#000000">Subject: Re: [Alsa-devel] Digital Microphones (DMICS) on Intel HD</FONT>
<FONT COLOR="#000000">Audiowith Sigmatel Codecs</FONT>


<FONT COLOR="#000000">I think Matt Porter was working on some systems with that last year.</FONT>
<FONT COLOR="#000000">Not sure what happened to him, as I haven't seen any patches since early</FONT>
<FONT COLOR="#000000">January.  He submitted some digital mic patches against the 9205 codec</FONT>
<FONT COLOR="#000000">code.</FONT>

<FONT COLOR="#000000">I could probably whip something together for you next week.  Send me the</FONT>
<FONT COLOR="#000000">system specs (lspci -s 0:1b -vn and cat /proc/asound/card0/codec*) and</FONT>
<FONT COLOR="#000000">I'll get on it.</FONT>

<FONT COLOR="#000000">Tobin</FONT>

<FONT COLOR="#000000">On Fri, 2007-02-23 at 15:37 -0800, Allyn, Mark A wrote: </FONT>

<FONT COLOR="#000000">	Hello:</FONT>
<FONT COLOR="#000000">	 </FONT>
<FONT COLOR="#000000">	Do any of you know if anyone has ever had alsa working with a</FONT>
<FONT COLOR="#000000">digital</FONT>
<FONT COLOR="#000000">	microphone</FONT>
<FONT COLOR="#000000">	on a Sigmatel Codec within the Intel HAD device working; ie; a</FONT>
<FONT COLOR="#000000">digital</FONT>
<FONT COLOR="#000000">	microphone</FONT>
<FONT COLOR="#000000">	only, that does not go through the normal analog input and mux?</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	Thank you</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	Mark Allyn</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">-</FONT>
<FONT COLOR="#000000">	Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">	Join SourceForge.net's Techsay panel and you'll get the chance</FONT>
<FONT COLOR="#000000">to share your</FONT>
<FONT COLOR="#000000">	opinions on IT &amp; business topics through brief surveys-and earn</FONT>
<FONT COLOR="#000000">cash</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000"><A HREF="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDE</A></FONT>
<FONT COLOR="#000000">V</FONT>
<FONT COLOR="#000000">	_______________________________________________</FONT>
<FONT COLOR="#000000">	Alsa-devel mailing list</FONT>
<FONT COLOR="#000000">	<A HREF="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</A></FONT>
<FONT COLOR="#000000">	<A HREF="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</A></FONT>
<FONT COLOR="#000000">	</FONT>

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

--=-1+BKDRYFjHX9IkDJ613R--



--===============1041032697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1041032697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1041032697==--
