From: mw-u2@gmx.de
Subject: default model for snd-hda-intel doesnt work
Date: Wed, 21 Jun 2006 21:17:16 +0200
Message-ID: <20060621191716.295260@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

> If the default configuration doesn't work and one of the above
> matches with your device, report it together with the PCI
> subsystem ID (output of "lspci -nv") to ALSA BTS or alsa-devel
> ML (see the section "Links and Addresses").

I had to use options snd-hda-intel model=3D6stack position_fix=3D1 index=3D0

$ lspci
0000:00:14.2 0403: ATI Technologies Inc: Unknown device 437b (rev 01)

$ lspci -nv

0000:00:14.2 0403: 1002:437b (rev 01)
        Subsystem: 1462:7173
        Flags: bus master, slow devsel, latency 64, IRQ 201
        Memory at febf8000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=3D0/0=
 Enable-

Hope that helps!

I still got a very annoying problem left though: I cant change the volume u=
sing the PCM channel I have to change the volume of Front channel. This is =
very annoying since all programs with a volume control change the PCM chann=
el which is of no effect.

I would be very glad if you could help me with that.

Please CC me since I am not on the list.

Thanks, Micha
-- =



Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D107521&bid=3D248729&dat=3D1=
21642
