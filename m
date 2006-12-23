From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Asus P5W DH Deluxe 's intel-hda unknown in codec
Date: Fri, 22 Dec 2006 22:29:42 -0800
Message-ID: <1166855382.12749.14.camel@localhost>
References: <1166846854.11797.49.camel@localhost>
	<1166848557.10168.11.camel@localhost>
	<1166852925.11797.66.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1551213094=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1166852925.11797.66.camel@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1551213094==
Content-Type: multipart/alternative; boundary="=-QFEHohsKXCZ4PMpVhRJ3"


--=-QFEHohsKXCZ4PMpVhRJ3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> I tried model=6stck-dig, I'm sorry (it's a typo in the hda_codec.txt
> which comes with the kernel)

I've fixed it and will get it upstream in another email, thanks.


> with 6stack-dig, the module accept the option but I get (it seems) the
> same controls as bios-tried, so not any master control (maybe there is
> no such control on this board, I don't know, but I think it should be)
> I've tried 6stack-dig, 3stack-dig, and arima but it's 6stack-dig (or
> bios) that fit the best.

I'll add that to the code for now. 

> Should I try with model that aren't ALC882 ? (I've tried one, but it's
> not accepted, I don't know if I should try all of them)
> 

No, because it wouldn't work.  When snd-hda-intel loads, it looks at the
codecs on the bus (there can be 16), and determines the vendor and
model.  It then looks at the tables to see if that vendor/model is
listed (each of the patch_*.c files has their own table at the end of
the file).  If a correct entry is found, the table tells the driver
which patch to use, and each patch has different configuration
definitions.
The patch looks at it's own table to match your pci subsystem ID so that
it can load the correct settings for your motherboard.  If your
subsystem ID isn't listed, then the driver will revert to "auto" mode.

Hope that explanation helps.

As to a Master Volume, I can look into adding it if you'd be willing to
give it a test run.  I'll need one piece of output from your system,
though.  Type "cat /proc/asound/version /proc/asound/card0/codec*
>Asus-p5W-codec.out" and send it to me.

I won't be able to get to it until next week at the earliest, but maybe
we can get it working.

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-QFEHohsKXCZ4PMpVhRJ3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">I tried model=6stck-dig, I'm sorry (it's a typo in the hda_codec.txt</FONT>
<FONT COLOR="#000000">which comes with the kernel)</FONT>
</PRE>
</BLOCKQUOTE>
I've fixed it and will get it upstream in another email, thanks.<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">with 6stack-dig, the module accept the option but I get (it seems) the</FONT>
<FONT COLOR="#000000">same controls as bios-tried, so not any master control (maybe there is</FONT>
<FONT COLOR="#000000">no such control on this board, I don't know, but I think it should be)</FONT>
<FONT COLOR="#000000">I've tried 6stack-dig, 3stack-dig, and arima but it's 6stack-dig (or</FONT>
<FONT COLOR="#000000">bios) that fit the best.</FONT>
</PRE>
</BLOCKQUOTE>
I'll add that to the code for now. 
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Should I try with model that aren't ALC882 ? (I've tried one, but it's</FONT>
<FONT COLOR="#000000">not accepted, I don't know if I should try all of them)</FONT>

</PRE>
</BLOCKQUOTE>
No, because it wouldn't work.&nbsp; When snd-hda-intel loads, it looks at the codecs on the bus (there can be 16), and determines the vendor and model.&nbsp; It then looks at the tables to see if that vendor/model is listed (each of the patch_*.c files has their own table at the end of the file).&nbsp; If a correct entry is found, the table tells the driver which patch to use, and each patch has different configuration definitions.<BR>
The patch looks at it's own table to match your pci subsystem ID so that it can load the correct settings for your motherboard.&nbsp; If your subsystem ID isn't listed, then the driver will revert to &quot;auto&quot; mode.<BR>
<BR>
Hope that explanation helps.<BR>
<BR>
As to a Master Volume, I can look into adding it if you'd be willing to give it a test run.&nbsp; I'll need one piece of output from your system, though.&nbsp; Type &quot;cat /proc/asound/version /proc/asound/card0/codec* &gt;Asus-p5W-codec.out&quot; and send it to me.<BR>
<BR>
I won't be able to get to it until next week at the earliest, but maybe we can get it working.<BR>
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

--=-QFEHohsKXCZ4PMpVhRJ3--



--===============1551213094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1551213094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1551213094==--
