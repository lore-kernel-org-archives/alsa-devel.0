From: Bogdan Veringioiu <bogdan.veringioiu@amano.eu>
Subject: Re: Problems with usb soundcard in kernels > 3.3
Date: Thu, 13 Nov 2014 15:29:24 +0100
Message-ID: <5464C044.3070209@amano.eu>
References: <5461EFAF.7040205@amano.eu> <54620FEF.3000201@ladisch.de>
 <546217FD.1030806@amano.eu> <5463705C.8060808@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.amano.be (84-199-99-210.ifiber.telenet-ops.be
 [84.199.99.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F3E0260483
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 15:29:25 +0100 (CET)
In-Reply-To: <5463705C.8060808@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you very much.
Your insight was helpful.
Indeed the wait is caused by the timeout in control messages.
The timeout is now (kernels 3.15, 3.16) set according with the global 
timeout defined in usb.h (5 seconds):

-->linux/usb.h
#define USB_CTRL_GET_TIMEOUT  5000
#define USB_CTRL_SET_TIMEOUT  5000

-->sound/usb/helper.c
   if (requesttype & USB_DIR_IN)
     timeout = USB_CTRL_GET_TIMEOUT;
   else
     timeout = USB_CTRL_SET_TIMEOUT;
   err = usb_control_msg(dev, pipe, request, requesttype,
             value, index, buf, size, timeout);

so, this explains the 5 seconds delay.

In kernel 3.2, the timeout in helper.c was 1 second (hardcoded):

-->sound/usb/helper.c
   err = usb_control_msg(dev, pipe, request, requesttype,
             value, index, buf, size, 1000);

this explains the faster response in older kernels.

The timeout is received when reading the sample rate from the device,
and then the error message "cannot get freq..." is displayed in syslog.

I have modified the timeout (reverted to 1 second) as a test in the new 
kernel and recompiled the module, the result was as expected, faster 
response.

I will contact the manufacturer to ask about this problem.

Thank you again.
Bogdan



On 11/12/2014 03:36 PM, Clemens Ladisch wrote:
> Bogdan Veringioiu wrote:
> > There is one message that appears in syslog, but it is always
> > displayed when I test with aplay, unregarding the kernel version.
> >
> > --> with kernel 3.2.0-4-686-pae
> > kernel: [ 2829.369380] 2:1:1: cannot get freq at ep 0x2
> >
> > --> with kernel 3.16-0.bpo.2-686-pae
> > kernel: [  199.353227] usb 2-1: 1:1: cannot get freq at ep 0x2
>
> This indicates a bug in the device's firmware.
>
> The timeout for control messages was increased from 100 ms to 1000 ms
> in kernel 3.3.
>
>
> Regards,
> Clemens
>
