From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: Device tree support for WM8994 and WM9713.
Date: Tue, 22 Nov 2011 20:09:49 +0530
Message-ID: <CAJuYYwSyTqPn3QfZrMx6_9jwtngOGW5B5pxjuTy4JtrTGgC6pw@mail.gmail.com>
References: <CAJuYYwRZcbsRz-+2Swck=PUXT+iHeRWN3fu-R8C7tBYUb1Pgqw@mail.gmail.com>
	<20111122124212.GC30048@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 81402103A80
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 15:39:50 +0100 (CET)
Received: by ywp27 with SMTP id 27so230469ywp.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 06:39:49 -0800 (PST)
In-Reply-To: <20111122124212.GC30048@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 22 November 2011 18:12, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Nov 22, 2011 at 11:28:32AM +0530, Thomas Abraham wrote:
>
>> smdkv310 board uses wm8994 and wm9713 audio codecs. I wanted to check
>> with you if there is any plan on adding device tree support for these
>> two codecs.
>
> I actually have this board. =A0What state is the -next code in with
> respect to device tree, can I usefully run the board (and if I can a
> recipie would be very helpful)? =A0Also, can you tell me where the
> bootloader is in the SD card - I've got a binary but no source so I'd
> like to start from a fresh card so Id

The DT support for Samsung is available in linux-next and includes
support for smdkv310 board. DT support for pl330 dmac is also
available. I will send the details of using the existing dt support in
a separate email.

>
> For WM9713 you shouldn't need any mention in the device tree as for the
> way your boards are structured the normal AC'97 discovery mechanisms
> should work fine. =A0However,
>
> For WM8994 if I can get the board booting with mainline we should be
> able to get device tree support for the platform data fairly easily -
> the main issue we've got with device tree at the minute is getting a
> board which can usefully use it. =A0Though for your particular board I see
> that the existing non-DT code doesn't need any platform data so I'd
> expect that you don't need a specific binding at all. =A0I'll post a patch
> that adds a stub binding today or tomorrow.
>

Though platform data of wm8994 is not required for smdkv310, there are
other boards 'goni' and 'aquila' which use the platform data. So to
start with, we can ignore the platform data of wm8994 but having full
dt support would be required for other boards.

Thanks,
Thomas.
