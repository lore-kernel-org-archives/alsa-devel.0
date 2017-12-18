From: gianluca <gianlucarenzi@eurekelettronica.it>
Subject: Re: [PATCH v9 10/13] IIO: ADC: add stm32 DFSDM support
 for PDM microphone
Date: Mon, 18 Dec 2017 09:33:59 +0100
Message-ID: <672e8de1-dcfb-d73a-c4e5-5e3e1905f06e@eurekelettronica.it>
References: <1513241885-32079-1-git-send-email-arnaud.pouliquen@st.com>
 <1513241885-32079-11-git-send-email-arnaud.pouliquen@st.com>
 <20171217125459.5adab2be@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qmail.e-mind.com (qmail.e-mind.com [188.94.192.42])
 by alsa0.perex.cz (Postfix) with SMTP id 08B7A267439
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 09:34:02 +0100 (CET)
In-Reply-To: <20171217125459.5adab2be@archlinux>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/17/2017 01:54 PM, Jonathan Cameron wrote:
> On Thu, 14 Dec 2017 09:58:02 +0100
>> +static ssize_t dfsdm_adc_audio_set_spiclk(struct iio_dev *indio_dev,
>> +					  uintptr_t priv,
>> +					  const struct iio_chan_spec *chan,
>> +					  const char *buf, size_t len)
>> +{
>> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>> +	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
>> +	struct stm32_dfsdm_channel *ch = &adc->dfsdm->ch_list[adc->ch_id];
>> +	unsigned int sample_freq = adc->sample_freq;
>> +	unsigned int spi_freq;
>> +	int ret;
>> +
>> +	dev_err(&indio_dev->dev, "enter %s\n", __func__);
         ^^^^^^^

Why dev_err() and not dev_dbg()??? I suppose to force the log even with 
a lower debuglevel value, but it is wrong here. It could be better a 
dev_warn() if you want to notify the calling of this function anyway,



-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
