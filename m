From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: How can I make sure the period size is a multiple
 of 16?
Date: Wed, 05 Sep 2007 11:08:03 +0200
Message-ID: <1188983283.8449.1208975085@webmail.messagingengine.com>
References: <46DDE137.2070507@freescale.com>
	<200709051229.54852.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id C546D103803
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 11:08:03 +0200 (CEST)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4DAC527916
	for <alsa-devel@alsa-project.org>; Wed,  5 Sep 2007 05:08:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200709051229.54852.linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Eliot Blennerhassett wrote:
> Set snd_pcm_hardware.period_bytes_min to 16 or is that 16 * samplesize?

This value is measured in bytes.

> snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 16);

This parameter is measured in frames.


HTH
Clemens
