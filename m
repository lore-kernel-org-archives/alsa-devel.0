From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/5] ALSA: snd-usb: implement new endpoint
 streaming model
Date: Tue, 20 Dec 2011 21:16:56 +0100
Message-ID: <4EF0ED38.5010306@gmail.com>
References: <1324374520-32332-1-git-send-email-zonque@gmail.com>	<1324374520-32332-3-git-send-email-zonque@gmail.com>
	<s5hmxangu0r.wl%tiwai@suse.de> <4EF0AA75.10404@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2651B10384A
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 21:17:06 +0100 (CET)
Received: by eekb57 with SMTP id b57so6538135eek.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 12:17:04 -0800 (PST)
In-Reply-To: <4EF0AA75.10404@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, blablack@gmail.com, alsa-devel@alsa-project.org, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

On 12/20/2011 04:32 PM, Clemens Ladisch wrote:
> Takashi Iwai wrote:
>> One point I'm not sure about this implementation is the use of
>> tasklet.  The tasklet itself runs again in ep->lock, what's the
>> rationale for it?  In other words, can't it be a straight function
>> call?
> 
> This architecture was copied from ua101.c.

Yes.

> If I remember correctly,
> the original reason for the tasklet was to avoid calling
> snd_pcm_period_elapsed() from inside the lock.  This would not be
> necessary in endpoint.c.

Hmm. It was actually you who told me to use a tasklet and not to submit
urbs from the input urb completion callbacks, as we can run out of
queuable playback buffers otherwise. Now that I think about it again, I
agree that it could be done without a tasklet as well by just keeping
the returned ones in a list and handle them in one go whenever possible.

I'll try this when I spin the next version.


Thanks,
Daniel
