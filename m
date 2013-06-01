From: Fabio Estevam <festevam@gmail.com>
Subject: Re: aplay lists both Playback and Capture devices
Date: Sat, 1 Jun 2013 16:20:50 -0300
Message-ID: <CAOMZO5BTv2oqZzwXcWs=K8r+tdzCR8MA+DuopYaBnH+fw5Hsug@mail.gmail.com>
References: <CAOMZO5Cq8xSj3fGoZEO+K5xxJNfHotC2PiuX62q+p+yw1-i9Ng@mail.gmail.com>
 <51A736C6.2060500@ladisch.de>
 <CAOMZO5C3eDi_wicdJLab5Dg1yqexkJ6Ffhwwft_2XnO5KHPD+Q@mail.gmail.com>
 <CAOMZO5CfQUnRN8h5gSFV8qAu2YYw4B3hZRBfgkW5DzEmAb3-2A@mail.gmail.com>
 <20130601190622.GM16790@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f173.google.com (mail-vc0-f173.google.com
 [209.85.220.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C136261ADE
 for <alsa-devel@alsa-project.org>; Sat,  1 Jun 2013 21:20:50 +0200 (CEST)
Received: by mail-vc0-f173.google.com with SMTP id ht10so1821564vcb.4
 for <alsa-devel@alsa-project.org>; Sat, 01 Jun 2013 12:20:50 -0700 (PDT)
In-Reply-To: <20130601190622.GM16790@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Sat, Jun 1, 2013 at 4:06 PM, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Jun 01, 2013 at 03:09:38PM -0300, Fabio Estevam wrote:
>
>> root@freescale /$ cat /proc/asound/pcm
>> 00-00: HiFi Playback sgtl5000-0 :  : playback 1 : capture 1
>> 00-01: HiFi Capture sgtl5000-1 :  : playback 1 : capture 1
>
> Hrm, in that case the kernel does seem to be lying about capabilites...
> are all the DAIs correctly listing that they're unidirectional?

What is the proper way to know this information?

Or how do I tell that each DAI is unidirectional?

Thanks,

Fabio Estevam
