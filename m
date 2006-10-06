From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: 1.0.13 and indigoio
Date: Fri, 6 Oct 2006 11:54:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0610061150380.4839@denise.shiny.it>
References: <70a871c80610050536w2968cd52n32a5960899b4e90b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <70a871c80610050536w2968cd52n32a5960899b4e90b@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Dmitry Baikov <dsbaikov@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Thu, 5 Oct 2006, Dmitry Baikov wrote:

> Hello!
>
> Echo Indigo IO refuses to work with alsa-driver > 1.0.11
> with alsa-driver/alsa-firmware-1.0.12:
>
> [ 4212.781000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level,
> low) -> IRQ 177
> [ 4212.781000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
> [ 4213.094000] ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level,
> low) -> IRQ 185
> [ 4213.163000] ALSA
> /mnt/bits/portage/tmp/portage/alsa-driver-1.0.12/work/alsa-driver-1.0.12/pci/echoaudio/../../alsa-kernel/pci/echoaudio/echoaudio.c:46:
> get_firmware(): Firmware not available (-2)
> [ 4213.163000] ALSA
> /mnt/bits/portage/tmp/portage/alsa-driver-1.0.12/work/alsa-driver-1.0.12/pci/echoaudio/../../alsa-kernel/pci/echoaudio/echoaudio_dsp.c:249:
> Firmware not found !
> [ 4213.163000] Echoaudio Indigo IO: probe of 0000:07:00.0 failed with error -2
>
>
> with driver/firmware-1.0.13:
>
> [ 4361.080000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level,
> low) -> IRQ 177
> [ 4361.080000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
> [ 4361.306000] ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level,
> low) -> IRQ 185
> [ 4387.819000] Echoaudio Indigo IO: probe of 0000:07:00.0 failed with error -5

There were a stupid bug in the makefile of alsa-firmware that prevented 
loader_dsp.fw from being installed, so most recent cards didn't work. I 
fixed it in 1.0.12 IIRC. The -EIO error with 1.0.13 is a different 
problem. [another msg follows]


--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
