From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH][asihpi] Meter control return peak.
Date: Thu, 19 Jun 2008 10:27:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806191026370.1798@tm8103-a.perex-int.cz>
References: <200806171335.44469.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 735E824598
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jun 2008 10:27:36 +0200 (CEST)
In-Reply-To: <200806171335.44469.linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 17 Jun 2008, Eliot Blennerhassett wrote:

> Use Peak meter instead of Rms meter because it is supported by all card 
> families.
> Minor checkpatch cleanups.
> 
> Signed-off-by: Eliot Blennerhassett <linux@audioscience.com>
> 
> ---
> diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
> index 8cbefab..ab90b08 100644
> --- a/pci/asihpi/asihpi.c
> +++ b/pci/asihpi/asihpi.c
> @@ -383,15 +383,15 @@ static void snd_card_asihpi_pcm_samplerates(struct 
> snd_card_asihpi *asihpi,

Applied, but could you mail git messages directly or from a mailer which 
does not wrap lines? Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
