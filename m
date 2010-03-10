From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/20] ASoC: S3C64XX: I2S: Make BCLK
 independent of sample size
Date: Wed, 10 Mar 2010 13:00:38 +0000
Message-ID: <20100310130038.GU24422@rakim.wolfsonmicro.main>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
	<20100310123117.GA6850@sirena.org.uk>
	<1b68c6791003100446k5766edb1r2249964c54a1ca99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CC233103932
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 14:00:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791003100446k5766edb1r2249964c54a1ca99@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 09:46:15PM +0900, jassi brar wrote:

> I was thinking of calculating all register field values within the CPU driver
> and let MACHINE driver specify only general parameters of audio(as in
> many CODEC drivers).
> After this patch series, though.

Yes, like I say I've applied the patch as-is - this was just a
suggestion for future work and it's good to hear that you're already
planning to implement such improvements.
