From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: Allow mulitple usage of codec and cpu
	dai
Date: Thu, 25 Feb 2010 10:03:26 +0000
Message-ID: <20100225100326.GC10141@rakim.wolfsonmicro.main>
References: <1267072011-11744-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB3D310381F
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 11:03:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1267072011-11744-1-git-send-email-jassi.brar@samsung.com>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 25, 2010 at 01:26:51PM +0900, Jassi Brar wrote:

>  	/* startup the audio subsystem */
> -	if (cpu_dai->ops->startup) {
> +	if (cpu_dai->active == 0 && cpu_dai->ops->startup) {

I thought I'd been fairly clear last time that the drivers need to have
an option to do stuff on startup().  As I said then a separate callback
which is called only on the transitions into and out of active would be
fine.
