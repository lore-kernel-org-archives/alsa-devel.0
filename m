From: Daniel Mack <zonque@gmail.com>
Subject: Re: 3.6.0 regression,
 distorted sound failure while using jack and hd-audio
Date: Sun, 07 Oct 2012 23:27:43 +0200
Message-ID: <5071F3CF.8070907@gmail.com>
References: <20121007213452.08e29880@tenkende-august.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EABA26162E
 for <alsa-devel@alsa-project.org>; Sun,  7 Oct 2012 23:27:47 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so1388447bku.38
 for <alsa-devel@alsa-project.org>; Sun, 07 Oct 2012 14:27:46 -0700 (PDT)
In-Reply-To: <20121007213452.08e29880@tenkende-august.homelinux.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Helge Hafting <helge.hafting@ntebb.no>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

(cc alsa-devel)

On 07.10.2012 21:34, Helge Hafting wrote:
> My sound setup works fine with 3.5.4, but have serious problems with 3.6.0
> 
> It is sound through jack that breaks, simply using "aplay" directly with the
> alsa device works.
> 
> When I use jack, my setup works fine with 3.5.4. But boot into 3.6.0,
> and I get badly distorted sound as if using an extremely overdone reverb effect. 
> And jack reports tons of xruns, several per second.
> 
> This can be worked around by going from 256 to 512 frames/period in the jack
> settings. But that also double the latency, which makes keyboard playing less
> pleasant.
> 
> It is not a case of 256 frames/period being (almost) too extreme for the machine. With kernel 3.5.4,
> I can use 128 frames/period and get mostly ok sound, with only an occational 
> xrun (and a correseponding pop in the sound). So I use 256 because that's solid.
> But with 3.6.0, not even 256 is enough. And it is not an occational pop, but
> awful distortion all the time.
> 
> I don't really know what has changed from 3.5.4 to 3.6.0. The hd-audio driver?
> Something in alsa? Or the scheduling?
> 
> Machine: Dell precision M6600 laptop, 8GB, 2.2GHz quad-core i7.
>          Usually at 800MHz to save power, this is enough for making sound.
> Kernels: 64-bit 3.5.4 or 3.6.0
> Distro: funtoo
> 
> Audio according to lspci:
> 00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset Family High Definition Audio Controller (rev 04)
> 
> Please tell if there is anything I should try. I can test other kernel versions
> or try patches.
> 
> Helge Hafting
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
