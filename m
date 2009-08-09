From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: ASoC: PCM formats for AC97
Date: Sun, 9 Aug 2009 11:10:24 -0400
Message-ID: <9e4733910908090810r56b6fc19p2c671b728f13327@mail.gmail.com>
References: <9e4733910908081144s27f4b7fes1e22f838a203c3cf@mail.gmail.com>
	<20090809104830.GC4773@sirena.org.uk>
	<9e4733910908090632m1178daceya0269966fde54529@mail.gmail.com>
	<20090809143747.GA9121@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f176.google.com (mail-yx0-f176.google.com
	[209.85.210.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 273DB24338
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Aug 2009 17:10:26 +0200 (CEST)
Received: by yxe6 with SMTP id 6so3150834yxe.16
	for <alsa-devel@alsa-project.org>; Sun, 09 Aug 2009 08:10:24 -0700 (PDT)
In-Reply-To: <20090809143747.GA9121@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 9, 2009 at 10:37 AM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Aug 09, 2009 at 09:32:22AM -0400, Jon Smirl wrote:
>
>> I agree with you, but I think the second form better indicates the
>> wildcard than the first form. It makes it look like endianess is not a
>> factor.
>
> You need to specify both - the controller may be able to handle data in
> either endianness, not just the native format.

I thought endianess was fixed in the wire protocol standard. It's the
host AC97 controller that is converting the endianess.

I struggled with this when first writing the host driver for my BE
powerpc chip. I kept trying to encode the AC97 wire protocol
definition into the AC97 codec. The trick is that you don't want to
encode it since it is fixed by the standard.

If we declared the AC97 codecs like this, which they really are:
.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,

Then I would need a way to say my powerpc host AC97 controller needs
BE on the input and that it converts it to LE on the output. ALSA
doesn't have a way to say that.

Leaving the endianess off from the AC97 codec definition makes it implicit.
.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16 |
		SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_S32,
We don't need to declare an endianess because it is fixed in the standard.
Now the ifdefs in the h file make this work for both BE and LE.

This also hides another implicit conversion. The AC97 codecs only take
24b. Again it is the host controller that is converting 8/16/32 to
24b.

-- 
Jon Smirl
jonsmirl@gmail.com
