From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Wierd hack to sound/pci/intel8x0.c
Date: Mon, 07 Nov 2011 11:35:49 +0100
Message-ID: <4EB7B485.3090907@redhat.com>
References: <4EB69EDA.5000901@redhat.com>	<4EB6B285.9050509@parallels.com> <s5h1utlky6i.wl%tiwai@suse.de> <4EB7A404.3070902@redhat.com> <4EB7AA6F.5000909@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4EB7AA6F.5000909@parallels.com>
Sender: kvm-owner@vger.kernel.org
To: Konstantin Ozerkov <kozerkov@parallels.com>
Cc: Takashi Iwai <tiwai@suse.de>, Denis Lunev <den@parallels.com>, Avi Kivity <avi@redhat.com>, "Denis V. Lunev (openvz)" <den@openvz.org>, Linus Torvalds <torvalds@linux-foundation.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, KVM list <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-Id: alsa-devel@alsa-project.org

  Hi,

> We discuss Intel ICH/AC'97 (snd-intel8x0) here, but I hope that PCI SSID
> is same.

Hmm, it's not, the ac97 emulation doesn't use the default qemu subsystem
id for some reason.  Here is the entry:

[root@fedora ~]# lspci -vns6
00:06.0 0401: 8086:2415 (rev 01)
        Subsystem: 8086:0000
        Physical Slot: 6
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at c000 [size=1K]
        I/O ports at c400 [size=256]
        Kernel driver in use: Intel ICH
        Kernel modules: snd-intel8x0

I guess that should be fixed.  8086:0000 isn't valid anyway and I doubt
it serves any useful purpose other than avoiding a guest complaining
about the subsystem id being unset.

/me goes preparing a patch.

cheers,
  Gerd
