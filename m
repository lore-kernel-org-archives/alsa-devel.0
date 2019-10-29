Return-Path: <SRS0=9b6r=YW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF125CA9EAE
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:38:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9B42087F
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DHC3rBw2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Jk8ghROb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9B42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53AC72134;
	Tue, 29 Oct 2019 17:37:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53AC72134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572367120;
	bh=5cCRlKEdwSPd/XahrAhi60x+IpLiZa42AbpIb6OLdso=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DHC3rBw2Ed9PeB/JMiZiMM5J8zimmVfGV3ziPC0cfB4TfuGIVUwbzHyh+tLmobmRc
	 m7DsxmXPLhBDBfQJZVokrBtg0c/mbN4JWOCnHelsZ0AUeCWuTP2ZgAoANcdnbHw5Y9
	 lXtnrTHe0mAhjOOXEE35lam2miBANOPhd46g48as=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B37A1F8036C;
	Tue, 29 Oct 2019 17:37:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88668F80392; Tue, 29 Oct 2019 17:37:47 +0100 (CET)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE9F5F800E7
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2019 17:37:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE9F5F800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="Jk8ghROb"
Received: by mail-io1-xd42.google.com with SMTP id k1so6500110iom.9
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2019 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l/IHM0NPk3TCeNncXTY+2f+GN+RolvlSXlJlzn1vVKw=;
 b=Jk8ghRObiXDw6DwVlHrpng2VI4Egz62tJ3wffppBF8Qgkq/+6z3Y9ONuQHooehYyJG
 e2yTiFf4kpMZ2qHu82Z4lZIV06SzNiQG4P+dQycnVr7fateYHrz8gUbMIAIL4BXCbuLW
 Bv7tZv4+TwBpCTvhmjkWlAhgb9lTRoKHNJuRUtvRY26tXu1patjhaGagN3MKayUrkinW
 9xifXa1kU1jPIh4XE9yW75/rNdGaS5h1DtUC2CkjCpLEBPrQIp8di94x63zqvjfjFuba
 IYlLx5lSHoV9umBwuTDH80BjSIlu5O4dADe8wIMutB8E1mOCGLErUSxf4K/0Y7ozgr5r
 3tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l/IHM0NPk3TCeNncXTY+2f+GN+RolvlSXlJlzn1vVKw=;
 b=n+9o0AvEh0JydgdfE8R+d83vsOqystlMRAFpAex/fUsR8bZbGxPTo7CC4jAsJR/5Ui
 pOregH/VoOcrhgS3GFi+PJVROJxUx9Se75q+PHt5wIEYfJLqPdtGwkmlMEp0mFmNj9xv
 q3TG9bUQ5vFVjXo+fzLHtnPGbIuPdluK12IS1sP55JsUmiYPh062XEnDf9Pkx3jmxFp+
 463glVUfZPofZdKLHwOd7ku0ytzzrT/rVJIyNrraEDKby79A7CybVJg3Hnr7ilzUgd36
 BhRRBZ/lVI95bYa/FWXN30mnrGc/guRCqKx8fuQu6DB9CoWbQuZmqCKxWo73OeQ1p6N5
 9sDw==
X-Gm-Message-State: APjAAAUkz4qF+EpsCmjAL5UT9OLYFBRFQMOxZcQC3ASLjxvxi3aqIL1E
 HCnGBPPaMuDEIIOHzMqYzn+5t5B9qF/jiwcW/DBN7g==
X-Google-Smtp-Source: APXvYqxXzM66N7312oatGw9JdTEPPiPgrwzFa1yjGNBh6m8K7oz9oZDAuhweMffXCJjyJBaOCOly8IsZzBQN4BeuRPE=
X-Received: by 2002:a6b:f40f:: with SMTP id i15mr4493804iog.54.1572367060798; 
 Tue, 29 Oct 2019 09:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191025224122.7718-1-pierre-louis.bossart@linux.intel.com>
 <20191025224122.7718-5-pierre-louis.bossart@linux.intel.com>
 <8172a400-880c-b445-0e37-9611d5f76ccb@intel.com>
In-Reply-To: <8172a400-880c-b445-0e37-9611d5f76ccb@intel.com>
From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Date: Tue, 29 Oct 2019 09:37:30 -0700
Message-ID: <CAFQqKeVv3suGcgj=wdvkOGBNXt6PdDLe8GxvuXSzZ2dm3KXbsg@mail.gmail.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: tiwai@suse.de, Linux-ALSA <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>, Keyon Jie <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 04/26] ASoC: SOF: Intel: hda-dsp: Add
 helper for setting DSP D0ix substate
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, Oct 29, 2019 at 3:10 AM Cezary Rojewski <cezary.rojewski@intel.com>
wrote:

> On 2019-10-26 00:41, Pierre-Louis Bossart wrote:
> > From: Keyon Jie <yang.jie@linux.intel.com>
> >
> > Adding helper to implement setting dsp to d0i3 or d0i0 status, this will
> > be needed for driver D0ix support.
> >
> > Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
> > Signed-off-by: Pierre-Louis Bossart <
> pierre-louis.bossart@linux.intel.com>
>
> > +static int hda_dsp_wait_d0i3c_done(struct snd_sof_dev *sdev, int retry)
> > +{
> > +     struct hdac_bus *bus = sof_to_bus(sdev);
> > +
> > +     while (snd_hdac_chip_readb(bus, VS_D0I3C) & SOF_HDA_VS_D0I3C_CIP) {
> > +             if (!retry--)
> > +                     return -ETIMEDOUT;
> > +             usleep_range(10, 15);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +int hda_dsp_set_power_state(struct snd_sof_dev *sdev,
> > +                         enum sof_d0_substate d0_substate)
> > +{
> > +     struct hdac_bus *bus = sof_to_bus(sdev);
> > +     int retry = 50;
> > +     int ret;
> > +     u8 value;
> > +
> > +     /* Write to D0I3C after Command-In-Progress bit is cleared */
> > +     ret = hda_dsp_wait_d0i3c_done(sdev, retry);
> > +     if (ret < 0) {
> > +             dev_err(bus->dev, "CIP timeout before update D0I3C!\n");
> > +             return ret;
> > +     }
> > +
> > +     /* Update D0I3C register */
> > +     value = d0_substate == SOF_DSP_D0I3 ? SOF_HDA_VS_D0I3C_I3 : 0;
>
> Some indentation or parenthesis would make this cleaner.
>
> > +     snd_hdac_chip_updateb(bus, VS_D0I3C, SOF_HDA_VS_D0I3C_I3, value);
> > +
> > +     /* Wait for cmd in progress to be cleared before exiting the
> function */
> > +     retry = 50;
> > +     ret = hda_dsp_wait_d0i3c_done(sdev, retry);
> > +     if (ret < 0) {
> > +             dev_err(bus->dev, "CIP timeout after D0I3C updated!\n");
> > +             return ret;
> > +     }
> > +
> > +     dev_vdbg(bus->dev, "D0I3C updated, register = 0x%x\n",
> > +              snd_hdac_chip_readb(bus, VS_D0I3C));
> > +
> > +     return 0;
> > +}
> > +
>
> I believe hda_dsp_wait_d0i3c_done function could have had its argument
> list simplified. "retry" is passed externally and it is always set to
> 50. One could put the "retry" right inside _done function. This or allow
> the caller to modify the sleep period. Another option is to replace
> "retry" with "timeout period" (total timeout, that is) entirely.
>
Cezary,

This has been fixed later in the series to use
the HDA_DSP_REG_POLL_RETRY_COUNT but I agree that this can further be
simplified to just use the macro inside the hda_dsp_wait_d0i3c_done()
instead of passing the argument.


>
> In regard to maintenance, both ret checks (resulting in dev_errs) assume
> -ETIMEOUT outcome on _done failure. If said function gets updated in the
> future, these implicit checks might cause problems.
>
Possibly, but at the moment -ETIMEOUT looks like the correct error to be
reported.

Thanks,
Ranjani

>
> >   static int hda_suspend(struct snd_sof_dev *sdev, bool runtime_suspend)
> >   {
> >       struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
> > diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
> > index ea02bf40cb25..0e7c366b8f71 100644
> > --- a/sound/soc/sof/intel/hda.h
> > +++ b/sound/soc/sof/intel/hda.h
> > @@ -64,6 +64,13 @@
> >   #define SOF_HDA_PPCTL_PIE           BIT(31)
> >   #define SOF_HDA_PPCTL_GPROCEN               BIT(30)
> >
> > +/*Vendor Specific Registers*/
>
> Missing spaces.
>
> > +#define SOF_HDA_VS_D0I3C             0x104A
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
