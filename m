From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: WM9712 - Big and little endian format conversion.
Date: Wed, 13 May 2009 14:08:19 -0400
Message-ID: <9e4733910905131108n4e109dc5xd4c11056b95b33a4@mail.gmail.com>
References: <9e4733910905131055v4eb487dhf5d410ae5d6b1a52@mail.gmail.com>
	<20090513175959.GB27909@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 90F7C1038C6
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 20:08:21 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so560098qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 11:08:20 -0700 (PDT)
In-Reply-To: <20090513175959.GB27909@sirena.org.uk>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 1:59 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 13, 2009 at 01:55:43PM -0400, Jon Smirl wrote:
>> I have three areas specifying audio formats. The WM9712 AC97 codec is
>> S16_LE. My DMA hardware is S32_BE. All samples need to be in 32b words
>> even if they are 8,16,24b. =A0The cpu's AC97 system sends the first 20
>> big endian bits down the AC97 link in the proper order.
>
>> How can I force the DMA engine setting to override what the codec is
>> saying? Or should the codec be changed to specify all bit lengths and
>> both endians?
>
> In this specific case there's now a standard define for the AC97 codecs
> to use for the formats in current ASoC, add all the formats supported by
> your CPU to that and all the AC97 codecs will pick it up automatically.
> It's called SND_SOC_STD_AC97_FMTS, defined in the DAI header file.

Which tree is this in?

-- =

Jon Smirl
jonsmirl@gmail.com
