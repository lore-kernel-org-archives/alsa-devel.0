From: p z oooo <pzad@pobox.sk>
Subject: Re: Test: SBLive! (C) 2003 need extra effort on Rear Analog Output
Date: Fri, 26 Mar 2004 08:27:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403260727.i2Q7RvAc005130@www3.pobox.sk>
Reply-To: p z oooo <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: guanyim@hotmail.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In alsa-driver/alsa-kernel/emu10k1/emumixer there are two static=20
arrays:
1) static char *emu10k1_remove_ctls[]
remove from this array:
"Surround Playback Switch",
"Surround Playback Volume",=20

2)
static char *emu10k1_rename_ctls[]
remove from this array:
"Surround Digital Playback Volume", "Surround Playback Volume",=20

recompile, you will maybe have these controls in mixer:
"Surround Digital Playback Volume"
"Surround Playback Volume"=20

unmute and set volume for both volume.

If not working - try same with center, and LFE.

If not working - this must be other problem

Peter Zubaj
=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REKLA=
MA =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=0ASpolocnost SUN Microsystems uviedla na trh novy server Sun Fire V20z=0Az=
alozeny procesoroch AMD Opteron.=0AViac informacii najdete na : http://www.=
somi.sk/sun/v20z.php=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
