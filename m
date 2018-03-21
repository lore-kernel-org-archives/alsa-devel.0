From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [PATCH] ALSA: hda - Force polling mode on CFL
	for	fixing codec communication
Date: Wed, 21 Mar 2018 09:39:35 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579B46264@BGSMSX101.gar.corp.intel.com>
References: <20180321091525.1366-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 290D72671F9
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 10:39:42 +0100 (CET)
In-Reply-To: <20180321091525.1366-1-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Hui Wang <hui.wang@canonical.com>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-
>project.org] On Behalf Of Takashi Iwai
>Sent: Wednesday, March 21, 2018 2:45 PM
>To: alsa-devel@alsa-project.org
>Cc: Hui Wang <hui.wang@canonical.com>
>Subject: [alsa-devel] [PATCH] ALSA: hda - Force polling mode on CFL for fixing
>codec communication
>
>We've observed too long probe time with Coffee Lake machines, and the
>likely cause is some communication problem between the HD-audio
>controller and the codec chips.  While the controller expects an IRQ
>wakeup for each codec response, it seems sometimes missing, and it
>takes one second for the controller driver to time out and read the
>response in the polling mode.
>

I think I faced similar problem while doing the HDA ASoC work.

I don't have any way to reproduce and test this. Can we increase
the delay after the link is powered ON. The present delay is 100usec,
can we make it 521 uSec ? Possibly the codec is not ready after
the link is powered on and so it's not responding.

File: hda_intel.c

	/* 4. turn link up: set SPA to 1 and wait CPA to 1 */
	intel_ml_lctl_set_power(chip, 1);
	udelay(100); --> change this to 521.

Regards,
Rakesh
