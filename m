From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Wierd hack to sound/pci/intel8x0.c
Date: Mon, 07 Nov 2011 10:25:24 +0100
Message-ID: <4EB7A404.3070902@redhat.com>
References: <4EB69EDA.5000901@redhat.com>	<4EB6B285.9050509@parallels.com>
	<s5h1utlky6i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <s5h1utlky6i.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Konstantin Ozerkov <kozerkov@parallels.com>, KVM list <kvm@vger.kernel.org>, "Denis V. Lunev" <den@parallels.com>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

  Hi,

> Agreed.  If we can know the virtual device for KVM in a better way
> (e.g. any specific PCI SSID or such), we can narrow the condition more
> safely.

PCI Subsystem ID 1af4:1100 is qemu/kvm (not only Intel HDA, most other
emulated pci devices have it too). Complete entry:

00:04.0 0403: 8086:2668 (rev 01)
        Subsystem: 1af4:1100
        Physical Slot: 4
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at e2030000 (32-bit, non-prefetchable) [size=16K]
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel

cheers,
  Gerd
