From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 6/9] ARM: DaVinci: ASoC: Adds McASP
	clock	support for TI DM646X processor
Date: Thu, 19 Mar 2009 19:09:43 +0000
Message-ID: <20090319190942.GA8966@sirena.org.uk>
References: <FF55437E1F14DA4BAEB721A458B67017069809B098@dbde02.ent.ti.com>
	<87ljr1l8g4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BA2724412
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 20:10:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87ljr1l8g4.fsf@deeprootsystems.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Medisetty, Naresh" <naresh@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 19, 2009 at 10:38:03AM -0700, Kevin Hilman wrote:

>     CLK(NULL, "mcasp0" &mcasp0_clk),
>     CLK(NULL, "mcasp1", &mcasp1_clk),

Exactly.

> The platform code can do a clk_get(<physcial name>) and pass that
> clk in with the platform data.

There should be no need to do this - the McASP DAI driver can just be a
regular platform device, probe as normal and register the DAI with the
ASoC core once it has done so.  This is, in fact, the preferred method
for doing this though support for htis is recent so only one CPU DAI
driver does it so far.
