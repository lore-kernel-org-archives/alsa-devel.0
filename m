From: RongJun Ying <rjying@gmail.com>
Subject: Re: [PATCH v5-resend 2/7] ASoC: sirf: Add SiRF audio
 port driver is used by SiRF internal audio codec
Date: Wed, 12 Mar 2014 17:56:27 +0800
Message-ID: <CAByv0RNa6b5U_Y6=6h0zOEuRQ2RK4MNuTs64mPqo2wC6L=7XeA@mail.gmail.com>
References: <1394008480-29135-1-git-send-email-rongjun.ying@csr.com>
 <1394008480-29135-3-git-send-email-rongjun.ying@csr.com>
 <20140306092007.GL13126@sirena.org.uk>
 <CAByv0RN0NBfaMA4TZgeB6f+MmTQ+CE6ztQ_DHXKZdTxQ7tkwQg@mail.gmail.com>
 <20140307014957.GR13126@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f52.google.com (mail-qa0-f52.google.com
 [209.85.216.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F6C3260862
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 10:56:28 +0100 (CET)
Received: by mail-qa0-f52.google.com with SMTP id m5so9576266qaj.39
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 02:56:27 -0700 (PDT)
In-Reply-To: <20140307014957.GR13126@sirena.org.uk>
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

2014-03-07 9:49 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Thu, Mar 06, 2014 at 05:51:43PM +0800, RongJun Ying wrote:
>> 2014-03-06 17:20 GMT+08:00 Mark Brown <broonie@kernel.org>:
>
>> > ...use devm_ioremap_resource() instead, please send a followup patch
>> > fixing this.
>
>> The i2s, internal audio codec and audio port use same register physics address
>> and size. So if one driver use the devm_ioremap_resource instead.
>> The other driver will invoke devm_ioremap_resource failed.
>
> That's buggy - there should only be one device for each register range,
> you should have a core MFD driver which gets the hardware resource and
> shares the regmap with the client drivers.

The I2S, internal audio codec and audio port share same register address space.
Do you suggest that I write a MFD driver or write sirf-audio-core .c
to share the regmap and register child audio devices (I2S, internal
codec and port)?

Thanks
-- 
------------------------------
Rongjun Ying
