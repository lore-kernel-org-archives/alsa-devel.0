From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Proposal for more reliable audio DMA.
Date: Wed, 24 Jun 2009 15:07:17 -0400
Message-ID: <9e4733910906241207m50340ef5gd63fc4527e50b861@mail.gmail.com>
References: <378E7985-7CD3-4009-AA14-127391A819F2@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 0786A24859
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 21:07:17 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1266117qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2009 12:07:17 -0700 (PDT)
In-Reply-To: <378E7985-7CD3-4009-AA14-127391A819F2@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>, James Courtier-Dutton <james.dutton@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 24, 2009 at 12:28 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On 24 Jun 2009, at 17:07, Jon Smirl <jonsmirl@gmail.com> wrote:
>
>> Trying to directly expose the ring buffer to the app seems like a good
>>
>> way to avoid a copy, but it isn't achieving that. pulse is not
>> decoding audio straight into the ring buffer, it decodes first and
>> then copies into the buffer. Pulse is using the timers to estimate the
>> destination for the copy. =A0Move this copy down into the drivers, the
>> drivers know the correct destination for the copy.
>
> Pulse isn't just doing straight playback, a large part of what it's there
> for is to do software mixing. When you have multiple sources active pulse=
 is
> going to be forced to do the copy as part of the mixing process so putting
> that bit of the buffer management in kernel won't help in the way you thi=
nk
> it does. Part of what's going on here is that the kernel code is trying to
> give userspace access to the data for as long as possible.
>

Does this work as a use case?

Pulse is playing music in the background.  A game want to do a laser blast.

Pulse has already sent a buffer into kernel for the background music.
Pulse makes a new buffer that contains the background mixed with the laser.
It sends this new buffer into the kernel and says play with minimum latency.

The problem is knowing which sample in the background music to start
mixing the low latency laser blast into. ALSA will need to know this
index to figure out where to switch onto the replacement buffer. This
offset is dynamic and it depends on how much work pulse is doing.

So you need two things. An estimate of the current playing sample and
an estimate of the system latency to know where to start mixing.

Estimating the current sample can be done accurately by using a high
frequency, free running counter. Drift can be compensated for by
recording the count when the hardware accurately knows what sample it
is on. Knowing how many samples to delay before mixing is a function
of app latency and it needs to be measured in a feedback loop.

I'm starting to think the OSS model is right and mixing belongs in the kern=
el

-- =

Jon Smirl
jonsmirl@gmail.com
