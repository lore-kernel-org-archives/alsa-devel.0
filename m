From: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Subject: Re: [PATCH 15/27] ALSA: hda - Use
 timecounter_initialize interface
Date: Tue, 26 Dec 2017 13:07:35 +0530
Message-ID: <b0d5ff40-fbfe-e5b3-2844-7d930484e87f@intel.com>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
 <1513323522-15021-16-git-send-email-sagar.a.kamble@intel.com>
 <s5hh8ssgsaw.wl-tiwai@suse.de> <20171215165125.avkz25eek56i5md4@localhost>
 <s5h4lorx6ha.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E176C266DD5
 for <alsa-devel@alsa-project.org>; Tue, 26 Dec 2017 08:37:40 +0100 (CET)
In-Reply-To: <s5h4lorx6ha.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Richard Cochran <richardcochran@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 12/15/2017 10:40 PM, Takashi Iwai wrote:
> On Fri, 15 Dec 2017 17:51:25 +0100,
> Richard Cochran wrote:
>> On Fri, Dec 15, 2017 at 12:10:47PM +0100, Takashi Iwai wrote:
>>
>>>> -	struct cyclecounter *cc = &azx_dev->tc.cc;
>>>> -	cc->read = azx_cc_read;
>>>> -	cc->mask = CLOCKSOURCE_MASK(32);
>>>> -	cc->mult = 125; /* saturation after 195 years */
>>>> -	cc->shift = 0;
>> I want to get away from this mess of open coded structure
>> initialization and use a proper functional interface instead.
> I agree that a proper functional interface would be better, too.
> But not a form like foo(501, 21, 10, 499, 5678).
> In C syntax, you may more easily pass a wrong value than open codes.
>
>>>>   	nsec = 0; /* audio time is elapsed time since trigger */
>>>> -	timecounter_init(tc, nsec);
>>>> +	timecounter_initialize(tc,
>>>> +			       azx_cc_read,
>>>> +			       CLOCKSOURCE_MASK(32),
>>>> +			       125, /* saturation after 195 years */
>>>> +			       0,
>>>> +			       nsec);
>>> Hmm, a function with so many arguments is difficult to remember and is
>>> often error-prone.  By this transition, it becomes harder to read
>>> through.
>> Please suggest a better way.
> I have no good idea ATM, sorry.
>
> Or can we provide simpler versions for covering some defaults?  At
> least reducing the number of arguments would make things easier.
Thought about specifying 1. cyclecounter read func 2. frequency 3. width 
of counter as parameters here
which can get rid of mult, shift params. But this is not easy as most of 
the drivers do not specify
cyclecounter frequency and instead hard-code the mult/shift factors.
How about passing initialized cyclecounter struct?
>
> Takashi
