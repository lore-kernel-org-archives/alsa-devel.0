From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 4/13] Intel SST driver common
	private	headers
Date: Tue, 7 Jul 2009 11:37:35 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BBC222C@bgsmsx501.gar.corp.intel.com>
References: <1246604612-12875-1-git-send-email-vinod.koul@intel.com>
	<s5hhbxu2fk4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D5372469E
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 08:08:11 +0200 (CEST)
In-Reply-To: <s5hhbxu2fk4.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> +/*
>> +SST shim registers to structure mapping
>> +*/
>> +union config_status_reg {
>> +	struct {
>> +		u32 rsvd0:1;
>> +		u32 sst_reset:1;
>> +		u32 hw_rsvd:3;
>> +		u32 sst_clk:2;
>> +		u32 bypass:3;
>> +		u32 run_stall:1;
>> +		u32 rsvd:21;
>> +	} part;
>> +	u32 full;
>
>A union with bit fields is very bad for portability.
>If it's used as a communication parameter, don't use it.
>Just pass u32 and get/set via normal bit and/or operations.

We communicate with firmare using a 32 bit register only. The bits of 32 bit register mean different things. So this structure is just a way for use to read/write it using .full and manuplate using .part.field. 
I am not sure I understand where it fails in portability. Can you please help elaborate a little here?


>> +struct snd_sst_user_cap_list {
>> +	unsigned int iov_index; /*index of iov*/
>> +	unsigned long iov_offset; /*offset in iov*/
>> +	unsigned long offset; /*offset in kmem*/
>> +	unsigned long size; /*size copied*/
>
>Sure to use long here?
No. we will correct it to use u64


>
>Well, all these shouldn't be inline if you have no concrete reason
>to inline them.  It's no C++ template.  Better to put as normal functions.
Sure. Will change them accordingly.

Thanks,
Harsha
