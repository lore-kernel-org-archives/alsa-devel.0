From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 08/16] ALSA: line6: Drop superfluous
	spinlock for trigger
Date: Wed, 28 Jan 2015 08:02:59 -0600
Message-ID: <CAEUsAPY33h99aRqs0gQZYSfk1kX0W+C4YoyCbAbRyEMq+d0eog@mail.gmail.com>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
 <1422033203-23254-9-git-send-email-tiwai@suse.de>
 <CAEUsAPYJcxq5eGhpZiy58USGwwxaohwjF+j0B0Qi=WRoectJeA@mail.gmail.com>
 <s5hh9vcikmi.wl-tiwai@suse.de>
 <CAEUsAPaN+127mvZvYiFcKcVLSVoLaPWO_tCVDUX_7-ce7YadXw@mail.gmail.com>
 <s5hiofsyzko.wl-tiwai@suse.de>
 <CAEUsAPYpmkoF3YtqJGcp7gQ3HnBRQ8tKPzFuLSHEYiy=PJjLEw@mail.gmail.com>
 <s5hfvavh13l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com
 [209.85.192.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B1F9261A32
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 15:03:00 +0100 (CET)
Received: by mail-qg0-f44.google.com with SMTP id l89so16734831qgf.3
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 06:02:59 -0800 (PST)
In-Reply-To: <s5hfvavh13l.wl-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 28, 2015 at 12:26 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 28 Jan 2015 00:03:17 -0600,
> Chris Rorvick wrote:
>>
>> On Tue, Jan 27, 2015 at 10:10 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > Could you give tested-by tag if the latest test/line6 branch works --
>> > at least, no serious regression is seen?
>>
>> The "Fix racy loopback handling" is broken due to the typo, but that
>> drops out later and does not affect the final tree.  So, very briefly
>> ...
>>
>> Tested-by: Chris Rorvick <chris@rorvick.com>
>
> Thanks!  I updated the branch and now merged to for-next.

You're welcome, looks good!  Nice to see the playback/capture
buffer/stream flags stuff cleaned up.

Chris
