From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [uclinux-dist-devel] [PATCH] ASoC: Blackfin: allow
 SPI for SSM2602 parts
Date: Fri, 17 Jun 2011 11:21:11 -0400
Message-ID: <BANLkTimgOd=7wB96VkiovGDrgDmhTPwMkg@mail.gmail.com>
References: <1308277455-370-1-git-send-email-vapier@gentoo.org>
	<20110617094136.GB7851@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6F1062456A
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 17:21:31 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1143984fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2011 08:21:31 -0700 (PDT)
In-Reply-To: <20110617094136.GB7851@opensource.wolfsonmicro.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 17, 2011 at 05:41, Mark Brown wrote:
> On Thu, Jun 16, 2011 at 10:24:15PM -0400, Mike Frysinger wrote:
>> This board has hardware switches for selecting SPI or I2C, so don't
>> require I2C for this driver.
>
> Applied, though I suspect this won't actually load as the different bus
> will change the name the CODEC uses to register with the subsystem (so
> we can address multiple CODECs).

yes, i vaguely recall having to tweak the string name to something
like "spi0.4".  i think this gets back to our discussion about pushing
things into the platform resources.
-mike
