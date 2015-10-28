From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] FSL_SSI: fix fsl_ssi interrupt reporting
 so that interrupts are only reported when they have been enabled.
Date: Wed, 28 Oct 2015 17:39:27 -0500
Message-ID: <CAOZdJXUuPByUAzBsuKuJE16V1BmKvpyaYDO4HSAb8z9xPAszFQ@mail.gmail.com>
References: <1446061992-88379-1-git-send-email-caleb@crome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 45D45265090
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 23:39:29 +0100 (CET)
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com
 [209.85.223.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by muin.pair.com (Postfix) with ESMTPSA id 61717F1847
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 18:39:27 -0400 (EDT)
Received: by iofz202 with SMTP id z202so27095854iof.2
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 15:39:27 -0700 (PDT)
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
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 28, 2015 at 2:53 PM, Caleb Crome <caleb@crome.org> wrote:
> The current implementation reports all interrupt stats
> in /sys/kernel/debug/*.ssi/stats, even if the interrupt
> was not enabled.  This is not the intention as per
> the comments.  This fix keeps track of ever bit in the

"every"

Also, please send patches to timur@tabi.org and not
timur@freescale.com.  Thanks.
