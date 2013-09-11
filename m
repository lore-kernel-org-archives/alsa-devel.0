From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: wm8903: disable IRQs during BIAS_OFF
Date: Wed, 11 Sep 2013 10:16:56 -0600
Message-ID: <52309778.9010004@wwwdotorg.org>
References: <1378752289-6301-1-git-send-email-swarren@wwwdotorg.org>
 <20130909202726.GU29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id E0649261AA0
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2013 18:17:00 +0200 (CEST)
In-Reply-To: <20130909202726.GU29403@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 09/09/2013 02:27 PM, Mark Brown wrote:
> On Mon, Sep 09, 2013 at 12:44:49PM -0600, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>> 
>> If the WM8903 IRQ is triggered after the device is suspended, or
>> before it is resumed, the underlying I2C bus that the WM8903 is
>> attached to may not be available. This may cause the IRQ handler
>> to emit the following error:
>> 
>> wm8903 0-001a: Failed to read IRQ status: -16
>> 
>> ... or perhaps even cause a failure inside the I2C driver.
>> 
>> To prevent this, explicitly mask all interrupt sources when
>> entering BIAS_OFF. Also, modify the IRQ handler to immediately
>> return if the device is in BIAS_OFF, so that shared interrupt
>> lines don't cause a similar problem. This requires that WM8903
>> interrupts be disabled to avoid interrupt storms.
>> 
>> During resume (actually, the transition back to BIAS_STANDBY),
>> restore the desired IRQ mask.
> 
> This should be being handled in at a framework level, there's a
> generic problem here that affects essentially every device out
> there which might need interrupts over suspend (and causes
> relatively frequent problems). Your fix also won't help if someone
> has arranged for the wm8903 mic detect to be a wake source which
> you normally want in phone or tablet type applications but is where
> this sort of issue most frequently bites since we'll never turn the
> device off the interrupt does need to be asserted to kick off the
> wake.
> 
> Drivers usually work around this by disabling their interrupt with 
> disable_irq() between suspend() and suspend_late(), then doing the
> same thing again between resume_noirq() and resume() covering both
> the windows where this can happen.  This preserves the ability to
> wake from the interrupt but it's not awesome; ideally genirq would
> be able to understand that it can't deliver interrupts to a
> suspended device but then of course at the minute genirq has no
> idea that a device is even associated with the interrupt.

So I suppose request_irq() could be enhanced to associate IRQs with
devices, which would at least give genirq the knowledge it needs to
mask interrupts before devices were resumed.

However, I'm not sure it's possible for genirq to handle this
transparently in all situations.

When would the IRQ be re-enabled again?

If it the IRQ is enabled immediately before the device's resume() is
called, then IRQs can still fire while the device is suspended. That
would solve the issue at hand here; that the I2C device used for
register IO wasn't resumed when the IRQ fired, but could presumably
still be problematic for the device itself, in general if not in this
case. Perhaps drivers just need to support this?

If the IRQ is enabled immediately after the device's resume() is
called, then a device wouldn't be able to receive IRQs during the
execution of resume(), which I assume would completely break some drivers?

This gets more complicated with shared IRQ lines, since it wouldn't be
possible to enable the IRQ immediately before/after *a* device's
resume() was called, but rather, this could only happen immediately
before/after the resume() for *all* devices using that IRQ were called.

It seems like the only way a driver can really manage IRQ handling in
the general case is to mask interrupts at the source, like this patch
does, rather than mask them at the interrupt controller, where the IRQ
may already be shared.

I guess that means that for wakeup interrupts, the driver does indeed
need to disable the interrupt at the source between resume_noirq() and
resume(), although I have no idea how that could possibly work, if the
register IO is over an I2C device that itself uses its own interrupts...
