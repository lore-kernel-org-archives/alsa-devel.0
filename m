From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-devel] add support for syba 7.1 surround
	sound card
Date: Tue, 21 May 2013 10:50:57 +0200
Message-ID: <519B3571.3070601@ladisch.de>
References: <51804394.a36cec0a.2c7d.291b@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay02.ispgateway.de (smtprelay02.ispgateway.de
 [80.67.31.25]) by alsa0.perex.cz (Postfix) with ESMTP id A1C7026172C
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2013 10:51:30 +0200 (CEST)
In-Reply-To: <51804394.a36cec0a.2c7d.291b@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: good1.2guy@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

good1.2guy@gmail.com wrote:
> Summary: add support for syba 7.1 surround sound card
> Keywords: syba via VT1723 Tremor
> Kernel: 3.8.8-203.fc18.x86_64

What are these three lines for?

> add support for syba 7.1 surround sound card
> actually the card only has 6 dmas, so it is really only 5.1

The website shows a daughterboard.

> added code to force_rate setting to not fail EBUSY when the dmas are running.
> suggest using force_rate with pulseaudio to avoid loops with error logging.

This sounds as if it has nothing to do with this particular SYBA card
but affects all VT1723 cards.  Please move it into a separate patch.

And there should be no reason for a module parameter; if this is a bug
in the driver and/or in PulseAudio, it should be just fixed.

> Signed-off-by: psmith2004@yahoo.com

Real names only.

Please read Documentation/SubmittingPatches.

> +static void syba_quirk_open(struct snd_ice1712 *ice)
> +{
> +	unsigned long flags;

It's common to have an empty line here.

> +	spin_lock_irqsave(&ice->reg_lock, flags);
> +	outb(0xff, ICEREG1724(ice, AC97_CFG));
> +	udelay(500);
> +	outb(ice->eeprom.data[ICE_EEP2_ACLINK], ICEREG1724(ice, AC97_CFG));
> +	spin_unlock_irqrestore(&ice->reg_lock, flags);
> +}

What is the reason for this quirk?
Is it possible that this might be needed for other cards using a AC'97
codec?


Regards,
Clemens
