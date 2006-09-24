From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: hda_intel ATI SB450 - unknown subsystem
	ID	1025:009f
Date: Sun, 24 Sep 2006 13:26:33 -0700
Message-ID: <1159129593.7201.206.camel@razman>
References: <ab3226c20609240702q16d4a4f1x2c88fd9faf983b75@mail.gmail.com>
	<1159112890.7201.191.camel@razman>
	<ab3226c20609241022p5b237197v17ab0f0f493896a0@mail.gmail.com>
	<1159120893.7201.202.camel@razman>
	<ab3226c20609241236mcc402d7xc87a1eb5d90e747a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1529152365=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <ab3226c20609241236mcc402d7xc87a1eb5d90e747a@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: =?iso-8859-2?Q?Stanis=B3aw_Raczy=F1ski?= <sutashu@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1529152365==
Content-Type: multipart/alternative; boundary="=-UtNr1qJVECFZtL8jnf+9"


--=-UtNr1qJVECFZtL8jnf+9
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

I'll try to submit a patch tomorrow.  This is a simple fix.  Glad you
are working now.

On Sun, 2006-09-24 at 21:36 +0200, Stanis=B3aw Raczy=F1ski wrote:

> After some struggling I finally got it working (with model=3Dacer) with
> your tips. Thanks a lot. I hope the information I provided will
> be somewhat useful -- you might want to put this device ID in the
> sources for future generations.=20
>=20
>=20
> 2006/9/24, Tobin Davis <tdavis@dsl-only.net>:
>=20
>         On Sun, 2006-09-24 at 19:22 +0200, Stanis=B3aw Raczy=F1ski wrot=
e:
>        =20
>         > I'm using alsa 1.0.11 right now, but I also have tried
>         > 1.0.12 and 1.0.13-rc2. I tried model=3Dacer, but it doesn't
>         > work either.
>         >=20
>         > # cat /proc/asound/card0/codec#0
>         > Codec: Realtek ALC883
>         > Address: 0
>         > Vendor Id: 0x10ec0883=20
>         > Subsystem Id: 0x1025140d
>         > Revision Id: 0x100002
>        =20
>         This is supported in 1.0.13rc2.  I can add your specific
>         device ID.  Remember, you need the driver, libs, and utils to
>         be in sync to properly work.  driver 1.0.13rc2 won't work
>         properly with libs 1.0.11, and utils should be rebuilt against
>         the latest libs to properly work as well.  Try building and
>         installing the driver, lib, and utils packages from 1.0.13rc2
>         again.  Build and install each in that order to satisfy
>         dependencies.=20
>        =20
>         Also, for the driver, try configuring like this "./configure
>         --with-debug=3Ddetect --with-cards=3Dhda-intel".  This will tur=
n
>         on hda-intel's debugging messages.  Load it with "model=3Dacer"
>         or "model=3Dauto" if acer doesn't work.  In the mean time, I'll
>         parse through the rest of your codec#1 output to see if I see
>         anything relevant.=20
>        =20
>        =20
>         >=20
>         > # cat /proc/asound/card0/codec#1
>         > Codec: Generic 14f1 ID 2bfa
>         > Address: 1
>         > Vendor Id: 0x14f12bfa
>         > Subsystem Id: 0x1025009f
>         > Revision Id: 0x90000
>        =20
>         This looks like a Conexant modem.  To get support for it,
>         you'll have to go to linuxant.com and buy their driver.
>        =20
>        =20
>         > localhost ~ # cat /proc/asound/card0/codec#3=20
>         > Codec: Generic ffff ID ffff
>         > Address: 3
>         > Vendor Id: 0xffffffff
>         > Subsystem Id: 0xffffffff=20
>         > Revision Id: 0xffffffff
>        =20
>         This looks like garbage.  Not sure where it's coming from. =20
>        =20
>         --=20
>         Tobin Davis <tdavis@dsl-only.net>=20
>=20
>=20

--=20
Tobin Davis <tdavis@dsl-only.net>

--=-UtNr1qJVECFZtL8jnf+9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
I'll try to submit a patch tomorrow.&nbsp; This is a simple fix.&nbsp; Glad you are working now.<BR>
<BR>
On Sun, 2006-09-24 at 21:36 +0200, Stanis&#322;aw Raczy&#324;ski wrote:<BR>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">After some struggling I finally got it working (with model=acer) with your tips. Thanks a lot. I hope the information I provided will be&nbsp;somewhat useful -- you might&nbsp;want&nbsp;to put this device ID in the sources for future generations. </FONT><BR>
    <BR>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">2006/9/24, Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;:</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <BLOCKQUOTE>
        <FONT COLOR="#000000">On Sun, 2006-09-24 at 19:22 +0200, Stanis&#322;aw Raczy&#324;ski wrote:</FONT><BR>
        <BLOCKQUOTE TYPE=CITE>
            <FONT COLOR="#000000">I'm&nbsp;using alsa 1.0.11 right now, but I also have tried 1.0.12 and 1.0.13-rc2. I tried model=acer, but it doesn't work either.</FONT><BR>
            <BR>
            <FONT COLOR="#000000"># cat /proc/asound/card0/codec#0</FONT><BR>
            <FONT COLOR="#000000">Codec: Realtek ALC883</FONT><BR>
            <FONT COLOR="#000000">Address: 0</FONT><BR>
            <FONT COLOR="#000000">Vendor Id: 0x10ec0883 </FONT><BR>
            <FONT COLOR="#000000">Subsystem Id: 0x1025140d</FONT><BR>
            <FONT COLOR="#000000">Revision Id: 0x100002</FONT><BR>
        </BLOCKQUOTE>
        <FONT COLOR="#000000">This is supported in 1.0.13rc2.&nbsp; I can add your specific device ID.&nbsp; Remember, you need the driver, libs, and utils to be in sync to properly work.&nbsp; driver 1.0.13rc2 won't work properly with libs 1.0.11, and utils should be rebuilt against the latest libs to properly work as well.&nbsp; Try building and installing the driver, lib, and utils packages from 1.0.13rc2 again.&nbsp; Build and install each in that order to satisfy dependencies. </FONT><BR>
        <BR>
        <FONT COLOR="#000000">Also, for the driver, try configuring like this &quot;./configure --with-debug=detect --with-cards=hda-intel&quot;.&nbsp; This will turn on hda-intel's debugging messages.&nbsp; Load it with &quot;model=acer&quot; or &quot;model=auto&quot; if acer doesn't work.&nbsp; In the mean time, I'll parse through the rest of your codec#1 output to see if I see anything relevant. </FONT><BR>
        <BR>
        <BLOCKQUOTE TYPE=CITE>
            <BR>
            <FONT COLOR="#000000"># cat /proc/asound/card0/codec#1</FONT><BR>
            <FONT COLOR="#000000">Codec: Generic 14f1 ID 2bfa</FONT><BR>
            <FONT COLOR="#000000">Address: 1</FONT><BR>
            <FONT COLOR="#000000">Vendor Id: 0x14f12bfa</FONT><BR>
            <FONT COLOR="#000000">Subsystem Id: 0x1025009f</FONT><BR>
            <FONT COLOR="#000000">Revision Id: 0x90000</FONT><BR>
        </BLOCKQUOTE>
        <FONT COLOR="#000000">This looks like a Conexant modem.&nbsp; To get support for it, you'll have to go to <A HREF="http://linuxant.com">linuxant.com</A> and buy their driver.</FONT><BR>
        <BR>
        <BLOCKQUOTE TYPE=CITE>
            <FONT COLOR="#000000">localhost ~ # cat /proc/asound/card0/codec#3 </FONT><BR>
            <FONT COLOR="#000000">Codec: Generic ffff ID ffff</FONT><BR>
            <FONT COLOR="#000000">Address: 3</FONT><BR>
            <FONT COLOR="#000000">Vendor Id: 0xffffffff</FONT><BR>
            <FONT COLOR="#000000">Subsystem Id: 0xffffffff </FONT><BR>
            <FONT COLOR="#000000">Revision Id: 0xffffffff</FONT><BR>
        </BLOCKQUOTE>
        <FONT COLOR="#000000">This looks like garbage.&nbsp; Not sure where it's coming from.&nbsp; </FONT><BR>
        <BR>
        <TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt; 
</TD>
</TR>
</TABLE>
    </BLOCKQUOTE>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <BR>
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

--=-UtNr1qJVECFZtL8jnf+9--



--===============1529152365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1529152365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1529152365==--
