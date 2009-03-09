From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] S3C: Fix S3C2412_IISMOD_SDF_{MSB,
	LSB} definitions
Date: Mon, 9 Mar 2009 18:51:23 +0000
Message-ID: <20090309185115.GA28767@rakim.wolfsonmicro.main>
References: <1236620833-27171-1-git-send-email-ben-linux@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A869103811
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 19:51:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236620833-27171-1-git-send-email-ben-linux@fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: alsa-devel@alsa-project.org, openmoko-kernel@lists.openmoko.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 09, 2009 at 05:47:13PM +0000, Ben Dooks wrote:
> The definitions of S3C2412_IISMOD_SDF_MSB and S3C2412_IISMOD_SDF_LSB
> are incorrect, being the same S3C2412_IISMOD_SDF_IIS which is the
> only correct one in this series.

> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Applied, thanks.
