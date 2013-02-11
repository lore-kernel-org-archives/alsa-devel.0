From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH TINYCOMPRESS 1/14] compress: Add function
 to get timestamp in samples
Date: Mon, 11 Feb 2013 08:11:04 -0600
Message-ID: <5118FBF8.9060804@linux.intel.com>
References: <20130210000227.GA31139@opensource.wolfsonmicro.com>
 <20130211063448.GA3789@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DEDAD2602AD
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 15:11:06 +0100 (CET)
In-Reply-To: <20130211063448.GA3789@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


>> The compress_get_hpointer() converts the timestamp into actual
>> time. But Android needs it in samples. To avoid the inefficiency
>> of using compress_get_hpointer() and converting into time and then
>> back into samples, this change adds compress_get_tstamp() which
>> returns the raw struct snd_compr_tstamp.
> I am fine with adding new API for returning the samples, but then why return the
> raw struct. Would make sense to just get samples if that is only thing desired.

Loss of efficiency? It's not that bad really and the conversion could be 
handled in tinycompress (user-space) rather than adding a new kernel 
ioctl that everyone will need to implement. The htimestamp could give 
you better precision than samples if a wall clock is available in the 
hardware.
-Pierre
