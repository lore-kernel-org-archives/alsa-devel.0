From: Daniel Mack <zonque@gmail.com>
Subject: Re: Fwd: Support for Roland VG-99 (working code,
 but could use help)
Date: Fri, 19 Oct 2012 09:45:22 +0200
Message-ID: <50810512.2040909@gmail.com>
References: <CABn3OEFatrnhGs1xzpmOfXSxpSLuGwgRtN8v=1B96i6=7_9vTg@mail.gmail.com>
 <CABn3OEHRK7TLp+J_pZjMoFts4bZ=-FquQX0WKCzUcaaMZ8Nrpg@mail.gmail.com>
 <507D0F6D.1000102@gmail.com>
 <CABn3OEF1L7hqVAcjs5E5NveA741HPVd4a9eq0w9sS77PYg+2hQ@mail.gmail.com>
 <507D1C77.5080302@gmail.com>
 <CABn3OEHxhguP6E56DUjfPAgxyaSXOHrRSd7jEdsax3e16Zm3Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 00DD42652F0
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 09:45:24 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so42267bku.38
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 00:45:24 -0700 (PDT)
In-Reply-To: <CABn3OEHxhguP6E56DUjfPAgxyaSXOHrRSd7jEdsax3e16Zm3Nw@mail.gmail.com>
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

On 19.10.2012 01:38, Pete Leigh wrote:
> Hi Daniel,
> 
> On 16 October 2012 09:36, Daniel Mack <zonque@gmail.com> wrote:
> 
>>>> Check out the latestes sound.git[*] and make sure your patch applies
>>>> there.
> 
>> And I missed the annotation in the previous mail, so here it is:
> 
>> [*] git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> 
> I've got this kernel (sound.git) booting now, but I find that USB
> audio isn't working
> before I touch it.
> 
> When I connect my (known working) UA-25, this happens:
> 
> [  248.815369] usb 1-1.6: new full-speed USB device number 6 using ehci_hcd
> [  248.913064] usb 1-1.6: New USB device found, idVendor=0582, idProduct=0074
> [  248.913068] usb 1-1.6: New USB device strings: Mfr=1, Product=2,
> SerialNumber=0
> [  248.913071] usb 1-1.6: Product: EDIROL UA-25
> [  248.913074] usb 1-1.6: Manufacturer: Roland
>  mtp-probe: checking bus 1, device 6:
> "/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6"
>  mtp-probe: bus: 1, device: 6 was not an MTP device
> [  249.073737] cannot submit urb 0, error -28: not enough bandwidth

Ok, I have to fix this finally. Are you using a hub or is this device
directly connected?


Daniel
