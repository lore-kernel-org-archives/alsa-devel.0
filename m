From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/2] alsa-lib: bring pcm.h and pcm.c in
 sync with the kernel list
Date: Thu, 28 Mar 2013 10:52:08 +0100
Message-ID: <515412C8.4020007@gmail.com>
References: <1364427144-30036-1-git-send-email-zonque@gmail.com>
 <1364427144-30036-2-git-send-email-zonque@gmail.com>
 <51538493.40309@sonarnerd.net>
 <7.0.0.16.2.20130327213632.13b07718@akdesigninc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 10E5F265241
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 10:52:03 +0100 (CET)
Received: by mail-bk0-f42.google.com with SMTP id jc3so1688974bkc.1
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 02:52:02 -0700 (PDT)
In-Reply-To: <7.0.0.16.2.20130327213632.13b07718@akdesigninc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Koch <andreas@akdesigninc.com>
Cc: Jussi Laako <jussi@sonarnerd.net>, tiwai@suse.de, clemens@ladisch.de, alsa-devel@alsa-project.org, demian@auraliti.com, ray@auraliti.com
List-Id: alsa-devel@alsa-project.org

On 28.03.2013 05:58, Andreas Koch wrote:
> 
>>
>> Andreas,
>>
>> Am I right to assume that in your case it's the same as for DoP, 
>> IOW, oldest in MSB?
> 
> Good point - thanks for bringing it up - another can of worms.
> With Windows having a little endian philosophy we started early on 
> with the first DSD workstation by putting the oldest sample in the 
> LSB position. ASIO came along and adopted the same thing, but then 
> extended support for the opposite as well. Rigisystems (offering OEM 
> modules for USB audio) came along about a year ago and insisted that 
> there is only their way, i.e. putting the oldest bit in the MSB 
> position. I tried to explain to them that there are already hundreds 
> of products out in the market that do it differently, but that didn't 
> matter to them. The result is that now we have implementations with 
> both. Up until now that was not a huge issue, because there is no 
> generic Windows driver and every hardware manufacturer had to have a 
> custom driver.
> Now of course, with your heroic effort in creating a generic driver 
> that would help everyone, we have a mess. Some DACs expect little 
> endian (mine and others as well) and others (all that are based on 
> Rigisystems modules) big endian positions.
> 
> Since the time I had the discussions with Rigisystems I didn't have 
> any further communication with them. Maybe it is a good idea to touch 
> base with them again and find out what the latest is. I will try my 
> contact there and let you know.

Eek, what an utter mess. Just let me know what you find out. We then
need to augment the number of DSD formats, but then again, we can also
move the sample rate calculation table inside the ALSA kernel core instead.

Takashi et al - please don't apply any of these patches yet (expecpt for
the the indentation fixup) :) I guess we need some more spins on this.

Thanks,
Daniel
