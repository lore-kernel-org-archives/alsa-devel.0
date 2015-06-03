From: Ben Zhang <benzh@chromium.org>
Subject: Re: [PATCH] ASoC: core: Pass kcontrol pointer to bytes
	tlv callbacks
Date: Wed, 3 Jun 2015 14:10:28 -0700
Message-ID: <CAOV7ByLAwtv1n4wdww=5r7wvCDOtwh7+g_3AqZAaPF=R8zmsTg@mail.gmail.com>
References: <1433283843-33856-1-git-send-email-benzh@chromium.org>
 <20150603115951.GG14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 08B73265DB9
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 23:10:30 +0200 (CEST)
Received: by pdbnf5 with SMTP id nf5so15512989pdb.2
 for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2015 14:10:28 -0700 (PDT)
In-Reply-To: <20150603115951.GG14071@sirena.org.uk>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dylan Reid <dgreid@chromium.org>, alsa-devel <alsa-devel@alsa-project.org>, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 3, 2015 at 4:59 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jun 02, 2015 at 03:24:03PM -0700, Ben Zhang wrote:
>
>> -     int (*get)(unsigned int __user *bytes, unsigned int size);
>> -     int (*put)(const unsigned int __user *bytes, unsigned int size);
>> +     int (*get)(struct snd_kcontrol *kcontrol,
>> +                unsigned int __user *bytes, unsigned int size);
>> +     int (*put)(struct snd_kcontrol *kcontrol,
>> +                const unsigned int __user *bytes, unsigned int size);
>
> This doesn't update any users and we do have some like the Haswell PCM
> driver.

Hi Mark,

I couldn't find any existing users of the callbacks. It looks like the
modified callbacks are used by SND_SOC_BYTES_TLV only, and there is no
reference to SND_SOC_BYTES_TLV in the kernel.

The Haswell PCM driver uses SND_SOC_BYTES_EXT which doesn't use the
callbacks in struct soc_bytes_ext. The xhandler_get/put are assigned
to snd_kcontrol_new.get/put instead.

Ben
