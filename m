From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 6/6] ASoC: davinci-mcasp: Add
	overrun/underrun event handling
Date: Tue, 11 Nov 2014 09:47:29 +0200
Message-ID: <5461BF11.7050506@ti.com>
References: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
 <1415615540-28981-7-git-send-email-peter.ujfalusi@ti.com>
 <20141110185814.GE3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id BAE572614D6
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 08:47:34 +0100 (CET)
In-Reply-To: <20141110185814.GE3815@sirena.org.uk>
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
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/10/2014 08:58 PM, Mark Brown wrote:
> On Mon, Nov 10, 2014 at 12:32:20PM +0200, Peter Ujfalusi wrote:
> =

>> +	stat =3D mcasp_get_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG);
>> +	if (stat & XUNDRN) {
>> +		dev_warn(mcasp->dev, "Transmit buffer underflow\n");
>> +		substream =3D mcasp->substreams[SNDRV_PCM_STREAM_PLAYBACK];
>> +		if (substream) {
>> +			snd_pcm_stream_lock_irq(substream);
>> +			if (snd_pcm_running(substream))
>> +				snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
>> +			snd_pcm_stream_unlock_irq(substream);
>> +		}
>> +	}
>> +
>> +	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG, stat);
>> +
>> +	return IRQ_HANDLED;
> =

> This will unconditionally report that any interrupt that gets delivered
> is handled and acknowledged regardles of what was reported.  This isn't
> ideal, I'd at least expect a warning to be printed if we're handling
> interrupts we don't understand.

The setup code only enable interrupt generation for XUNDRN for tx or ROVRN =
for
rx. If we receive the interrupt it is because either of these happened.
We are not yet interested on the other bits in the status register and not =
all
bits are signaling error.
If for example an XSYNCERR happens, we will not know about it till to point=
 we
have XUNDRN, which is going to trigger the interrupt.
If we would have prints for other bits, we should have at least strategy to
deal with them.
At the end of the function we ack the interrupt to the HW.
Most probably we are going to handle more events, but right now we only care
about under or overruns.

-- =

P=E9ter
