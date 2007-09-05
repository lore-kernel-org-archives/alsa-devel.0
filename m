From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: How can I make sure the period size is a multiple
 of 16?
Date: Wed, 5 Sep 2007 02:55:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709050254180.31808@shell4.speakeasy.net>
References: <46DDE137.2070507@freescale.com>
	<200709051229.54852.linux@audioscience.com>
	<1188983283.8449.1208975085@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.sea5.speakeasy.net (mail3.sea5.speakeasy.net
	[69.17.117.5]) by alsa0.perex.cz (Postfix) with ESMTP id 0C94C1037EB
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 11:55:34 +0200 (CEST)
In-Reply-To: <1188983283.8449.1208975085@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 5 Sep 2007, Clemens Ladisch wrote:
> Eliot Blennerhassett wrote:
> > Set snd_pcm_hardware.period_bytes_min to 16 or is that 16 * samplesize?
>
> This value is measured in bytes.
>
> > snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 16);
>
> This parameter is measured in frames.

Isn't SNDRV_PCM_HW_PARAM_PERIOD_SIZE measured in frames, and
SNDRV_PCM_HW_PARAM_PERIOD_BYTES in bytes?
