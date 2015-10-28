From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH] FSL_SSI: fix fsl_ssi interrupt reporting
 so that interrupts are only reported when they have been enabled.
Date: Wed, 28 Oct 2015 13:18:39 -0700
Message-ID: <CAG5mAdw76bSNZ2uQEJChXi3VJKQc_OjC90EpWtknTUpqtKC+9Q@mail.gmail.com>
References: <1446061992-88379-1-git-send-email-caleb@crome.org>
 <CAOMZO5A9tmEuGQfLJr17xHVmcJVAg26vfMMdfKcxrymdm_ejUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 861F6264F28
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 21:18:59 +0100 (CET)
Received: by wicfx6 with SMTP id fx6so211188935wic.1
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 13:18:59 -0700 (PDT)
In-Reply-To: <CAOMZO5A9tmEuGQfLJr17xHVmcJVAg26vfMMdfKcxrymdm_ejUw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Markus Pargmann <mpa@pengutronix.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 28, 2015 at 1:08 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Caleb,
>
> On Wed, Oct 28, 2015 at 5:53 PM, Caleb Crome <caleb@crome.org> wrote:
>
>> +// call fsl_ssi_dbg_update_sier_enbled every time sier is
>> +// updated.  it tracks which interrupts have ever been enabled.
>> +// so that the print function can keep track.
>
> The standard style for multi-line comments is:
>
> /*
>  * Bla bla bla
>  * bla bla
>  * foo foo
>  */
Ah, thanks.  Will fix it and resubmit.

-Caleb
