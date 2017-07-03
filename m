From: Fulup Ar Foll <fulup.arfoll@iot.bzh>
Subject: Re: ioctl(fd, SNDRV_CTL_IOCTL_ELEM_REPLACE,
 ... not working from userspace ?
Date: Mon, 3 Jul 2017 18:50:11 +0200
Message-ID: <071d305a-2941-4417-4f6e-f9f7d605a510@iot.bzh>
References: <c7599ba3-f6c3-bb46-c08d-efff67ca60e9@iot.bzh>
 <a8252c34-c9ac-22d9-589d-ff2af5ea1188@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id C023A26680F
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 18:50:15 +0200 (CEST)
Received: by mail-wm0-f41.google.com with SMTP id w126so173864780wme.0
 for <alsa-devel@alsa-project.org>; Mon, 03 Jul 2017 09:50:15 -0700 (PDT)
Received: from [10.20.101.100] (sne56-1-88-180-128-218.fbx.proxad.net.
 [88.180.128.218])
 by smtp.googlemail.com with ESMTPSA id x21sm17233443wme.24.2017.07.03.09.50.12
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Jul 2017 09:50:13 -0700 (PDT)
In-Reply-To: <a8252c34-c9ac-22d9-589d-ff2af5ea1188@ladisch.de>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clement,

Are sure about this ?

The ioctl is called from /src/control/control_hw.c inside 
snd_ctl_hw_elem_replace and this is for hardware controls.

At kernel level the iotcl point onto ./sound/core/control.c and calls 
snd_ctl_elem_add_user(ctl, argp, 1) that itself calls snd_ctl_elem_add

Looking at this code I do not understand why the replace iotcl is 
refused. Nevertheless it seems more to come from some lacking data in ly 
ctrlinfo than because of access right (I'm testing as root)

Fulup

On 03/07/17 16:29, Clemens Ladisch wrote:
> Fulup Ar Foll wrote:
>> I try to rename existing sound control from userspace.
> 
> This is allowed only for user controls, i.e., controls that were added
> from userspace.
> 
> 
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
