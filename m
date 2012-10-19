From: Pete Leigh <pete.leigh@gmail.com>
Subject: Re: Fwd: Support for Roland VG-99 (working code,
 but could use help)
Date: Fri, 19 Oct 2012 09:49:57 +0100
Message-ID: <CABn3OEF18-Q3agOZ3Er5BODDo2R=H-G4Njdua-1L_E1uXHqpMw@mail.gmail.com>
References: <CABn3OEFatrnhGs1xzpmOfXSxpSLuGwgRtN8v=1B96i6=7_9vTg@mail.gmail.com>
 <CABn3OEHRK7TLp+J_pZjMoFts4bZ=-FquQX0WKCzUcaaMZ8Nrpg@mail.gmail.com>
 <507D0F6D.1000102@gmail.com>
 <CABn3OEF1L7hqVAcjs5E5NveA741HPVd4a9eq0w9sS77PYg+2hQ@mail.gmail.com>
 <507D1C77.5080302@gmail.com>
 <CABn3OEHxhguP6E56DUjfPAgxyaSXOHrRSd7jEdsax3e16Zm3Nw@mail.gmail.com>
 <50810512.2040909@gmail.com>
 <CABn3OEECLmo3LXQ7Zg+HVk4HBO54NgLZgxwV11-7rjQYu8BHQQ@mail.gmail.com>
 <50810E4E.2020108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f179.google.com (mail-ia0-f179.google.com
 [209.85.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 52AB8261669
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 10:49:58 +0200 (CEST)
Received: by mail-ia0-f179.google.com with SMTP id k25so137137iah.38
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 01:49:57 -0700 (PDT)
In-Reply-To: <50810E4E.2020108@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 19 October 2012 09:24, Daniel Mack <zonque@gmail.com> wrote:
> On 19.10.2012 10:23, Pete Leigh wrote:
>> On 19 October 2012 08:45, Daniel Mack <zonque@gmail.com> wrote:
>>>> [  248.815369] usb 1-1.6: new full-speed USB device number 6 using ehci_hcd
>> [...]]
>>>> [  249.073737] cannot submit urb 0, error -28: not enough bandwidth
>>
>>> Ok, I have to fix this finally. Are you using a hub or is this device
>>> directly connected?
>>
>> Directly connected, I assume to this (from lspci)
>>
>> :14.0 USB Controller: Intel Corporation Panther Point USB xHCI Host
>> Controller (rev 04) (prog-if 30 [XHCI])
>>         Subsystem: Hewlett-Packard Company Device 179b
>>         Flags: bus master, medium devsel, latency 0, IRQ 46
>>         Memory at d4420000 (64-bit, non-prefetchable) [size=64K]
>>         Capabilities: [70] Power Management version 2
>>         Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
>>         Kernel driver in use: xhci_hcd
>>
>> That is reported by the distro kernel.. I notice it is using an xhci
>> driver, which I think is not enabled in the sound.git kernel I booted.
>> I'll try again after enabling CONFIG_USB_XHCI_HCD, in case that helps.
>
> Yes. You should extract the config of the old kernel (/proc/config.gz)
> and use this as start for building the upstream.

No dice with xchi enabled. In any case, when I look properly, there's 3 entries
in the lspci output for the host controller - one xhci and two ehci.

The ehci ones (reported under sound.git) are:

00:1a.0 USB Controller: Intel Corporation Panther Point USB Enhanced Host Contro
ller #2 (rev 04) (prog-if 20 [EHCI])
        Subsystem: Hewlett-Packard Company Device 179b
        Flags: bus master, medium devsel, latency 0, IRQ 16
        Memory at d4439000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port: BAR=1 offset=00a0
        Capabilities: [98] PCI Advanced Features
        Kernel driver in use: ehci_hcd

00:1d.0 USB Controller: Intel Corporation Panther Point USB Enhanced
Host Controller #1 (rev 04) (prog-if 20 [EHCI])
        Subsystem: Hewlett-Packard Company Device 179b
        Flags: bus master, medium devsel, latency 0, IRQ 16
        Memory at d4438000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port: BAR=1 offset=00a0
        Capabilities: [98] PCI Advanced Features
        Kernel driver in use: ehci_hcd

It also shows the xhci one, now, too.

There's no change to the behaviour when connecting the UA-25 - still
shows "using ehci",  which looks like what the distro kernel reports
too.

I'll try re-doing the kernel based off config.gz from the distro
kernel, as you suggest, probably this evening. What I'd actually done
was make defconfig, make localmodconfig and make menuconfig (enabling
a few things necessary to boot, and making the sound drivers be
modules)

If this problem is confined to the usb subsystem, it seems unlikely I
broke anything with my config operations, but I'm no expert certainly.

Cheers,

- Pete.
