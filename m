From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: Re: [PATCH 2/5] ASoC: dwc: Don't allow negative use
	counts
Date: Thu, 04 Dec 2014 09:07:51 +0000
Message-ID: <54802467.4000702@arm.com>
References: <547F3C9F.8080102@arm.com>	<20141203172526.GC7712@sirena.org.uk>	<CAA7nrtjrQ5SpDrZRPb58zqmZrWahY3XOMWnmdH70WLr3q46_bA@mail.gmail.com>
 <CAA7nrth+h32Un2C4z106wL181eru7hwFDxMdS00X55h5Zw=-Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id F3920260549
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 10:07:51 +0100 (CET)
In-Reply-To: <CAA7nrth+h32Un2C4z106wL181eru7hwFDxMdS00X55h5Zw=-Vg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: rajeev kumar <rajeevkumar.linux@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 12/04/14 06:43, rajeev kumar wrote:
> On Thu, Dec 4, 2014 at 12:10 PM, rajeev kumar
> <rajeevkumar.linux@gmail.com> wrote:
>> On Wed, Dec 3, 2014 at 10:55 PM, Mark Brown <broonie@kernel.org> wrote:
>>> On Wed, Dec 03, 2014 at 04:38:55PM +0000, Andrew Jackson wrote:
>>>
>>>>       case SNDRV_PCM_TRIGGER_STOP:
>>>>       case SNDRV_PCM_TRIGGER_SUSPEND:
>>>>       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>>>> -             dev->active--;
>>>> +             if (dev->active > 0)
>>>> +                     dev->active--;
>>>
>>> How is this triggering - this sounds like you're papering over some
>>> other bug somewhere?
> 
> This check can be removed as it is not going to triggered.

As I said in my email to Mark, I couldn't convince myself that STOP/SUSPEND would only be called once so it seemed like a loophole which /might/ result in the device not functioning correctly.

If this can never happen, I'll drop the patch.

	Andrew

> B'rgds
> ~Rajeev
> 
