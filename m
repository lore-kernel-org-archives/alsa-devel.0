From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] wm8753: fix mapping when MONOMIX is set to
 Stereo
Date: Mon, 21 Sep 2009 16:57:57 -0700
Message-ID: <20090921235754.GA19015@sirena.org.uk>
References: <20090921153608.GA14393@OZoNE.TZoNE.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F18D524649
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 01:58:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090921153608.GA14393@OZoNE.TZoNE.ORG>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Phil Vandry <vandry@TZoNE.ORG>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 21, 2009 at 11:36:08AM -0400, Phil Vandry wrote:
> When MONOMIX is set to Stereo, Left PGA was not powered on but should be.
> Add a mapping from Capture Left Mux to Capture Left Mixer to fix the issue.

> Signed-off-by: Phil Vandry <vandry@TZoNE.ORG>

Applied, thanks!
