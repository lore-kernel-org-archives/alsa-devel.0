From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH 3/3 v2] sound/soc/lapis: add platform
 driver for ML7213 IOH I2S
Date: Tue, 27 Dec 2011 10:25:25 +0900
Message-ID: <CANKRQnhJhpwhGywGz=r0tVF0k+eWb4vrGkdVD9NdzRFNo9PNtA@mail.gmail.com>
References: <1324349144-12784-1-git-send-email-tomoya.rohm@gmail.com>
	<1324349144-12784-3-git-send-email-tomoya.rohm@gmail.com>
	<20111220132314.GQ2866@opensource.wolfsonmicro.com>
	<CANKRQng8N3oS2o17HPUZeonXB3KLBK9oNQj-zd9+aUUvWcTo0A@mail.gmail.com>
	<20111222005816.GB27144@opensource.wolfsonmicro.com>
	<CANKRQnjCTAX02wJt7StjB0rXkg3Q6bPBRYCbkgq6vS5NFd97Fg@mail.gmail.com>
	<20111222103946.GA4546@opensource.wolfsonmicro.com>
	<CANKRQng+H4NxaSLpZpYOCT-CdovxbToT-waz0JNMFT2AcD_gvA@mail.gmail.com>
	<20111226121207.GF8722@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id D929024545
	for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2011 02:25:27 +0100 (CET)
Received: by dadv40 with SMTP id v40so894751dad.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 17:25:25 -0800 (PST)
In-Reply-To: <20111226121207.GF8722@opensource.wolfsonmicro.com>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

2011/12/26 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Dec 26, 2011 at 03:33:29PM +0900, Tomoya MORINAGA wrote:
>> 2011/12/22 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>
>> >> Not sorted but queuing only.
>> >> In sound/voice control system, queuing is not rare, I think.
>> >> If necessary, though this method is very common, I can send the method
>> >> of the queue.
>
>> > No, please describe the problem you're trying to fix.
>
>> When CPU is heavy load, this buffer is useful.
>> The heavy load causes delaying receiving processing.
>> If there is no buffer, stream sound/voice can be broken.
>> If there is the buffer, it can prevent the broken sound.
>
> So you're just talking about standard underflows if the application
> can't keep up?
No. not only underflow but overflow.

> There's *no* reason for your driver to do anything about
> this, it's a really basic thing that affects all audio hardware. =A0Just
> write a driver for the hardware.
In case driver layer doesn't have the function,
which part works for the under/overflow ? Application ? or nothing ?

tomoya
