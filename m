From: RongJun Ying <rjying@gmail.com>
Subject: Re: [PATCH v5-resend 2/7] ASoC: sirf: Add SiRF audio
 port driver is used by SiRF internal audio codec
Date: Thu, 6 Mar 2014 17:51:43 +0800
Message-ID: <CAByv0RN0NBfaMA4TZgeB6f+MmTQ+CE6ztQ_DHXKZdTxQ7tkwQg@mail.gmail.com>
References: <1394008480-29135-1-git-send-email-rongjun.ying@csr.com>
 <1394008480-29135-3-git-send-email-rongjun.ying@csr.com>
 <20140306092007.GL13126@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f46.google.com (mail-qg0-f46.google.com
 [209.85.192.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 07C412658DC
 for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2014 10:51:44 +0100 (CET)
Received: by mail-qg0-f46.google.com with SMTP id e89so6660544qgf.5
 for <alsa-devel@alsa-project.org>; Thu, 06 Mar 2014 01:51:44 -0800 (PST)
In-Reply-To: <20140306092007.GL13126@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org

2014-03-06 17:20 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Wed, Mar 05, 2014 at 04:34:35PM +0800, RongJun Ying wrote:
>
> Applied, but...
>
>> +     base = devm_ioremap(&pdev->dev, mem_res->start,
>> +                     resource_size(mem_res));
>> +     if (base == NULL)
>> +             return -ENOMEM;
>
> ...use devm_ioremap_resource() instead, please send a followup patch
> fixing this.

The i2s, internal audio codec and audio port use same register physics address
and size. So if one driver use the devm_ioremap_resource instead.
The other driver will invoke devm_ioremap_resource failed.

Thanks

-- 
------------------------------
Rongjun Ying
