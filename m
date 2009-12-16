From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Fix disable of SPDIF on STAC9766 codec
Date: Wed, 16 Dec 2009 15:57:39 +0000
Message-ID: <20091216155739.GA31418@rakim.wolfsonmicro.main>
References: <20091216015344.21806.5403.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9D30A103806
	for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2009 16:57:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091216015344.21806.5403.stgit@terra>
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
Cc: joe@perches.com, alsa-devel@alsa-project.org, clemens@ladisch.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 15, 2009 at 08:53:44PM -0500, Jon Smirl wrote:
> Change code so that switching to playing music through the analog output disables SPDIF
> out instead of disabling it when stream ends.
> 
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

Applied, thanks, with word-wrapping and whatnot in the commit message.
