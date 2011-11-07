From: Konstantin Ozerkov <kozerkov@parallels.com>
Subject: Re: Wierd hack to sound/pci/intel8x0.c
Date: Mon, 7 Nov 2011 12:52:47 +0300
Message-ID: <4EB7AA6F.5000909@parallels.com>
References: <4EB69EDA.5000901@redhat.com>	<4EB6B285.9050509@parallels.com> <s5h1utlky6i.wl%tiwai@suse.de> <4EB7A404.3070902@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4EB7A404.3070902@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, Denis Lunev <den@parallels.com>, Avi Kivity <avi@redhat.com>, "Denis V. Lunev (openvz)" <den@openvz.org>, Linus Torvalds <torvalds@linux-foundation.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, KVM list <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-Id: alsa-devel@alsa-project.org

On 07.11.11 12:25, Gerd Hoffmann wrote:
>    Hi,
>
>> Agreed.  If we can know the virtual device for KVM in a better way
>> (e.g. any specific PCI SSID or such), we can narrow the condition more
>> safely.
> PCI Subsystem ID 1af4:1100 is qemu/kvm (not only Intel HDA, most other
> emulated pci devices have it too). Complete entry:
>
> 00:04.0 0403: 8086:2668 (rev 01)
>          Subsystem: 1af4:1100
>          Physical Slot: 4
>          Flags: bus master, fast devsel, latency 0, IRQ 11
>          Memory at e2030000 (32-bit, non-prefetchable) [size=16K]
>          Kernel driver in use: HDA Intel
>          Kernel modules: snd-hda-intel
>
> cheers,
>    Gerd
We discuss Intel ICH/AC'97 (snd-intel8x0) here, but I hope that PCI SSID is same.

 From Parallels VM side we also have specific PCI SSID (1ab8:0400):
00:1f.4 Multimedia audio controller: Intel Corporation 82801BA/BAM AC'97 Audio Controller (rev 02)
     Subsystem: Device 1ab8:0400
     Flags: bus master, medium devsel, latency 0, IRQ 17
     I/O ports at ee00 [size=256]
     I/O ports at f000 [size=256]
     Kernel driver in use: Intel ICH
     Kernel modules: snd-intel8x0

Now we can make detection code more adequate. I will make patch today.
