From: Randolph Chung <rchung42@gmail.com>
Subject: Re: [PATCH] Add support for tlv320aic3007 to
	tlv320aic3x driver
Date: Thu, 19 Aug 2010 18:00:29 +0800
Message-ID: <AANLkTinK13H3sHGSmCa_4nzVbH4Nz=JEHguckN99uksD@mail.gmail.com>
References: <AANLkTinScuZVufiHO15uvBMrf4oPMAV=r__G72b=o2u8@mail.gmail.com>
	<20100819094744.GA9307@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B7BEE24332
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 12:00:30 +0200 (CEST)
Received: by iwn34 with SMTP id 34so1289425iwn.38
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2010 03:00:30 -0700 (PDT)
In-Reply-To: <20100819094744.GA9307@sirena.org.uk>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

> Rather than passing something in the platform data you should use the
> I2C device ID table for the device and have the board register the
> device as a tlv320aic3007.

Yes, that will work too - if that's the preference I will rework the
patch that way.

> I would review the patch in more detail but you attached it as a base64
> encoded attachment which means my MUA hasn't quoted it for me and won't
> even display it unless I explicitly open it...

My apologies - since you reported whitespace damage in my previous
post I included the patch as an attachment and apparently my mail
client decided to base64 encode it. I will post followups from another
MUA.

> The main thing I noticed
> was that you're using an enum instead of a TLV control for the amp
> volume.

The amp volume (gain) only has 4 steps (0, 6dB, 12dB, 18dB). I can
rework as a TLV if that's the preference. TI has a (non-published?)
driver for this codec that used an enum so this part was copied over.

> As I reminded you last time you always need to CC maintainers on
> patches. =A0This is very helpful for ensuring that we actually see things
> on busy lists and is helpful for keeping track of what needs reviewing.

You copied my last patch to lrg (and he acked the patch), so I copied
my patch to lrg. Previous patches to this driver were also signed off
by him. Should I copy to somebody else?

randolph
