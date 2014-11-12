From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problems with usb soundcard in kernels > 3.3
Date: Wed, 12 Nov 2014 15:36:12 +0100
Message-ID: <5463705C.8060808@ladisch.de>
References: <5461EFAF.7040205@amano.eu> <54620FEF.3000201@ladisch.de>
 <546217FD.1030806@amano.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 2F20D2656F6
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 15:36:18 +0100 (CET)
In-Reply-To: <546217FD.1030806@amano.eu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bogdan Veringioiu <bogdan.veringioiu@amano.eu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Bogdan Veringioiu wrote:
> There is one message that appears in syslog, but it is always
> displayed when I test with aplay, unregarding the kernel version.
>
> --> with kernel 3.2.0-4-686-pae
> kernel: [ 2829.369380] 2:1:1: cannot get freq at ep 0x2
>
> --> with kernel 3.16-0.bpo.2-686-pae
> kernel: [  199.353227] usb 2-1: 1:1: cannot get freq at ep 0x2

This indicates a bug in the device's firmware.

The timeout for control messages was increased from 100 ms to 1000 ms
in kernel 3.3.


Regards,
Clemens
