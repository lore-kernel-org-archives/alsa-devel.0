From: chri <chripell@gmail.com>
Subject: Re: [PATCH] ALSA SOC driver for s3c24xx with uda1341
Date: Tue, 11 Nov 2008 15:16:54 +0100
Message-ID: <cabda6420811110616h6d6cc44fn99d7e549d970fc11@mail.gmail.com>
References: <12261302352402-git-send-email-chripell@gmail.com>
	<20081110133451.GD12804@sirena.org.uk>
	<cabda6420811101104l823d519i8dca6feac86cfa@mail.gmail.com>
	<20081111103931.GA7019@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by alsa0.perex.cz (Postfix) with ESMTP id BC4CB2414D
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 15:16:54 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id e27so1826127nfd.32
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 06:16:54 -0800 (PST)
In-Reply-To: <20081111103931.GA7019@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, zdevai@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 11, 2008 at 11:39 AM, Mark Brown <broonie@sirena.org.uk> wrote:
>
> If you work with current git you'll see that the other drivers have been
> converted to pr_debug().
>

I see, I'm cloning git repository *now*.

>
>> they turn on/off an amplifier with 6db gain in the record and playback
>> respectively.
>
> Should be "ADC +6dB Switch" or similar then.
>

ack

>
> A pointer to a table of dividers would handle it.  In any case, it needs
> more comments.
>

ack,

>> > You want to run this through scripts/checkpatch.pl.
>
>> I already did it
>
> I'd have expected checkpatch to catch the extra space you've got after
> clk_source there...
>

I agree

>
> This function is going to be used in a vtable where IIRC it can be
> optional but it needs to check the value of power in s3c24xx_uda1341_l3_pins.
> It feels like you've got too many layers of indirection here and that,
> for example, the l3_pins power should be assignable directly to the
> vtable.
>

ack

Thanks,


-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
