From: rajeev kumar <rajeevkumar.linux@gmail.com>
Subject: Re: [PATCH 2/5] ASoC: dwc: Don't allow negative use
	counts
Date: Thu, 4 Dec 2014 12:10:17 +0530
Message-ID: <CAA7nrtjrQ5SpDrZRPb58zqmZrWahY3XOMWnmdH70WLr3q46_bA@mail.gmail.com>
References: <547F3C9F.8080102@arm.com>
	<20141203172526.GC7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f178.google.com (mail-ig0-f178.google.com
 [209.85.213.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 168FD2604BC
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 07:40:19 +0100 (CET)
Received: by mail-ig0-f178.google.com with SMTP id hl2so14136183igb.17
 for <alsa-devel@alsa-project.org>; Wed, 03 Dec 2014 22:40:18 -0800 (PST)
In-Reply-To: <20141203172526.GC7712@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 3, 2014 at 10:55 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Dec 03, 2014 at 04:38:55PM +0000, Andrew Jackson wrote:
>
>>       case SNDRV_PCM_TRIGGER_STOP:
>>       case SNDRV_PCM_TRIGGER_SUSPEND:
>>       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> -             dev->active--;
>> +             if (dev->active > 0)
>> +                     dev->active--;
>
> How is this triggering - this sounds like you're papering over some
> other bug somewhere?
