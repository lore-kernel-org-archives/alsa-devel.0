From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: snd-hda-intel model missing
Date: Wed, 27 Dec 2006 14:39:04 -0800
Message-ID: <1167259144.9563.51.camel@localhost>
References: <4592EBDB.7060707@dottout.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0937744241=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4592EBDB.7060707@dottout.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: andrea <andrea@dottout.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0937744241==
Content-Type: multipart/alternative; boundary="=-g9LSWVFlqc+k2lIR+bjZ"


--=-g9LSWVFlqc+k2lIR+bjZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Could you send a couple more pieces of data?  Need the output from
"lspci -s 0:1b -vn",  "cat /proc/asound/card0/codec*", and "dmesg".

To get a clean dmesg output that is useful, please follow these steps:

recompile alsa-driver-1.0.14rc1 with the following command:
./configure --with-debug=detect --with-cards=hda-intel ; make ; make
install  #(need to be root to run make install)
dmesg -c # Clear dmesg log
modprobe -r snd-hda-intel # remove currently running alsa drivers
modprobe snd-hda-intel
dmesg >dmesg-fujitsu_pi1536.out # send this file.

These will enable us to develop support for this system.

Tobin Davis

On Wed, 2006-12-27 at 22:55 +0100, andrea wrote:

> Hi, the driver snd-hda-intel does not have a right 'model' for my card:
> lspci|grep Audio
> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
> Definition Audio Controller (rev 02)
> lspci -nv |grep 1b    
> 00:1b.0 0403: 8086:27d8 (rev 02)
> on a fujitsu pi1536
> in order to have everything working, in particoular pc speaker, I have
> to load model 5stack-digout, but alsamixer's sliders are too many for my
> card's feature and the names are wrong. e.g.: the main speaker is
> managed by 'side' slider.
> this happens with 1.0.14rc1 alsa-driver and with older version, with
> kernel 2.6.19.1 and older ones
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

--=-g9LSWVFlqc+k2lIR+bjZ
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
Could you send a couple more pieces of data?&nbsp; Need the output from &quot;lspci -s 0:1b -vn&quot;,&nbsp; &quot;cat /proc/asound/card0/codec*&quot;, and &quot;dmesg&quot;.<BR>
<BR>
To get a clean dmesg output that is useful, please follow these steps:<BR>
<BR>
recompile alsa-driver-1.0.14rc1 with the following command:<BR>
./configure --with-debug=detect --with-cards=hda-intel ; make ; make install&nbsp; #(need to be root to run make install)<BR>
dmesg -c # Clear dmesg log<BR>
modprobe -r snd-hda-intel # remove currently running alsa drivers<BR>
modprobe snd-hda-intel<BR>
dmesg &gt;dmesg-<FONT COLOR="#000000">fujitsu</FONT>_<FONT COLOR="#000000">pi1536</FONT>.out # send this file.<BR>
<BR>
These will enable us to develop support for this system.<BR>
<BR>
Tobin Davis<BR>
<BR>
On Wed, 2006-12-27 at 22:55 +0100, andrea wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hi, the driver snd-hda-intel does not have a right 'model' for my card:</FONT>
<FONT COLOR="#000000">lspci|grep Audio</FONT>
<FONT COLOR="#000000">00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High</FONT>
<FONT COLOR="#000000">Definition Audio Controller (rev 02)</FONT>
<FONT COLOR="#000000">lspci -nv |grep 1b    </FONT>
<FONT COLOR="#000000">00:1b.0 0403: 8086:27d8 (rev 02)</FONT>
<FONT COLOR="#000000">on a fujitsu pi1536</FONT>
<FONT COLOR="#000000">in order to have everything working, in particoular pc speaker, I have</FONT>
<FONT COLOR="#000000">to load model 5stack-digout, but alsamixer's sliders are too many for my</FONT>
<FONT COLOR="#000000">card's feature and the names are wrong. e.g.: the main speaker is</FONT>
<FONT COLOR="#000000">managed by 'side' slider.</FONT>
<FONT COLOR="#000000">this happens with 1.0.14rc1 alsa-driver and with older version, with</FONT>
<FONT COLOR="#000000">kernel 2.6.19.1 and older ones</FONT>

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

--=-g9LSWVFlqc+k2lIR+bjZ--



--===============0937744241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0937744241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0937744241==--
