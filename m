From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Fri, 8 Mar 2019 14:49:48 -0600
Message-ID: <865cd0e3-8390-024d-6c84-c416bfe3cb45@linux.intel.com>
References: <20190304165955.21696-1-TheSven73@gmail.com>
 <20190305044232.GA15636@workstation>
 <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
 <20190308041056.GA1172@workstation>
 <20190308125916.2cgiqclp6jmlfbim@shell.armlinux.org.uk>
 <20190308172235.GA31189@sirena.org.uk>
 <25dec9c5-af5c-bc54-89dd-2abdeffa9f82@perex.cz>
 <CAGngYiVaFswVrVYfUpo4YfkH+nxwaW+8q8q3C6_wfggS7YCYjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5139F8072E
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2019 21:49:52 +0100 (CET)
In-Reply-To: <CAGngYiVaFswVrVYfUpo4YfkH+nxwaW+8q8q3C6_wfggS7YCYjw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sven Van Asbroeck <thesven73@gmail.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org


>> I agree. We just need a library which will:
>>
>> 1) gather the information from hardware drivers
>>    - a simple description of the bclk constrains
>> 2) create right constraints (hw_params rules) for the ALSA PCM API
>> 3) return the selected bclk when hw_params are installed
>>
> Yes, that's what the RFC patch I posted attempts to do.
> But it extends hw_params, which is clearly wrong.
>
>> The library should not extend hw_params (new interval), but it should
>> work as a separate layer - use new structures / functions etc.
>>
> This, I could not work out how to approach :)

I am not sure I fully understand the ask but wanted to point out that 
for ASoC topology-based solutions the bclk rate is typically passed as a 
parameter from userspace (w/ a request_firmware and topology parsing) 
and might be forwarded over IPC to a DSP. On some Intel platforms which 
can't support 32x fs that is typically how we represent a bclk ratio 
multiple of 25. the kernel has no idea of the relationship between the 
representation of the stream in memory and the final bit clock, only the 
DSP which programs the hardware registers knows about the latter.

It's really quite typical that the DAI is programmed for a fixed 
configuration and the DSP takes care of the conversions. The kernel only 
deals with stream triggers and power management without know all the 
internal details of the audio graph.
