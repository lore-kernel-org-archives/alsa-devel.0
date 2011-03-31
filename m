From: Kelly Anderson <kelly@silka.with-linux.com>
Subject: Re: Linux 2.6.38 freeze because of sound/core/pcm_lib.c commit 59ff878ffb26bc0be812ca8295799164f413ae88
Date: Thu, 31 Mar 2011 15:50:32 -0600
Message-ID: <4D94F728.60609@silka.with-linux.com>
References: <AANLkTin17=rCU4eDGYtnVFZ1ffbUn+var4Q_AQUuGKaw@mail.gmail.com>	<4D946C73.4090402@ladisch.de> <AANLkTinyRqEa_ML47DOqAJU8aLDEA12geiUUrPGjXHrN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinyRqEa_ML47DOqAJU8aLDEA12geiUUrPGjXHrN@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Christopher K." <c.krooss@googlemail.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/31/11 10:09, Christopher K. wrote:
> On 31 March 2011 13:58, Clemens Ladisch<clemens@ladisch.de>  wrote:
>> Please try this patch:
> I'm afraid the patch you provided did not change anything for me. I
> applied it to 2.6.38.2,
> still freezes 15 - 20 seconds after startup (Could be around the time
> pulseaudio initializes).
> Is there any way to provide you with more debug information?
>
> Onboard: VIA VT1828S
>
> HDA Intel 0000:00:1b.0: PCI INT A ->  GSI 22 (level, low) ->  IRQ 22
> HDA Intel 0000:00:1b.0: irq 47 for MSI/MSI-X
> HDA Intel 0000:00:1b.0: setting latency timer to 64
> nvidia: module license 'NVIDIA' taints kernel.
> hda-codec: no NID for mapping control Independent HP:0:0
> HDA Intel 0000:01:00.1: PCI INT B ->  GSI 17 (level, low) ->  IRQ 17
> hda_intel: Disable MSI for Nvidia chipset
> HDA Intel 0000:01:00.1: setting latency timer to 64
> ...
> hda_intel: Disable MSI for Nvidia chipset
> nvidia 0000:01:00.0: PCI INT A ->  GSI 16 (level, low) ->  IRQ 16
> nvidia 0000:01:00.0: setting latency timer to 64
> NVRM: loading NVIDIA UNIX x86_64 Kernel Module  270.30  Fri Feb 25
> 14:34:55 PST 2011
>
> I use a Nvidia gtx 460, could it be related (as it features sound capabilities)?
> Using nouveau does not change anything, neither does 2.6.39-rc1.
Clemens,

Just to let you know.  I'm using a gtx460 also.  I haven't had a chance 
to reboot into the newly patched kernel yet.  It is interesting that we 
both have gtx460's.  I have a machine with a gtx430 that doesn't seem to 
exhibit the problem.

cat /etc/modprobe.d/snd_hda_intel.conf

options snd-hda-intel probe_mask=-1,0xa
