From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH v2] ASoC: rt5677: make volume TLV closer to
	reality
Date: Thu, 9 Oct 2014 19:27:40 -0700
Message-ID: <CAEUnVG72KL7iYGVgg8UMM6NyeSEe8vFADjFKzE4cLUUYwqTq5w@mail.gmail.com>
References: <1412892687-1264-1-git-send-email-dgreid@chromium.org>
 <20141009231042.GC18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 by alsa0.perex.cz (Postfix) with ESMTP id B7212260479
 for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2014 04:28:03 +0200 (CEST)
Received: by mail-oi0-f44.google.com with SMTP id x69so5147345oia.31
 for <alsa-devel@alsa-project.org>; Thu, 09 Oct 2014 19:28:02 -0700 (PDT)
In-Reply-To: <20141009231042.GC18557@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Anatol Pomozov <anatol.pomozov@gmail.com>, benzh@chromium.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 9, 2014 at 4:10 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Oct 09, 2014 at 03:11:27PM -0700, Dylan Reid wrote:
>> The volume blocks have an step of 0.375dB, but TLV uses 0.01dB for
>> units.  Switch to use TLV_DB_MINMAX as this allows the minimum to be
>> off by only 0.005dB.  This is an improvement from the ~500dB is was
>> misreported by before.
>
> The usual thing to do with these is just to halve the resolution of the
> control by ignoring the low bit so that you get exact values, though for
> this device that does result in a relatively large step (step sizes like
> 0.125dB are more common).  I dunno, doesn't make much difference either
> way from my point of view.

I can easily add a flag to the UCM config to hint userspace to divide by 10, so
I'm not strongly tied to making this change if it isn't bothering anyone else.
