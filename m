From: Daniel Mack <zonque@gmail.com>
Subject: Re: Fwd: Support for Roland VG-99 (working code,
 but could use help)
Date: Fri, 19 Oct 2012 10:24:46 +0200
Message-ID: <50810E4E.2020108@gmail.com>
References: <CABn3OEFatrnhGs1xzpmOfXSxpSLuGwgRtN8v=1B96i6=7_9vTg@mail.gmail.com>
 <CABn3OEHRK7TLp+J_pZjMoFts4bZ=-FquQX0WKCzUcaaMZ8Nrpg@mail.gmail.com>
 <507D0F6D.1000102@gmail.com>
 <CABn3OEF1L7hqVAcjs5E5NveA741HPVd4a9eq0w9sS77PYg+2hQ@mail.gmail.com>
 <507D1C77.5080302@gmail.com>
 <CABn3OEHxhguP6E56DUjfPAgxyaSXOHrRSd7jEdsax3e16Zm3Nw@mail.gmail.com>
 <50810512.2040909@gmail.com>
 <CABn3OEECLmo3LXQ7Zg+HVk4HBO54NgLZgxwV11-7rjQYu8BHQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 39ADA26531C
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 10:24:51 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so56788bku.38
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 01:24:51 -0700 (PDT)
In-Reply-To: <CABn3OEECLmo3LXQ7Zg+HVk4HBO54NgLZgxwV11-7rjQYu8BHQQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pete Leigh <pete.leigh@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 19.10.2012 10:23, Pete Leigh wrote:
> On 19 October 2012 08:45, Daniel Mack <zonque@gmail.com> wrote:
>>> [  248.815369] usb 1-1.6: new full-speed USB device number 6 using ehci_hcd
> [...]]
>>> [  249.073737] cannot submit urb 0, error -28: not enough bandwidth
> 
>> Ok, I have to fix this finally. Are you using a hub or is this device
>> directly connected?
> 
> Directly connected, I assume to this (from lspci)
> 
> :14.0 USB Controller: Intel Corporation Panther Point USB xHCI Host
> Controller (rev 04) (prog-if 30 [XHCI])
>         Subsystem: Hewlett-Packard Company Device 179b
>         Flags: bus master, medium devsel, latency 0, IRQ 46
>         Memory at d4420000 (64-bit, non-prefetchable) [size=64K]
>         Capabilities: [70] Power Management version 2
>         Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
>         Kernel driver in use: xhci_hcd
> 
> That is reported by the distro kernel.. I notice it is using an xhci
> driver, which I think is not enabled in the sound.git kernel I booted.
> I'll try again after enabling CONFIG_USB_XHCI_HCD, in case that helps.

Yes. You should extract the config of the old kernel (/proc/config.gz)
and use this as start for building the upstream.


Daniel
