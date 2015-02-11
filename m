From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 1/6] ALSA: line6: Improve line6_read/write_data() interfaces
Date: Wed, 11 Feb 2015 05:58:06 -0600
Message-ID: <CAEUsAPbg+-32iidn2+44oYahqmTOnd7Lym2GygjbBDGU00sgXQ@mail.gmail.com>
References: <1423630997-25464-1-git-send-email-chris@rorvick.com>
	<1423630997-25464-2-git-send-email-chris@rorvick.com>
	<s5hbnl07pxv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hbnl07pxv.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 11, 2015 at 3:33 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 10 Feb 2015 23:03:12 -0600,
> Chris Rorvick wrote:
>>
>> Use explicit types to reflect the range of valid values.
>
> Well, this isn't necessarily to be changed at these places.  If we
> want to be safer, there should be proper range checks instead.
> Also, readers may wonder when they see the different types between
> read and write without explanations.

Thanks, I'll send a v2 shortly.
