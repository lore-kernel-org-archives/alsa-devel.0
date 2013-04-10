From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH v2] ALSA: hda - Apply codec delay to
	wallclock.
Date: Tue, 9 Apr 2013 22:30:31 -0700
Message-ID: <CAEUnVG4g--gJo5XjUub3do8acAjqDXeu_GSrDPY=tZ0QfwLPoA@mail.gmail.com>
References: <1365470430-22292-1-git-send-email-dgreid@chromium.org>
 <5164E2CF.2050207@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f171.google.com (mail-ea0-f171.google.com
 [209.85.215.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 21F51265EA4
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 07:30:52 +0200 (CEST)
Received: by mail-ea0-f171.google.com with SMTP id b15so33363eae.2
 for <alsa-devel@alsa-project.org>; Tue, 09 Apr 2013 22:30:51 -0700 (PDT)
In-Reply-To: <5164E2CF.2050207@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 9, 2013 at 8:55 PM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 4/8/13 6:20 PM, Dylan Reid wrote:
>>
>> For playback add the codec-side delay to the timestamp, for capture
>> subtract it.  This brings the timestamps in line with the time that
>> was recently added to the delay reporting.
>>
>> Signed-off-by: Dylan Reid <dgreid@chromium.org>
>> ---
>> Changes since v1:
>> Calculate nsec from frames, subtract delay for playback as well as
>> capture.
>
>
>> +       return (nsec > codec_nsecs) ? nsec - codec_nsecs : 0;
>
>
> Is this correct? I would think for capture you need to add the delay, and
> subtract it for playback?

Should the capture timestamp represents the wall time when the sample
is converted by the A-to-D?  If so, would be the correct time be the
codec delay nsec before what is reported here?

> -Pierre
>
