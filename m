From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: VIA 82C686B AC'97 controller initialization
Date: Sun, 05 Jul 2009 14:52:32 +0200
Message-ID: <20090705125232.52700@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 638502434F
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 14:52:34 +0200 (CEST)
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

Hi,

I'm trying to get AC'97 sound working on my AmigaOne PowerPC machine with
a VIA 82C686B southbridge and a SigmaTel STAC9752 codec. The firmware
doesn't initialize the AC'97 controller at all. Thus I had to implement
some PCI quirks, which first setup the I/O BARs of the AC'97 PCI device
and secondly power up the AC'97 controller by triggering a soft resume
event through the southbridge's ACPI controller. This seems to work fine
so far, but playback works in slow motion when I first power up the
machine. After a warm reset audio playback sounds normal.
Does somebody know how to fix this problem or were the problem could be?

BTW can the snd-via82xx and snd-via82xx-modem drivers be used at the same
time?

Thanks

Gerhard

p.s.: Please put me on CC:, as I'm not subscribed to this mailing list.
-- =

Neu: GMX Doppel-FLAT mit Internet-Flatrate + Telefon-Flatrate
f=FCr nur 19,99 Euro/mtl.!* http://portal.gmx.net/de/go/dsl02
