From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] FSL_SSI: fix fsl_ssi interrupt reporting
 so that interrupts are only reported when they have been enabled.
Date: Wed, 28 Oct 2015 18:08:18 -0200
Message-ID: <CAOMZO5A9tmEuGQfLJr17xHVmcJVAg26vfMMdfKcxrymdm_ejUw@mail.gmail.com>
References: <1446061992-88379-1-git-send-email-caleb@crome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com
 [209.85.213.176])
 by alsa0.perex.cz (Postfix) with ESMTP id ECD11264F28
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 21:08:19 +0100 (CET)
Received: by igdg1 with SMTP id g1so116073407igd.1
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 13:08:19 -0700 (PDT)
In-Reply-To: <1446061992-88379-1-git-send-email-caleb@crome.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi Caleb,

On Wed, Oct 28, 2015 at 5:53 PM, Caleb Crome <caleb@crome.org> wrote:

> +// call fsl_ssi_dbg_update_sier_enbled every time sier is
> +// updated.  it tracks which interrupts have ever been enabled.
> +// so that the print function can keep track.

The standard style for multi-line comments is:

/*
 * Bla bla bla
 * bla bla
 * foo foo
 */
