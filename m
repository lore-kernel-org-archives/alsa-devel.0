From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v3 4/9] ASoC: sti: Add CPU DAI driver for
	capture
Date: Wed, 15 Jul 2015 11:31:49 +0200
Message-ID: <55A62885.5080203@st.com>
References: <1434983473-25092-1-git-send-email-arnaud.pouliquen@st.com>
 <1434983473-25092-5-git-send-email-arnaud.pouliquen@st.com>
 <20150710172606.GV11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 85D1126172C
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 11:31:53 +0200 (CEST)
In-Reply-To: <20150710172606.GV11162@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org



On 07/10/2015 07:26 PM, Mark Brown wrote:
> On Mon, Jun 22, 2015 at 04:31:08PM +0200, Arnaud Pouliquen wrote:
>
>> +static int uni_reader_stop(struct uniperif *reader)
>> +{
>> +	/* The reader should not be in stopped state */
>> +	if (reader->state == UNIPERIF_STATE_STOPPED) {
>> +		dev_err(reader->dev, "%s: invalid reader state", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Turn the reader off */
>> +	SET_UNIPERIF_CTRL_OPERATION_OFF(reader);
>> +
>> +	/* Disable interrupts */
>> +	SET_UNIPERIF_ITM_BCLR(reader, GET_UNIPERIF_ITM(reader));
>> +	disable_irq_nosync(reader->irq);
>
> Do you really need to disable interrupts with disable_irq()?  It's more
> normal to just leave the interrupts registered and stop the hardware
> generating them.
Yes i can keep it on, as SET_UNIPERIF_ITM_BCLR  disable generation.
i will update this
