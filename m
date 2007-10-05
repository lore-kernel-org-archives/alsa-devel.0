From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ASoC v2 on PowerPC
Date: Fri, 5 Oct 2007 08:55:47 -0400
Message-ID: <9e4733910710050555u5189efdp424fded7fe5f16c0@mail.gmail.com>
References: <9e4733910710041012vb8e2a25w7a3b2cc7be80426d@mail.gmail.com>
	<1191582477.12060.243.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.237])
	by alsa0.perex.cz (Postfix) with ESMTP id 324CE2450A
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Oct 2007 14:55:49 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so409944nzf
	for <alsa-devel@alsa-project.org>; Fri, 05 Oct 2007 05:55:48 -0700 (PDT)
In-Reply-To: <1191582477.12060.243.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 10/5/07, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
> A good place to start would be looking at the other supported
> architectures and codecs and see what fits in best with your target SoC
> CPU. Fwiw, Timur Tabi has some working PPC code, although I'm not sure
> if it will work on Efika.

Efika is STAC9766, ac97 with no i2c control. I dug into the imx ac97
driver and discovered that it isn't finished.

Timur, we may need to get some Bestcomm tasks written. I haven't
explored this yet but I've been told that no one can get anything
except the general DMA task working for audio. This mean all audio
input has to be 32b. Isn't Bestcomm capable of expanding 16/24 bit
data? Our target hardware is i2s, not ac97, so I need to get i2s
running too.

> I usually start with the I2S driver and the codec in slave mode. Then
> move onto the DMA when I see the I2S bits toggling correctly. After the
> DMA is up and running I can complete the codec and I2S drivers.

Sounds like a good plan. I already have a working driver for the Efika
so this shouldn't be two bad. It just need to be rearranged.

-- 
Jon Smirl
jonsmirl@gmail.com
