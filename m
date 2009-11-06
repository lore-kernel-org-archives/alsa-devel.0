From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/7] S3C64XX PCM: Defined PCM
	controller	platform devices
Date: Fri, 6 Nov 2009 16:54:07 +0000
Message-ID: <20091106165406.GG4938@sirena.org.uk>
References: <1257384907-18338-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 45D962446C
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 17:54:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257384907-18338-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 05, 2009 at 10:35:07AM +0900, Jassi Brar wrote:
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  arch/arm/plat-s3c/include/plat/devs.h |    3 +
>  arch/arm/plat-s3c64xx/dev-audio.c     |  101 ++++++++++++++++++++++++++++++++-
>  2 files changed, 103 insertions(+), 1 deletions(-)

Might be good to call the devices "samsung-pcm" rather than "s3c-pcm" or
whatever the decision is on a common prefix to cope with the s5p CPUs.
