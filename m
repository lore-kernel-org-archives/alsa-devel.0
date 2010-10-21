From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] wm1133-ev1: fix init for multimachine
	kernel
Date: Thu, 21 Oct 2010 14:58:40 -0700
Message-ID: <20101021215840.GF30466@opensource.wolfsonmicro.com>
References: <1287696915-10392-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 46C45103AB3
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 23:58:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1287696915-10392-1-git-send-email-eric@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 21, 2010 at 11:35:15PM +0200, Eric B=E9nard wrote:

> +	if (!machine_is_mx31ads())
> +		/* return happy. We might run on a totally different machine */
> +		return 0;
> +

This is not a sufficient check, we may be running on an mx31ads with a
different PMIC module.
