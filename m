From: Carlos Sierra <csierra@eresmas.net>
Subject: Leadtek nForce2 Motherboards sound problems
Date: 15 Jul 2003 20:09:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1058292565.1024.12.camel@xavier.micasa>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=-8QmvE0kUAmQz8iMn1fKw"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-8QmvE0kUAmQz8iMn1fKw
Content-Type: text/plain; charset=
Content-Transfer-Encoding: quoted-printable

Hi, I recently buyed a Leadted Winfast K7NCR18G PRO booard with NVIDIA
NForce2 MCP-T chip. This board comes with integrated:
=C2=B7 network
=C2=B7 video=20
=C2=B7 audio

I has no problem neither with video nor net but the audio has problems.
The driver matching this card is snd-intel8x0, and I have read that
people having other motherboards with the same chipset have made in work
correctly, but people owning Leadtek boards have encountered problems.

The problem I have is the next:
    Usually, when I start to play some sound, card works perfectly but
when I stop and start sound again, either stopping and starting the
player program or toggling pause, the playback becomes faster and the
tone higher. Stopping and starting the playback will toggle the
behaviour between right and wrong playback.=20

I tried both kernel and alsa drivers and with both of them the card
behaves the same.
I tried with almost every parameter the drivers accepts with no luck.=20

As a hint, when I request strict_clocking and set clocking to a lower
freq I obtained slow playback (when before it played right) and fastest
playback (when before it played wrong) so no solution found.

I would like to know whether this is a know problem and whether it has a
solution via driver or whether it is a hardware issue...

Thanks...

--=-8QmvE0kUAmQz8iMn1fKw
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.5">
</HEAD>
<BODY>
Hi, I recently buyed a Leadted Winfast K7NCR18G PRO booard with NVIDIA NForce2 MCP-T chip. This board comes with integrated:<BR>
&#183; network<BR>
&#183; video <BR>
&#183; audio<BR>
<BR>
I has no problem neither with video nor net but the audio has problems.<BR>
The driver matching this card is snd-intel8x0, and I have read that people having other motherboards with the same chipset have made in work correctly, but people owning Leadtek boards have encountered problems.<BR>
<BR>
The problem I have is the next:<BR>
&nbsp;&nbsp;&nbsp; Usually, when I start to play some sound, card works perfectly but when I stop and start sound again, either stopping and starting the player program or toggling pause, the playback becomes faster and the tone higher. Stopping and starting the playback will toggle the behaviour between right and wrong playback. <BR>
<BR>
I tried both kernel and alsa drivers and with both of them the card behaves the same.<BR>
I tried with almost every parameter the drivers accepts with no luck. <BR>
<BR>
As a hint, when I request strict_clocking and set clocking to a lower freq I obtained slow playback (when before it played right) and fastest playback (when before it played wrong) so no solution found.<BR>
<BR>
I would like to know whether this is a know problem and whether it has a solution via driver or whether it is a hardware issue...<BR>
<BR>
Thanks...
</BODY>
</HTML>

--=-8QmvE0kUAmQz8iMn1fKw--



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
