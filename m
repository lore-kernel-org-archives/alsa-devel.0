From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: WM9712 - Big and little endian format conversion.
Date: Wed, 13 May 2009 14:14:05 -0400
Message-ID: <9e4733910905131114m6a083085ge8c6dc02bddf2d5@mail.gmail.com>
References: <9e4733910905131055v4eb487dhf5d410ae5d6b1a52@mail.gmail.com>
	<20090513175959.GB27909@sirena.org.uk>
	<9e4733910905131108n4e109dc5xd4c11056b95b33a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id A30771038BD
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 20:14:06 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1448541qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 11:14:06 -0700 (PDT)
In-Reply-To: <9e4733910905131108n4e109dc5xd4c11056b95b33a4@mail.gmail.com>
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

On Wed, May 13, 2009 at 2:08 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Wed, May 13, 2009 at 1:59 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Wed, May 13, 2009 at 01:55:43PM -0400, Jon Smirl wrote:
>>> I have three areas specifying audio formats. The WM9712 AC97 codec is
>>> S16_LE. My DMA hardware is S32_BE. All samples need to be in 32b words
>>> even if they are 8,16,24b. =A0The cpu's AC97 system sends the first 20
>>> big endian bits down the AC97 link in the proper order.
>>
>>> How can I force the DMA engine setting to override what the codec is
>>> saying? Or should the codec be changed to specify all bit lengths and
>>> both endians?
>>
>> In this specific case there's now a standard define for the AC97 codecs
>> to use for the formats in current ASoC, add all the formats supported by
>> your CPU to that and all the AC97 codecs will pick it up automatically.
>> It's called SND_SOC_STD_AC97_FMTS, defined in the DAI header file.
>
> Which tree is this in?

I found it in broonie/for-2.6.31
I rebased my series on to that branch

>
> --
> Jon Smirl
> jonsmirl@gmail.com
>



-- =

Jon Smirl
jonsmirl@gmail.com
