From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: ALSA SoC device tree bindings
Date: Sun, 27 Jun 2010 08:39:55 -0400
Message-ID: <AANLkTimIv99spub4iYnMFKTcNKIzcaPTmDE_b7ygmLJ-@mail.gmail.com>
References: <201006232030.14138.jeremy.kerr@canonical.com>
	<20100627094246.GA2845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A9E09103844
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 14:39:56 +0200 (CEST)
Received: by qwk3 with SMTP id 3so895502qwk.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 05:39:56 -0700 (PDT)
In-Reply-To: <20100627094246.GA2845@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, linaro-dev@lists.linaro.org, devicetree-discuss@lists.ozlabs.org, kernel-team@lists.ubuntu.com, Jeremy Kerr <jeremy.kerr@canonical.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 27, 2010 at 5:42 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jun 23, 2010 at 08:30:13PM +0800, Jeremy Kerr wrote:
>
>> At this stage, we're just looking at how to structure device in the devi=
ce
>> tree. The bindings for specific devices will come as required (ie, as we=
 add
>> device tree support for them).
>
> Actually, re-reading the page I'm not sure it really captures my
> understanding of the discussion (and all the previous discussions we've
> had on the lists and so on) at all. =A0Reading the page the idea that a
> machine specific driver is normal and expected doesn't come over at all
> well, especially in the design section which doesn't make any mention at
> all of machine specific drivers.

Do we really want to call them machine drivers? Machine drivers
already exist in the basic non-audio platform code. Calling the audio
drivers machine drivers overloads the term. In the Apple audio code
they are called fabric drivers.


> As I keep saying the main thing I'm looking for from any device tree
> binding is something that I can point people at so we don't need to go
> through the rehashings of this subject which come up every time someone
> decides they want to use device trees.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- =

Jon Smirl
jonsmirl@gmail.com
