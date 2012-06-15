From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/2] ALSA: hda: support for wallclock
	timestamps
Date: Fri, 15 Jun 2012 05:02:38 -0500
Message-ID: <4FDB083E.9060903@linux.intel.com>
References: <1339619192-2733-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	<1339619192-2733-3-git-send-email-pierre-louis.bossart@linux.intel.com>
	<s5hfw9yqr6e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id BEBFA2469C
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2012 12:02:41 +0200 (CEST)
In-Reply-To: <s5hfw9yqr6e.wl%tiwai@suse.de>
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


>> +struct azx_timecounter {
>> +	cycle_t cycle_last;
>> +	cycle_t mask;
>> +	cycle_t elapsed_cycles;
>> +	u64     initial_time_nsec;
>> +	u32     mult;
>> +	u32     shift;
>> +};
>
> Any reason not using the normal struct timecounter stuff?
> Most of the open codes can be replaced gracefully with functions /
> macros there, I guess.

Yes there is a reason. The conversion from wall clock cycles to ns is a 
fractional operation (125/3 ratio from 24 MHz to 1 GHz). If you do this 
conversion to ns every time, you will accumulate rounding errors. That 
doesn't seem like a very good design if the precision depends on the 
duration of the track...
On top of this, I couldn't find a way to pass the 'chip' argument in the 
cyclecounter .read() operation to map it to azx_read.
Makes sense?
-Pierre
