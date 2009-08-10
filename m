From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Implementing sync start
Date: Mon, 10 Aug 2009 08:24:18 -0400
Message-ID: <9e4733910908100524w510ba17ep2d6482cdfad57597@mail.gmail.com>
References: <9e4733910908081116p221e606cma31a95b06d9b5be6@mail.gmail.com>
	<9e4733910908082007n5d2e7f48g453b1f2e3c6eb23e@mail.gmail.com>
	<9e4733910908091913j63debfefja44e8e04e278e087@mail.gmail.com>
	<9e4733910908091919o617eb1b8r44436cd87a6873ff@mail.gmail.com>
	<4A7FCF0A.1000806@ladisch.de>
	<9e4733910908100445u3ea02395y9dc39b73ad41cb6b@mail.gmail.com>
	<4A800B47.6020201@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f176.google.com (mail-yx0-f176.google.com
	[209.85.210.176])
	by alsa0.perex.cz (Postfix) with ESMTP id F325610387F
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 14:24:19 +0200 (CEST)
Received: by yxe6 with SMTP id 6so3654256yxe.16
	for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2009 05:24:18 -0700 (PDT)
In-Reply-To: <4A800B47.6020201@ladisch.de>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 10, 2009 at 7:57 AM, Clemens Ladisch<clemens@ladisch.de> wrote:
> Jon Smirl wrote:
>> On Mon, Aug 10, 2009 at 3:40 AM, Clemens Ladisch<clemens@ladisch.de> wro=
te:
>>> There is no common code for the two substreams.
>>> Is your hardware actually capable of starting them at exactly the same
>>> time?
>>
>> Sync start is working. This is in the loop and starts the streams:
>> =A0 =A0bcom_enable(s->bcom_task);
>> s is set to two different values in the loop.
>
> But you are calling bcom_enable() twice, once for each stream. =A0The same
> would happen if you didn't implement sync start and let ALSA handle the
> linked streams.
>
> Sync start/stop is intended for hardware that can actually start two
> streams at _exactly_ the same time, by, e.g., writing a value with two
> bits set to a register.

The streams are on the same MCLK. I just need to make sure they get
enabled in the same clock cycle. To ensure this I need to add some
more code to look for a clock edge before enabling them.

If I didn't use sync start wouldn't I be vulnerable to user space
getting delayed between the start calls? If I'm unlucky the second
start could come in milliseconds after the first one.


>
>> I'm having problems with the drain error on stop.
>> ALSA sound/core/pcm_native.c:1499: playback drain error (DMA or IRQ trou=
ble?)
>
> ALSA did not get the snd_pcm_period_elapsed() call (or the correct
> pointer value) for the last samples.
>
>
> HTH
> Clemens
>



-- =

Jon Smirl
jonsmirl@gmail.com
