From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [REANNOUNCE] Audio Mini Summit 2015, 8th October,
 Dublin
Date: Mon, 27 Jul 2015 18:26:20 -0500
Message-ID: <55B6BE1C.50202@linux.intel.com>
References: <20150714150352.GW11162@sirena.org.uk> <55A5330E.7000604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 03B932658E5
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 16:21:57 +0200 (CEST)
In-Reply-To: <55A5330E.7000604@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/14/15 11:04 AM, Alexander E. Patrakov wrote:
> 14.07.2015 20:03, Mark Brown wrote:
>> Like previous years, we're going to hold a meeting to discuss
>> lowlevel audio on Linux.  This will be held the day after ELC Europe on
>> 8th October at CCD (The Convention Centre) in Dublin.
>>
>> If you're interested please sign up in the attendee list:
>>
>> https://docs.google.com/spreadsheets/d/1bi-8GHsqlzt41FR20WiMuWILe_cZowFireVMBd-QM8Q/edit?usp=sharing
>>
>>
>> and please follow up to this mail with any topics you'd like to see
>> raised so we can start collecting them (probably another Google doc will
>> be forthcoming for them).
>
> I would like to see some direct measurements related to recent
> power-saving proposals, including the "disable rewinds" flag. Myself, I
> can redo battery-life measurements on Intel-based laptops that my
> colleagues have, and maybe compare dmix, PulseAudio and CRAS in terms of
> power consumption.
>
> Ideally, I would like to reevaluate the design decisions (namely, the
> need to keep the system responsive to new streams while keeping the
> average wakeup rate as low as possible, IMHO even to the point of
> "absurdly low") that led to the need to support rewinds (and the
> associated complexity) in the first place. Reminder: on my Sony VAIO
> VPC-Z23A4R laptop and hw:0 device, in an unrealistic test with the
> screen turned off, wi-fi turned off, and the SSDs put to sleep, going
> from 200 to 1 wakeup per second saved only 935 seconds of battery life
> out of 25742.

I had more success that you in my experiments a long time ago, but this 
really depends on what the rest of the system does.
You have a point though that we should talk about design decisions for 
userspace code. The current PulseAudio implementation lags behind the 
capabilities of newer devices with two or more outputs (low-latency, 
increased buffering and hardware/firmware mixing). This should really be 
a topic following the presentation of the HDAudio/Asoc restructuring 
that Vinod mentioned (i.e. how to change userspace code to support 
driver capabilities).
-Pierre
