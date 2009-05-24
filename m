From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V2 0/9] mpc5200 audio rework for AC97
Date: Sun, 24 May 2009 11:21:15 -0400
Message-ID: <9e4733910905240821p7313f82bu171e0d4a2f3dbbff@mail.gmail.com>
References: <20090523231148.17919.46103.stgit@terra>
	<20090524110854.GB4933@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 75C3A24492
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 17:21:19 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3762115qyk.16
	for <alsa-devel@alsa-project.org>; Sun, 24 May 2009 08:21:16 -0700 (PDT)
In-Reply-To: <20090524110854.GB4933@sirena.org.uk>
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
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, May 24, 2009 at 7:08 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> I'm not aware of any CODEC drivers which can't currently be built and
> used as modules. =A0If you mean "load via the normal device model" then
> yes, that'd be very good (and is in progress) but it's another issue and
> as I explained last time AC97 poses particular problems there.
>

I mean "load via the normal device model". For example the AC97
drivers need to be loadable by the codec id. There's no entry in
scripts/mod/file2alias.c for dynamically loading the modules.  They
don't have an id_table.

My AC97 driver is detecting the codec id and printing it before trying
to access the codec driver. I can convert that to a load_module() call
when the drivers are ready.

The core needs to detect if a specific codec id can't be supported to
fall back to the generic AC97 driver.

-- =

Jon Smirl
jonsmirl@gmail.com
