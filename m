From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Don't oops in soc_probe_aux_dev in
 case of missing codec
Date: Fri, 3 Dec 2010 12:27:21 +0000
Message-ID: <20101203122721.GU859@rakim.wolfsonmicro.main>
References: <1291360702-5709-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4EFFA103B3D
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 13:27:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291360702-5709-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 03, 2010 at 09:18:22AM +0200, Jarkko Nikula wrote:
> Blind copy of codec finding algorithm from soc_bind_dai_link does not work
> in soc_probe_aux_dev if matching codec name is not found. In that case the
> code falls through and tries to start the probing procedure with invalid
> codec pointer.

Applied, thanks.
