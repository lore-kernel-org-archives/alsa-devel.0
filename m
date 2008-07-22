From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 1/3] ALSA SoC: Add OpenFirmware helper
	for matching	bus and codec drivers
Date: Tue, 22 Jul 2008 10:27:57 +0100
Message-ID: <20080722092756.GA2572@rakim.wolfsonmicro.main>
References: <20080722065352.7306.60679.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 04F7E243C0
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 11:27:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080722065352.7306.60679.stgit@trillian.secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: timur@freescale.com, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2008 at 12:53:53AM -0600, Grant Likely wrote:

> This is most likely temporary glue code to work around limitations in
> the ASoC v1 framework.  When v2 is merged, most of this driver will
> need to be reworked.

Whatever is needed in v2 can probably have the client registration
functions integrated into the core registration functions.

> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
