From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: trying to get sound working at a mac book
	pro	(core 2 duo)
Date: Wed, 14 Feb 2007 11:40:19 -0800
Message-ID: <1171482019.7083.8.camel@razman.gruemaster.com>
References: <564d96fb0702141121j185378d1m4c3a192831442fb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0324756091=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <564d96fb0702141121j185378d1m4c3a192831442fb7@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Rafael =?ISO-8859-1?Q?Esp=EDndola?= <rafael.espindola@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0324756091==
Content-Type: multipart/alternative; boundary="=-86omk/iugXMJo3nqI7Sz"


--=-86omk/iugXMJo3nqI7Sz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

If you could send me the output from "lspci -s 0:1b -vn" I can add this
to the driver so you and other Mac users will work out of the box.

Using the subsystem id from the codec output isn't always accurate, and
the driver uses the output from lspci anyways.

As to internal mic, I can look into it.  Send me the output from
"cat /proc/asound/card0/codec#*" as an attachment.

Tobin

On Wed, 2007-02-14 at 19:21 +0000, Rafael Esp=C3=ADndola wrote:

> I have installed the alsa drivers from the mercurial repository and
> the current status is
>=20
> *) Headphone works
> *) Speakers work
> *) Headphone sensing works
> *) Internal microphone doesn't
>=20
> I haven't tried to use an external microphone.
>=20
> Following the steps in http://www.jasonparekh.com/?page_id=3D9 resulted
> in the microphone working but the speakers stoped.
>=20
> The subsystem ID of my card is 0x106b1e00. This is the only difference
> from the one on http://www.jasonparekh.com/?page_id=3D9.
>=20
> I tried to grep for this subsystem in the windows driver (from
> bootcamp 1.1.2) but it is not listed. Has someone installed windows on
> one of these systems? Does sound works?
>=20
> Any ideas on how to try to find out the correct pin setting? Maybe
> looking at the macos driver?
>=20
> And in the case I can make it work, what is the correct way to do an
> switch on the subsystem? Is there a variant of
> snd_hda_check_board_config that also uses subsystem ID to
> disambiguate pin configs?
>=20
> Thanks,
> Rafael
>=20
> -----------------------------------------------------------------------=
--
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share=
 your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=20
Tobin Davis <tdavis@dsl-only.net>

--=-86omk/iugXMJo3nqI7Sz
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
If you could send me the output from &quot;lspci -s 0:1b -vn&quot; I can add this to the driver so you and other Mac users will work out of the box.<BR>
<BR>
Using the subsystem id from the codec output isn't always accurate, and the driver uses the output from lspci anyways.<BR>
<BR>
As to internal mic, I can look into it.&nbsp; Send me the output from &quot;cat /proc/asound/card0/codec#*&quot; as an attachment.<BR>
<BR>
Tobin<BR>
<BR>
On Wed, 2007-02-14 at 19:21 +0000, Rafael Esp&#237;ndola wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">I have installed the alsa drivers from the mercurial repository and</FONT>
<FONT COLOR="#000000">the current status is</FONT>

<FONT COLOR="#000000">*) Headphone works</FONT>
<FONT COLOR="#000000">*) Speakers work</FONT>
<FONT COLOR="#000000">*) Headphone sensing works</FONT>
<FONT COLOR="#000000">*) Internal microphone doesn't</FONT>

<FONT COLOR="#000000">I haven't tried to use an external microphone.</FONT>

<FONT COLOR="#000000">Following the steps in <A HREF="http://www.jasonparekh.com/?page_id=9">http://www.jasonparekh.com/?page_id=9</A> resulted</FONT>
<FONT COLOR="#000000">in the microphone working but the speakers stoped.</FONT>

<FONT COLOR="#000000">The subsystem ID of my card is 0x106b1e00. This is the only difference</FONT>
<FONT COLOR="#000000">from the one on <A HREF="http://www.jasonparekh.com/?page_id=9">http://www.jasonparekh.com/?page_id=9</A>.</FONT>

<FONT COLOR="#000000">I tried to grep for this subsystem in the windows driver (from</FONT>
<FONT COLOR="#000000">bootcamp 1.1.2) but it is not listed. Has someone installed windows on</FONT>
<FONT COLOR="#000000">one of these systems? Does sound works?</FONT>

<FONT COLOR="#000000">Any ideas on how to try to find out the correct pin setting? Maybe</FONT>
<FONT COLOR="#000000">looking at the macos driver?</FONT>

<FONT COLOR="#000000">And in the case I can make it work, what is the correct way to do an</FONT>
<FONT COLOR="#000000">switch on the subsystem? Is there a variant of</FONT>
<FONT COLOR="#000000">snd_hda_check_board_config that also uses subsystem ID to</FONT>
<FONT COLOR="#000000">disambiguate pin configs?</FONT>

<FONT COLOR="#000000">Thanks,</FONT>
<FONT COLOR="#000000">Rafael</FONT>

<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">opinions on IT &amp; business topics through brief surveys-and earn cash</FONT>
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

--=-86omk/iugXMJo3nqI7Sz--



--===============0324756091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0324756091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0324756091==--
