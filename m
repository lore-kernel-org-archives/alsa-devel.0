From: Stefan Bruens <stefan.bruens@rwth-aachen.de>
Subject: Multiple, independent streams with HDA
Date: Sun, 20 Sep 2009 21:28:03 +0200
Message-ID: <200909202128.03780.stefan.bruens@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-1.ms.rz.rwth-aachen.de (mta-1.ms.rz.RWTH-Aachen.DE
	[134.130.7.72]) by alsa0.perex.cz (Postfix) with ESMTP id 93EA624348
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Sep 2009 21:28:42 +0200 (CEST)
Received: from ironport-out-1.rz.rwth-aachen.de ([134.130.5.40])
	by mta-1.ms.rz.RWTH-Aachen.de
	(Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008))
	with ESMTP id <0KQA00AZBBFUP330@mta-1.ms.rz.RWTH-Aachen.de> for
	alsa-devel@alsa-project.org; Sun, 20 Sep 2009 21:28:42 +0200 (CEST)
Received: from bachus.localnet ([unknown] [78.54.227.158])
	by relay-auth-2.ms.rz.rwth-aachen.de
	(Sun Java(tm) System Messaging Server 7.0-3.01 64bit (built Dec 9
	2008))
	with ESMTPA id <0KQA005PFBFT4S60@relay-auth-2.ms.rz.rwth-aachen.de> for
	alsa-devel@alsa-project.org; Sun, 20 Sep 2009 21:28:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

as HDA supports up to 16 independent streams (sample rate, resolution), is =

there a possibility to expose this to user space?

Use cases:
- Simultaneous playback of music to speaker and connecting HPs for VoIP
- Multiseat - pair of I/O for each seat
...

I think there is already limited support for this, as e.g. SPDIF and analog =

expose independent PCMS (a least on STAC9271), although it is just a single =

codec.

Maybe even make this configurable, either at run time, or at module load ti=
me. =

E.g. "option hda-intel pcm_out_nids=3D0x2:0x3,0x4:0x1e pcm_in_nids=3D0x7:0x=
20" =

creates pcmC0D{0,1,2}p and pcmC0D{0,1}c, where 0p is analog stereo out, 1p =
is =

analog 4chan out, 2p digital out, 0c is analog stereo in, and finally 1c is =

digital stereo in.

(This example is for STAC9271:
cat /proc/asound/Intel/codec#2 | egrep "Node|Converter"  | grep Conv -B1
Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Converter: stream=3D0, channel=3D0
Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Converter: stream=3D0, channel=3D0
Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Converter: stream=3D0, channel=3D0
Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Converter: stream=3D0, channel=3D0
Node 0x06 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Converter: stream=3D0, channel=3D0
Node 0x07 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=3D0, channel=3D0
Node 0x08 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=3D0, channel=3D0
Node 0x09 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=3D0, channel=3D0
--
Node 0x1e [Audio Output] wcaps 0x40211: Stereo Digital
  Converter: stream=3D0, channel=3D0
--
Node 0x20 [Audio Input] wcaps 0x140311: Stereo Digital
  Converter: stream=3D0, channel=3D0
)

Stefan

-- =

Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
phone: +49 241 53809034     mobile: +49 151 50412019
