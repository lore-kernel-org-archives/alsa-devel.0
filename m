From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: ASoC: PCM formats for AC97
Date: Sun, 9 Aug 2009 09:32:22 -0400
Message-ID: <9e4733910908090632m1178daceya0269966fde54529@mail.gmail.com>
References: <9e4733910908081144s27f4b7fes1e22f838a203c3cf@mail.gmail.com>
	<20090809104830.GC4773@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f203.google.com (mail-yw0-f203.google.com
	[209.85.211.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 90D7C24342
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Aug 2009 15:32:23 +0200 (CEST)
Received: by ywh41 with SMTP id 41so3700020ywh.23
	for <alsa-devel@alsa-project.org>; Sun, 09 Aug 2009 06:32:22 -0700 (PDT)
In-Reply-To: <20090809104830.GC4773@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 9, 2009 at 6:48 AM, Mark Brown<broonie@sirena.org.uk> wrote:
> On Sat, Aug 08, 2009 at 02:44:48PM -0400, Jon Smirl wrote:
>
>> I think I have this backwards, the ac97 driver can take 8/16/24/32
>> it's the Bestcomm program that doesn't know about anything except 32b.
>
> Remember, you need to consider the I2S driver as well.
>
>> #define SND_SOC_STD_AC97_FMTS (SNDRV_PCM_FMTBIT_S16_LE |\
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV_PCM=
_FMTBIT_S32_LE |\
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV_PCM=
_FMTBIT_S32_BE)
>> shouldn't this be
>
>> #define SND_SOC_STD_AC97_FMTS (SNDRV_PCM_FMTBIT_S16 |\
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV_PCM=
_FMTBIT_S32)
>
>> The first form says the AC97 hardware can take both endians, but it
>> doesn't take both endians it takes the endian matching the machine it
>> is attached to.
>
> No, it can take any endianess - the wire format is fixed. =A0The layout of
> the data in memory is of little interest to the CODEC. =A0The formats used
> will be restricted by the CPU driver, the values there are essentially
> functioning as a wildcard match.

I agree with you, but I think the second form better indicates the
wildcard than the first form. It makes it look like endianess is not a
factor.

If you had used the second form I wouldn't have had a problem bringing
up a powerpc driver.

>> Don't the standard AC97 formats also include 8 and 24b?
>
> They'll include whatever the controller is happy to render down onto the
> bus. =A0That's just the ones that people have needed so far.

We could add 8/24b now so to make thing easier on the next driver developer.


>



-- =

Jon Smirl
jonsmirl@gmail.com
