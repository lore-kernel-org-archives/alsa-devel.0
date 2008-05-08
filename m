From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] soc at91 minor bug fixes
Date: Thu, 8 May 2008 11:36:58 +0100
Message-ID: <20080508103657.GB10313@rakim.wolfsonmicro.main>
References: <DC6F86A94046A64094043D44A3A708F7A8DFE1@sestoex02.enea.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C73E2459A
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 12:36:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <DC6F86A94046A64094043D44A3A708F7A8DFE1@sestoex02.enea.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrik Sevallius <patrik.sevallius@enea.com>
Cc: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 08, 2008 at 08:22:48AM +0200, Patrik Sevallius wrote:

> Found these two bugs while browsing through the code.

Thanks, I've committed this to the ASoC repository and pushed it back
out together with a line wrapping change required to make your patch
checkpatch-clean.

> Frank Mandarino was busy so he asked me to send these to this list.

Since Frank isn't passing on the patch directly this:

> Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>

should be Acked-by rather than Signed-off-by (the signoffs should track
the path the patch took into the kernel).
