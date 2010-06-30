From: <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 04/16] ASoC: multi-component - TI CODECs
Date: Wed, 30 Jun 2010 14:08:11 +0200
Message-ID: <C358A26273CF2948B8BCDBA661A581782A6FBF945E@NOK-EUMSG-03.mgdnok.nokia.com>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>,
	<1277488383-31287-5-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D11D103814
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jun 2010 14:08:15 +0200 (CEST)
In-Reply-To: <1277488383-31287-5-git-send-email-lrg@slimlogic.co.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk, alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello Liam,

I'm on holiday, and I have limited access to e-mail, but I did taken a brief look at the series..
I have few question:
Is the support for the former codec->idle_bias_off is gone? This patch removes it from the
tlv320dac33, and t2l4030 codec drivers.
I'm not really sure about the restructure of the tlv320dac33 driver:
- The codec ID register read has been removed, which is really useful, and it is going to be
  used to enable/disable features of DAC33 based on the ID.
- Originally the codec was off by default, now it is on all the time.
- What is the reason to move the IRQ, GPIO, and regulator request from the i2c_probe to soc_probe?

Some of these valid for the twl4030 codec as well (especially the idle_bias_off support).

I don't claim, that I have checked all the patches, and changes, but at least with the tlv320dac33,
and twl4030 codec drivers I can see some unwanted (for me) PM related regressions.
Are these removals intentional?
 
Thanks,
Peter

________________________________________
From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-project.org] On Behalf Of ext Liam Girdwood [lrg@slimlogic.co.uk]
Sent: Friday, June 25, 2010 8:52 PM
To: alsa-devel@alsa-project.org
Cc: Mark Brown; Liam Girdwood
Subject: [alsa-devel] [RFC 04/16] ASoC: multi-component - TI CODECs

Move TI CODECs to multi-component

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform device (non MFD codecs only)
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Other required changes due to multi-component model :-

 o tlv320aic3x: no more "setup_data" from ASoC machine drivers, platform data
 must be set in one place only. Moved platform defs out into platorm header.
