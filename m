From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH] ASoC: Codec driver for Texas Instruments
 tlv320dac33 codec
Date: Tue, 13 Oct 2009 07:52:13 +0300
Message-ID: <1255409533.30157.274.camel@eenurkka-desktop>
References: <1255348139-13609-1-git-send-email-peter.ujfalusi@nokia.com>
	<20091012151800.GB18283@rakim.wolfsonmicro.main>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 9373B103866
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 06:53:33 +0200 (CEST)
In-Reply-To: <20091012151800.GB18283@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-10-12 at 17:18 +0200, ext Mark Brown wrote:
> > +static void dac33_set_power(struct snd_soc_codec *codec, int power)
> > +{
> > +	struct tlv320dac33_priv *dac33 = codec->private_data;
> > +
> > +	if (power) {
> > +		if (dac33->power_gpio >= 0) {
> > +			mutex_lock(&dac33->mutex);
> > +			gpio_set_value(dac33->power_gpio, 1);
> > +			dac33->power_state = 1;
> > +			mutex_unlock(&dac33->mutex);
> > +		}
> > +		dac33_soft_power(codec, 1);
> 
> What exactly is the mutex protecting here?  I'd expect it to cover the
> soft power function too.

Agreed the mutex doesn't help any on the power on path. However, if you
hold the mutex already with the call to dac33_soft_power(), that will
eventually deadlock - as currently the mutex is taken for every i2c
transaction out there. But for the power off path, it's more than
desired.

The use of this mutex appears quite aggressive - it's taken for every
i2c transaction. But it does cover the fatal case - where the dac33 is
powered down (just imagine what happens to an i2c transaction if the RST
line is being asserted during i2c read/write to the chip).

I guess the mutex may be brought higher in the hierarchy at some point
of time. That is to also say that the dac33 i2c write sequences would
then become "linear", which would be nice for the robustness overall;
quoting the few lines:

"+ * tlv320dac33 is strict on the sequence of the register writes, if
the register
+ * writes happens in different order, than dac33 might end up in
unknown state."

it seems that indeed linearizing i2c write(read) sequences would not be
a bad idea after all.
