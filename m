From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA SoC device tree bindings
Date: Sun, 27 Jun 2010 21:53:29 +0100
Message-ID: <ED586769-8F80-4548-8CDE-9E4FBB0F58F7@opensource.wolfsonmicro.com>
References: <201006232030.14138.jeremy.kerr@canonical.com>
	<20100627094246.GA2845@sirena.org.uk>
	<AANLkTimIv99spub4iYnMFKTcNKIzcaPTmDE_b7ygmLJ-@mail.gmail.com>
	(sfid-20100627_134001_594020_7513B7E6)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A30D244C2
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 22:53:31 +0200 (CEST)
In-Reply-To: <AANLkTimIv99spub4iYnMFKTcNKIzcaPTmDE_b7ygmLJ-@mail.gmail.com>
	(sfid-20100627_134001_594020_7513B7E6)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-dev@lists.linaro.org, devicetree-discuss@lists.ozlabs.org, kernel-team@lists.ubuntu.com, Jeremy Kerr <jeremy.kerr@canonical.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 27 Jun 2010, at 13:39, Jon Smirl wrote:
> On Sun, Jun 27, 2010 at 5:42 AM, Mark Brown

>> well, especially in the design section which doesn't make any mention at
>> all of machine specific drivers.

> Do we really want to call them machine drivers? Machine drivers
> already exist in the basic non-audio platform code. Calling the audio
> drivers machine drivers overloads the term. In the Apple audio code
> they are called fabric drivers.

They've been called machine drivers for years. If you find this confusing
I'd suggest qualifying the name ("ASoC machine drivers"), I don't think
renaming them would be worthwhile just for PowerPC. Given the similarity
of their role I'm having a hard time seeing the overlap as a bad thing even
for the people who have difficulty with this.
