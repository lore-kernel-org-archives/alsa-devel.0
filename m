From: Tim Sheridan <Tim.Sheridan@imgtec.com>
Subject: Re: [PATCH] ALSA: compress: Add DSP private metadata
 interface
Date: Tue, 23 Feb 2016 12:47:26 +0000
Message-ID: <98E3058E5505294895CA69F176CAD6626A6D8BE1@LEMAIL01.le.imgtec.org>
References: <1456163671-40987-1-git-send-email-tim.sheridan@imgtec.com>
 <s5h8u2b22op.wl-tiwai@suse.de> <20160223094223.GK17690@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B6D8260535
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 13:47:29 +0100 (CET)
In-Reply-To: <20160223094223.GK17690@localhost>
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
To: 'Vinod Koul' <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: Neil Jones <neil.jones@imgtec.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi/Vinod,

> > Don't you have the code actually implement this ioctl?
> > Or, is there anything I miss?

Yup, not implementing it anywhere in the kernel tree. Just submitting the patch for the API to support implementing it in the out-of-tree IMG AXD driver. Apologies if I'm breaking some kind of rule here requiring an in-tree usage of a new API feature -- it might be better to submit this as part of a revised AXD patch series which implements this ioctl.

> And compress API was never intended for that :)
> 
> Can you tell me the awesome features you would like to support using this
> API and I would try to provide you a standard alsa way to do that...
> 
> The intention of compress API is to provide a streaming interface for data
> transfer and nothing more. To implement DSP features and control them,
> you need to look at alsa control interface

AXD's got various features which require mode setting (e.g. for selecting between multi-device synchronization mechanisms that it supports). This would need an enum control, but I guess that this could be fudged with mutually exclusive switch controls for each of the enum values. AXD's also got numeric configuration parameters which it needs to be able to receive (e.g. parameters for stream synchronization heuristics, audio filter coefficients, etc.). Maybe a volume control with a domain wide enough could be used for this kind of configuration parameter. It's rather horrible, but might be fine for while the AXD driver is out of tree and there aren't more appropriate ALSA control types (e.g. enum and non-volume integer). :-/

> Btw there was another person from imgtec who had similar request last year,
> never heard back from him after he was supposed to fix stuff in his driver
> and come back

Yeah, Qais left IMG before being able to finish up his fixes for the AXD driver (I think the last patch series was sent in August 2015). I've only got a limited amount of time for working on AXD, but if I get the time/orders from above me in IMG, a revised patch series could appear again. :-)

Many thanks,
Tim
