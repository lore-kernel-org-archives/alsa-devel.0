From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1 - try2] ASoC: add support for multiple
	cards/codecs in debugfs
Date: Thu, 1 Oct 2009 16:49:17 +0300
Message-ID: <200910011649.17727.peter.ujfalusi@nokia.com>
References: <1254382367-27948-1-git-send-email-peter.ujfalusi@nokia.com>
	<200910011402.04406.peter.ujfalusi@nokia.com>
	<20091001110919.GC19998@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F6B6103949
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 15:49:22 +0200 (CEST)
In-Reply-To: <20091001110919.GC19998@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 01 October 2009 14:09:19 ext Mark Brown wrote:
> On Thu, Oct 01, 2009 at 02:02:04PM +0300, Peter Ujfalusi wrote:
> > On Thursday 01 October 2009 13:51:07 ext Mark Brown wrote:
> > > I'd rather use dev_name() for the CODEC itself if possible, that is
> > > more likely to be stable going forward and one of the immediate aims
> > > with the API refactoring is to remove socdev entirely at runtime.
> >
> > At this point the codec->dev was NULL, that is why I have used the
> > socdev->dev instead.
> =

> Right, your CODEC driver needs updating to current APIs.  Omitting the
> device name is a good fallback here since you won't be able to have more
> than one of the same device anyway if a device isn't provided.

One of the codec to be blamed is the twl4030 codec, but since that does not=
 use =

any _device/_driver method to load, there is no dev to be assigned to codec-
>dev...
I don't know if it would make sense to use platform_driver_register (and =

associates) with it in the future.

The other codec, which I'm preparing for sending is using i2c probing, so I=
 have =

fixed that, so now it has codec->dev initialized correctly.

> your CODEC driver needs updating to current APIs

Hmm, there are quite a bit of inconsistency among the codec drivers, so I'm=
 not =

sure what is the correct way of doing this.
I will use the wm8993 driver for further fine tuning, since that seams to b=
e =

rather new in the tree.

I'll send a patch later to fix this implementation:
if the codec->dev is valid, than it is going to use dev_name(codec->dev), i=
f it =

is NULL, than it will use either the codec->name or provide the same string=
 as =

the current implementation does ( {dev_name(socdev->dev)}-{codec->name} ), =

whichever is the preferred.

Thanks,
P=E9ter
