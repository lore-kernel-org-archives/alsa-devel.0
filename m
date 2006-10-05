From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: 1.0.13 and indigoio
Date: Thu, 5 Oct 2006 16:36:28 +0400
Message-ID: <70a871c80610050536w2968cd52n32a5960899b4e90b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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

Hello!

Echo Indigo IO refuses to work with alsa-driver > 1.0.11
with alsa-driver/alsa-firmware-1.0.12:

[ 4212.781000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level,
low) -> IRQ 177
[ 4212.781000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[ 4213.094000] ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level,
low) -> IRQ 185
[ 4213.163000] ALSA
/mnt/bits/portage/tmp/portage/alsa-driver-1.0.12/work/alsa-driver-1.0.12/pci/echoaudio/../../alsa-kernel/pci/echoaudio/echoaudio.c:46:
get_firmware(): Firmware not available (-2)
[ 4213.163000] ALSA
/mnt/bits/portage/tmp/portage/alsa-driver-1.0.12/work/alsa-driver-1.0.12/pci/echoaudio/../../alsa-kernel/pci/echoaudio/echoaudio_dsp.c:249:
Firmware not found !
[ 4213.163000] Echoaudio Indigo IO: probe of 0000:07:00.0 failed with error -2


with driver/firmware-1.0.13:

[ 4361.080000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level,
low) -> IRQ 177
[ 4361.080000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[ 4361.306000] ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level,
low) -> IRQ 185
[ 4387.819000] Echoaudio Indigo IO: probe of 0000:07:00.0 failed with error -5


Tested on x86 laptop and amd64 desktop with kernel: linux-2.6.18-gentoo.

it worked perfectly on x86 with linux-2.6.17-gentoo-r5 +
alsa-driver/firmware-1.0.11
Can't test 1.0.11 with 2.6.18 as alsa-driver does not build.

Please CC me in your replies.

Dmitry.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
