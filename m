From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: emu10k1 latency / capture period
Date: Thu, 17 Jun 2004 11:06:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406170906.i5H9604W013076@www1.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
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
To: rlrevell@joe-job.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I don't well understand ALSA concepts, but I think, that minimum
period size for emu10k1 is 384.

Emu10k1 has actually 3 capture devices.
0 - standard capture, stereo 16 bit / 8000 - 48000 Hz
1 - mic capture - (implemented, not very used under ALSA) mono 16 bit
/ 8000 Hz
2 - fx capture - (implemented, not very used under ALSA) 1 - 32
channels  16 bit / 48000 Hz

All have same minimal period size, but 2 has 32 channels and then I
think it is better for low latency and multichannel recording.

Peter Zubaj=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D REKLAMA =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=0ASpolocnost SUN Microsystems uviedla na trh novy server Sun F=
ire V20z=0Azalozeny procesoroch AMD Opteron.=0AViac informacii najdete na :=
 http://www.somi.sk/sun/v20z.php=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
