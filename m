From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: what information to provide for bug report
	of	ALC880 sound card problems ?
Date: Fri, 05 Jan 2007 18:54:06 -0800
Message-ID: <1168052046.5835.20.camel@localhost>
References: <37aUfFwc.1167922328.3333200.postmaster@valombre.com>
	<1167923529.28242.103.camel@localhost>
	<1168043264.23650.14.camel@gondor>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0551195848=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1168043264.23650.14.camel@gondor>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Eric <eric@valombre.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0551195848==
Content-Type: multipart/alternative; boundary="=-70qZdxmwv9VcI6qmcFgx"


--=-70qZdxmwv9VcI6qmcFgx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I'm not entirely sure why the system segfaults without debug=3Ddetect.
Also, it appears that you are losing the drivers with a model parameter,
as seen by the dmesg output when debug=3Ddetect.  Since your system isn't
specifically listed, you should see something similar to this:


        ALSA
        alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/hda_intel=
.c:696: codec_mask =3D 0x3
        hda_codec: Unknown model for ALC880, trying auto-probe from
        BIOS...
        ALSA alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2175: autoconfig:
        line_outs=3D1 (0x15/0x0/0x0/0x0/0x0)
        ALSA alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2179:
        speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
        ALSA alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2183:
        hp_outs=3D1 (0x14/0x0/0x0/0x0/0x0)
        ALSA alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2191:    inputs:
        mic=3D0x19, fmic=3D0x0, line=3D0x0, fline=3D0x0, cd=3D0x0, aux=3D=
0x0
       =20

Check to see that /etc/modprobe.conf (or similar file) isn't setting
options for the driver at load time.  You could also override it by
manually installing the driver with:

        modprobe snd-hda-intel model=3Dauto

That will force the driver into auto mode.

I do notice that there are a couple of systems with similar subdevice
ID's.  You could try "model=3Dclevo" as a load option and see what
happens.  If this doesn't work, try other models listed in
alsa-driver-1.0.14rc1/alsa-kernel/Documentation/ALSA-Configuration.txt
(look for ALC880).

If one of these models works well, rebuild the driver without
debug=3Ddetect and reload with the same parameters.

Let us know one way or the other.  If it works, we can add your system
to the driver source relatively easily (1 line).  Otherwise we'll have
to work with you to get a more detailed patch working.

Tobin

On Sat, 2007-01-06 at 01:27 +0100, Eric wrote:

> Thank you for your answer.
>=20
> So I did the following, I hope there are enough infos to understand
> what's the problem(s).
>=20
> System Ubuntu Edgy with 2.6.17 ubuntu kernel on a laptop P4 system.
>=20
> 1) I compiled and installed alsa-driver-1.0.14rc1 with debug=3Dnone.
> --> Results of dmesg are in Sager-dmesg-debugnone.txt.=20
> --> Results of lspci -s 0:1b -vn are in Sager-9860-lspci-debugdetect
> --> Results of cat /proc/asound/card0/codec* hangs the terminal and I
> have to kill it. There are 2 "codec#" files (see
> Sager-9860-ls-l-debugnone.txt)
> --> Results of aplay file.wav gives :=20
> ALSA lib pcm_dmix.c:862:(snd_pcm_dmix_open) unable to open slave
> aplay: main:547: Erreur d'ouverture audio: Argument invalide
>=20
> 2) I compiled and installed alsa-driver-1.0.14rc1 with debug=3Ddetect :
> --> Results of dmesg are in Sager-dmesg-debugdetect.txt
> --> Results of lspci -s 0:1b -vn are in Sager-9860-lspci-debugdetect.tx=
t
> --> Results of cat /proc/asound/card0/codec* are in
> Sager-9860-codec-debugdetect.txt . There is only one code# file (see
> Sager-9860-ls-l-debugdetect.txt), contrary to the previous test.
> --> Results of aplay is ok. Playing sound works ...=20
>=20
> Eric
>=20
> Le jeudi 04 janvier 2007 =C3=A0 07:12 -0800, Tobin Davis a =C3=A9crit :
> > To start, what version of alsa are you running
> > (cat /proc/asound/version)?  You should download at least
> > alsa-driver-1.0.14rc1.tar.bz2 from the alsa-project.org site.  For
> > debugging and configuring your system, it is recommended that you
> > build with "./configure --with-debug=3Ddetect --with-cards=3Dhda-inte=
l".
> >=20
> > Clear the dmesg log with "dmesg -c" prior to loading the driver.
> > After loading, the driver will output some basic information that we
> > need for development.  Also send "cat /proc/asound/card0/codec*
> > >Sager9860-codec.txt", and "lspci -s 0:1b -vn" output.
> >=20
> > These three things will help us to get your system added quickly.
> >=20
> > Thanks,
> >=20
> > Tobin
> >=20
> > On Thu, 2007-01-04 at 14:52 +0000, Eric De Vito wrote:=20
> > > I have a laptop (pentiumIV, Sager9860/D900t model) with an ALC880 R=
ealtek
> > > integrated sound card. I have problems and bugs with any alsa versi=
ons,
> > > with an Ubuntu Edgy system. What must I provide as informations tha=
t may
> > > be useful for tracking bugs ?
> > > Thank you
> > >=20
> > > Eric
> > >=20
> > > -------------------------------------------------------------------=
------
> > > Take Surveys. Earn Cash. Influence the Future of IT
> > > Join SourceForge.net's Techsay panel and you'll get the chance to s=
hare your
> > > opinions on IT & business topics through brief surveys - and earn c=
ash
> > > http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&=
CID=3DDEVDEV
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> > --=20
> > Tobin Davis <tdavis@dsl-only.net>

--=20
Tobin Davis <tdavis@dsl-only.net>

--=-70qZdxmwv9VcI6qmcFgx
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
I'm not entirely sure why the system segfaults without debug=detect.&nbsp; Also, it appears that you are losing the drivers with a model parameter, as seen by the dmesg output when debug=detect.&nbsp; Since your system isn't specifically listed, you should see something similar to this:<BR>
<BR>
<BLOCKQUOTE>
    ALSA alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:696: codec_mask = 0x3<BR>
    hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...<BR>
    ALSA alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2175: autoconfig: line_outs=1 (0x15/0x0/0x0/0x0/0x0)<BR>
    ALSA alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2179:&nbsp;&nbsp;&nbsp; speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)<BR>
    ALSA alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2183:&nbsp;&nbsp;&nbsp; hp_outs=1 (0x14/0x0/0x0/0x0/0x0)<BR>
    ALSA alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2191:&nbsp;&nbsp;&nbsp; inputs: mic=0x19, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0<BR>
    <BR>
</BLOCKQUOTE>
Check to see that /etc/modprobe.conf (or similar file) isn't setting options for the driver at load time.&nbsp; You could also override it by manually installing the driver with:<BR>
<BLOCKQUOTE>
    modprobe snd-hda-intel model=auto<BR>
</BLOCKQUOTE>
That will force the driver into auto mode.<BR>
<BR>
I do notice that there are a couple of systems with similar subdevice ID's.&nbsp; You could try &quot;model=clevo&quot; as a load option and see what happens.&nbsp; If this doesn't work, try other models listed in <TT>alsa-driver-1.0.14rc1/alsa-kernel/Documentation/ALSA-Configuration.txt (look for ALC880).</TT><BR>
<BR>
If one of these models works well, rebuild the driver without debug=detect and reload with the same parameters.<BR>
<BR>
Let us know one way or the other.&nbsp; If it works, we can add your system to the driver source relatively easily (1 line).&nbsp; Otherwise we'll have to work with you to get a more detailed patch working.<BR>
<BR>
Tobin<BR>
<BR>
On Sat, 2007-01-06 at 01:27 +0100, Eric wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Thank you for your answer.</FONT>

<FONT COLOR="#000000">So I did the following, I hope there are enough infos to understand</FONT>
<FONT COLOR="#000000">what's the problem(s).</FONT>

<FONT COLOR="#000000">System Ubuntu Edgy with 2.6.17 ubuntu kernel on a laptop P4 system.</FONT>

<FONT COLOR="#000000">1) I compiled and installed alsa-driver-1.0.14rc1 with debug=none.</FONT>
<FONT COLOR="#000000">--&gt; Results of dmesg are in Sager-dmesg-debugnone.txt. </FONT>
<FONT COLOR="#000000">--&gt; Results of lspci -s 0:1b -vn are in Sager-9860-lspci-debugdetect</FONT>
<FONT COLOR="#000000">--&gt; Results of cat /proc/asound/card0/codec* hangs the terminal and I</FONT>
<FONT COLOR="#000000">have to kill it. There are 2 &quot;codec#&quot; files (see</FONT>
<FONT COLOR="#000000">Sager-9860-ls-l-debugnone.txt)</FONT>
<FONT COLOR="#000000">--&gt; Results of aplay file.wav gives : </FONT>
<FONT COLOR="#000000">ALSA lib pcm_dmix.c:862:(snd_pcm_dmix_open) unable to open slave</FONT>
<FONT COLOR="#000000">aplay: main:547: Erreur d'ouverture audio: Argument invalide</FONT>

<FONT COLOR="#000000">2) I compiled and installed alsa-driver-1.0.14rc1 with debug=detect :</FONT>
<FONT COLOR="#000000">--&gt; Results of dmesg are in Sager-dmesg-debugdetect.txt</FONT>
<FONT COLOR="#000000">--&gt; Results of lspci -s 0:1b -vn are in Sager-9860-lspci-debugdetect.txt</FONT>
<FONT COLOR="#000000">--&gt; Results of cat /proc/asound/card0/codec* are in</FONT>
<FONT COLOR="#000000">Sager-9860-codec-debugdetect.txt . There is only one code# file (see</FONT>
<FONT COLOR="#000000">Sager-9860-ls-l-debugdetect.txt), contrary to the previous test.</FONT>
<FONT COLOR="#000000">--&gt; Results of aplay is ok. Playing sound works ... </FONT>

<FONT COLOR="#000000">Eric</FONT>

<FONT COLOR="#000000">Le jeudi 04 janvier 2007 &#224; 07:12 -0800, Tobin Davis a &#233;crit :</FONT>
<FONT COLOR="#000000">&gt; To start, what version of alsa are you running</FONT>
<FONT COLOR="#000000">&gt; (cat /proc/asound/version)?  You should download at least</FONT>
<FONT COLOR="#000000">&gt; alsa-driver-1.0.14rc1.tar.bz2 from the alsa-project.org site.  For</FONT>
<FONT COLOR="#000000">&gt; debugging and configuring your system, it is recommended that you</FONT>
<FONT COLOR="#000000">&gt; build with &quot;./configure --with-debug=detect --with-cards=hda-intel&quot;.</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Clear the dmesg log with &quot;dmesg -c&quot; prior to loading the driver.</FONT>
<FONT COLOR="#000000">&gt; After loading, the driver will output some basic information that we</FONT>
<FONT COLOR="#000000">&gt; need for development.  Also send &quot;cat /proc/asound/card0/codec*</FONT>
<FONT COLOR="#000000">&gt; &gt;Sager9860-codec.txt&quot;, and &quot;lspci -s 0:1b -vn&quot; output.</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; These three things will help us to get your system added quickly.</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Thanks,</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Tobin</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; On Thu, 2007-01-04 at 14:52 +0000, Eric De Vito wrote: </FONT>
<FONT COLOR="#000000">&gt; &gt; I have a laptop (pentiumIV, Sager9860/D900t model) with an ALC880 Realtek</FONT>
<FONT COLOR="#000000">&gt; &gt; integrated sound card. I have problems and bugs with any alsa versions,</FONT>
<FONT COLOR="#000000">&gt; &gt; with an Ubuntu Edgy system. What must I provide as informations that may</FONT>
<FONT COLOR="#000000">&gt; &gt; be useful for tracking bugs ?</FONT>
<FONT COLOR="#000000">&gt; &gt; Thank you</FONT>
<FONT COLOR="#000000">&gt; &gt; </FONT>
<FONT COLOR="#000000">&gt; &gt; Eric</FONT>
<FONT COLOR="#000000">&gt; &gt; </FONT>
<FONT COLOR="#000000">&gt; &gt; -------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">&gt; &gt; Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">&gt; &gt; Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">&gt; &gt; opinions on IT &amp; business topics through brief surveys - and earn cash</FONT>
<FONT COLOR="#000000">&gt; &gt; <A HREF="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</A></FONT>
<FONT COLOR="#000000">&gt; &gt; _______________________________________________</FONT>
<FONT COLOR="#000000">&gt; &gt; Alsa-devel mailing list</FONT>
<FONT COLOR="#000000">&gt; &gt; <A HREF="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</A></FONT>
<FONT COLOR="#000000">&gt; &gt; <A HREF="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</A></FONT>
<FONT COLOR="#000000">&gt; -- </FONT>
<FONT COLOR="#000000">&gt; Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;</FONT>
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

--=-70qZdxmwv9VcI6qmcFgx--



--===============0551195848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0551195848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0551195848==--
