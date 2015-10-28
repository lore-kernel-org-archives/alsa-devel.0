From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH] FSL_SSI: fix fsl_ssi interrupt reporting
 so that interrupts are only reported when they have been enabled.
Date: Wed, 28 Oct 2015 13:47:58 -0700
Message-ID: <CAG5mAdxC+9CSkY1sA8xPo0oF5XdCM_9-KzGqX9JsyD_txAae_w@mail.gmail.com>
References: <1446061992-88379-1-git-send-email-caleb@crome.org>
 <CAOMZO5A9tmEuGQfLJr17xHVmcJVAg26vfMMdfKcxrymdm_ejUw@mail.gmail.com>
 <CAG5mAdw76bSNZ2uQEJChXi3VJKQc_OjC90EpWtknTUpqtKC+9Q@mail.gmail.com>
 <CAOMZO5DA9SgeW1Xcvoo9V35icSf8H2F3cN-K-dFi32wOJMe8HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id E9C11264F28
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 21:48:17 +0100 (CET)
Received: by wicfv8 with SMTP id fv8so26847604wic.0
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 13:48:17 -0700 (PDT)
In-Reply-To: <CAOMZO5DA9SgeW1Xcvoo9V35icSf8H2F3cN-K-dFi32wOJMe8HA@mail.gmail.com>
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

On Wed, Oct 28, 2015 at 1:25 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Oct 28, 2015 at 6:18 PM, Caleb Crome <caleb@crome.org> wrote:
>> On Wed, Oct 28, 2015 at 1:08 PM, Fabio Estevam <festevam@gmail.com> wrote:
>>> Hi Caleb,
>>>
>>> On Wed, Oct 28, 2015 at 5:53 PM, Caleb Crome <caleb@crome.org> wrote:
>>>
>>>> +// call fsl_ssi_dbg_update_sier_enbled every time sier is
>>>> +// updated.  it tracks which interrupts have ever been enabled.
>>>> +// so that the print function can keep track.
>>>
>>> The standard style for multi-line comments is:
>>>
>>> /*
>>>  * Bla bla bla
>>>  * bla bla
>>>  * foo foo
>>>  */
>> Ah, thanks.  Will fix it and resubmit.
>
> Some more tips:
>
> - The Subject should be something like: ASoC: fsl_ssi: Fix fsl_ssi
> interrupt reporting
>
> - Then run  ./scripts/checkpatch.pl 0001-yourpatch.patch to see
> potential issues. The // comment issue would be reported by checkpatch
>
> - Also run  ./scripts/get_maintainer.pl 0001-yourpatch.patch so that
> you get the correct people to Cc the patch too. The email address you
> put for Timur is no longer valid and Nicolin must be on Cc.
>
> Regards,
>
> Fabio Estevam

Great.  Thank you, that will make things go more smoothly for me.

Thanks,
 -Caleb
