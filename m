From: Bogdan Veringioiu <bogdan.veringioiu@amano.eu>
Subject: Re: Problems with usb soundcard in kernels > 3.3
Date: Wed, 12 Nov 2014 12:22:17 +0100
Message-ID: <546342E9.1010101@amano.eu>
References: <5461EFAF.7040205@amano.eu> <54620FEF.3000201@ladisch.de>
 <546217FD.1030806@amano.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.amano.be (84-199-99-210.ifiber.telenet-ops.be
 [84.199.99.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 131D2261292
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 12:22:18 +0100 (CET)
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

any idea on how to further debug this issue?
Thanks,
Bogdan

On 11/11/2014 03:06 PM, Bogdan Veringioiu wrote:
> Hi,
>
> thanks for your availability.
> There is one message that appears in syslog, but it is always displayed
> when I test with aplay, unregarding the kernel version. It shows both
> with the working kernel (3.2) and with the problematic one (3.16).
>
> --> with kernel 3.2.0-4-686-pae
> /var/log/syslog
> ...
> kernel: [ 2829.369380] 2:1:1: cannot get freq at ep 0x2
> ...
>
> --> with kernel 3.16-0.bpo.2-686-pae
> /var/log/syslog
> ...
> kernel: [  199.353227] usb 2-1: 1:1: cannot get freq at ep 0x2
> ...
>
> Bogdan
>
> On 11/11/2014 02:32 PM, Clemens Ladisch wrote:
>> Bogdan Veringioiu wrote:
>> > The issue I am experiencing is a ~4 seconds delay in playing sound.
>> > I am reproducing the problem using aplay. The sound play is being
>> > delayed by more or less 4 seconds from the moment the file is sent
>> > to the card. I have tested with kernels 3.2 and 3.3, which work
>> > properly. I have noticed this delay/wait when using kernels 3.15,
>> > 3.16.
>>
>> Any messages in the system log when this happens?
>>
>>
>> Regards,
>> Clemens
>>
>
