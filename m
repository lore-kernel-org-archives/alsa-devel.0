From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v2 01/13] conf/ucm: bytcr-rt5645: Use the
 generic bytcr/PlatformEnableSeq.conf
Date: Mon, 26 Nov 2018 16:28:01 +0100
Message-ID: <2dcbb4a3-d822-d63a-d393-172edbbbc299@perex.cz>
References: <20180808090543.15181-1-hdegoede@redhat.com>
 <20181126094911.27716-1-youling257@gmail.com> <s5hlg5g17a4.wl-tiwai@suse.de>
 <11fd58d6-4008-3ba1-be85-b648b849379a@redhat.com>
 <s5ho9abzzub.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id D81F026751A
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 16:28:12 +0100 (CET)
In-Reply-To: <s5ho9abzzub.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>
Cc: youling257 <youling257@gmail.com>, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Dne 26.11.2018 v 15:18 Takashi Iwai napsal(a):
> On Mon, 26 Nov 2018 14:40:48 +0100,
> Hans de Goede wrote:
>>
>>> some of the recently added UCM profiles are the files to be included
>>> by others, and they are not card targets.  Unfortunately alsaucm
>>> doesn't know about it, and it aborts with error, e.g.
>>>
>>> ====
>>> % alsaucm
>>> ALSA lib utils.c:67:(uc_mgr_config_load) could not open configuration file /usr/share/alsa/ucm/bytcr/bytcr.conf
>>> ALSA lib parser.c:1427:(load_master_config) error: could not parse configuration for card bytcr
>>> alsaucm: unable to obtain card list: No such file or directory
>>> ====
>>>
>>> The similar error is found in nau8824, rt5640 and rt5651.  After
>>> putting a placeholder card config file (e.g. bytcr.conf), the error is
>>> gone.  But certainly we don't want to allow user to choose this as the
>>> proper card.
>>>
>>> So, I guess we need to put some flag to each such directory indicating
>>> that it's no card config.  For example, putting
>>> /usr/share/alsa/ucm/bytcr/.nocard file or such...
>>>
>>> Not sure whether it's wise to have a file starting with dot, though.
>>> Maybe clearer to be "nocard" or any other visible one?
>>
>> All the HiFi.conf files using the "include" snippets I added to avoid
>> copy and pasting a lot, already need to have this at the top for
>> this to work:
>>
>> <searchdir:ucm>
>>
>> So it might be best to move all the dirs holding include files rather
>> then proper card configs from /usr/share/alsa/ucm to
>> /usr/share/alsa/ucm-includes and then change the searchdir part of
>> the configs using these to:
>>
>> <searchdir:ucm-includes>
> 
> This sounds like a good solution, indeed.
> Care to submit a fix patch?  I'll apply it unless anyone objects.

Yep, it looks like a good idea.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
