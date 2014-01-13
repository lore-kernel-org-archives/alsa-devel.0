From: LANGLOIS Olivier PIS -EXT <olivier.pis.langlois@transport.alstom.com>
Subject: Re: [ISSUE] crackles and clicks
Date: Mon, 13 Jan 2014 16:32:30 +0000
Message-ID: <89F8E4011FD7234ABFE48744E300CBC206BC3EF2@041-DB3MPN1-093.041d.mgd.msft.net>
References: <CA+T9nP9VBdW6T8o3=5hFJpMXpHGz59VOGva2+8g8xoPw6Xa8+g@mail.gmail.com>
 <s5hy52kt71z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from as-smtp1.itc.alstom.com (as-smtp1.itc.alstom.com
 [159.245.16.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FEDD2602AD
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 17:32:56 +0100 (CET)
In-Reply-To: <s5hy52kt71z.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> At Mon, 13 Jan 2014 09:34:04 +0100,
> Eric F wrote:
> >
> > Hello,
> >
> > I tried my DAC (Tenor TE8802 chipset) in USB on Archlinux (LTS 3.10.26).
> > I can hear regularly crackles ans clicks.
> >
> > I've tried all available USB ports, other kernels (3.12.6, 3.12.7),
> > other distro (ubuntu), without luck...
> >
> > The DAC is Teac UD-H01.
> >
> > here is lsusb verbose : http://ix.io/9Q4
> >
> > Feel free to ask for more precisions, I'll give you all you need.
>
> Which program / sound backend did you test?  Do the crackles happen with
> the plain "aplay -Dplughw foo.wav", too?
>
>
> Takashi

If this can help in the investigation of your problem, I can experience crackles and clicks during pcm playback on my small hpmini notebook. I have kinda nailed down the source of the crackles and clicks.

It turns out that when my Wifi card is on but not connected, I have the crackles and clicks. If I connect to a Wifi network or close the Wifi, the crackles and clicks go away. I have not had the time check the Wifi driver code yet but my explanation of the behavior is that in that specific state, some wifi IRQ handler is taking too much time and stop my sound device irqs to be timely serviced.

My advice, is try to unload as much as possible kernel driver modules that may interfere with your audio playback and see if your crackles and clicks go away. For reference, here is my HW, in case you have the same Wifi Adapter....

00:1b.0 Audio device [0403]: Intel Corporation NM10/ICH7 Family High Definition Audio Controller [8086:27d8] (rev 02)
  Subsystem: Hewlett-Packard Company Device [103c:1584]
  Flags: bus master, fast devsel, latency 0, IRQ 45
  Memory at 96200000 (64-bit, non-prefetchable) [size=16K]
  Capabilities: [50] Power Management version 2
  Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
  Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
  Capabilities: [100] Virtual Channel
  Capabilities: [130] Root Complex Link
  Kernel driver in use: snd_hda_intel
  Kernel modules: snd_hda_intel

01:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8188CE 802.11b/g/n WiFi Adapter [10ec:8176] (rev 01)
  Subsystem: Hewlett-Packard Company Device [103c:1629]
  Flags: bus master, fast devsel, latency 0, IRQ 16
  I/O ports at 3000 [size=256]
  Memory at 95000000 (64-bit, non-prefetchable) [size=16K]
  Capabilities: [40] Power Management version 3
  Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
  Capabilities: [70] Express Endpoint, MSI 00
  Capabilities: [100] Advanced Error Reporting
  Capabilities: [140] Virtual Channel
  Capabilities: [160] Device Serial Number 01-91-81-fe-ff-4c-e0-00
  Kernel driver in use: rtl8192ce
  Kernel modules: rtl8192ce

________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may be privileged. If you are not a named recipient, please notify the sender immediately and do not disclose the contents to another person, use it for any purpose or store or copy the information in any medium.
