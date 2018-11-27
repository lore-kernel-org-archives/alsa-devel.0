From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 01/13] conf/ucm: bytcr-rt5645: Use the
 generic bytcr/PlatformEnableSeq.conf
Date: Tue, 27 Nov 2018 11:08:30 -0600
Message-ID: <ff2c2705-ac0a-8c03-4484-c22feae4b244@linux.intel.com>
References: <20180808090543.15181-1-hdegoede@redhat.com>
 <20181126094911.27716-1-youling257@gmail.com> <s5hlg5g17a4.wl-tiwai@suse.de>
 <11fd58d6-4008-3ba1-be85-b648b849379a@redhat.com>
 <s5ho9abzzub.wl-tiwai@suse.de>
 <2dcbb4a3-d822-d63a-d393-172edbbbc299@perex.cz>
 <2658f3ea-c442-96b6-31f7-64ee08971d0b@linux.intel.com>
 <s5hbm6ay8g1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id DF5F926770D
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2018 18:08:33 +0100 (CET)
In-Reply-To: <s5hbm6ay8g1.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Hans de Goede <hdegoede@redhat.com>, youling257 <youling257@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>> - what is the license for those UCM files? I keep getting questions
>> and I don't have the answer. It'd be odd to have then inherit the LGPL
>> license from alsa-lib, it's expected that people will have to do minor
>> modifications left and right and handle a number of derivatives,
>> e.g. because the perceived volume is too low due to some
>> mechanics/acoustics issue and requiring them to share is a bit
>> cumbersome.
> Unless explicitly specified, it should inherit from the whole alsa-lib
> license, i.e. LGPL.  But I guess we have no problem for re-licensing
> (or dual-license) with a more relaxed one for UCM profiles, once when
> they are split to an individual repo.
>
> Since the whole projects were moved to github, we can do it easily, I
> suppose.

I think we should have UCM and topology files in the same repo since 
they are related (control names, etc).

BTW that's also one improvement that I forgot about. alsa-lib currently 
bails when it cannot find a control in an UCM file, and that's painful 
when control names change over time. I have e.g. older UCM profiles for 
Chromebooks that aren't compatible any longer with the upstream kernel 
for HDMI paths, but work fine with analog paths. It'd be really nice to 
downgrade the error to a warning.

>
>> - how are we going to handle the changes for SOF, we added an "sof-"
>> prefix to make it explicit that the platform/DSP driver side is
>> different, but having a different board name will interfere with
>> search and includes.
> Sorry, it's not clear about the question.  You need to use a different
> UCM profile when the device is bound with SOF, right?

It's only different for the DSP parts, the codec settings are completely 
identical so I was hoping to avoid duplication of all the profiles and 
use some sort of run-time rule to only include the changed DSP settings. 
I don't have a turn-key solution to suggest, just a desire to avoid more 
maintenance work just because of a prefix added.
