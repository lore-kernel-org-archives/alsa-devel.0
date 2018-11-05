From: Vinod Koul <vkoul@kernel.org>
Subject: Re: GitHub - alsa-project - repositories
Date: Mon, 5 Nov 2018 18:24:39 +0530
Message-ID: <20181105125439.GX12092@vkoul-mobl>
References: <031c30f1-36b6-4cd9-3f67-3e8de8c77a3e@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 13950267692
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 13:54:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <031c30f1-36b6-4cd9-3f67-3e8de8c77a3e@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 05-11-18, 09:49, Jaroslav Kysela wrote:
> Hi all,
> 
>   URL: https://github.com/alsa-project
> 
>   I finally finished the first phase of the integration with GitHub. All
> repositories are now on GitHub and all repositories are mirrored to
> alsa-project.org. The github repositories are master (developers should
> push changes only to those repositories). If you refer the repository as
> the code source (for packaging or so), please, keep to use the
> repositories on alsa-project.org (in case when we migrate to other
> service in future like GitLab or so). The mirroring is realtime, so the
> changes should be visible on git.alsa-project.org in few seconds after
> the push.
> 
>   I invited few people to the GitHub team and actually Takashi has full
> access to all repos, Vinod Koul should have the write access to
> tinycompress and Takashi Sakamoto should have the write access to
> alsa-gi. If I omitted someone (or someone is not on github), please, let
> me know (and register before).

Thanks Jaroslav,

I guess first thing I need is to update my email id :-)

Btw how would the sync be done wrt git.alsa-project.org repos and github
or we should move to github starting .... ?

> 
>   Because github adds possibility for the pull requests and issue
> tracking, I added notifications for them to this (alsa-devel) mailing
> list. The short notification should be sent when an pull request or an
> issue is opened or changed. I think that it would be best to handle this
> per request, so the developer can ask to resend the patch to the mailing
> list for the wider review or just push the change with the signing.
> 
>   I activated Travis CI for alsa-lib and alsa-utils and I will add other
> repos soon, too. URL: https://travis-ci.org/alsa-project
> 
>   If you have some ideas which other github applications can be used to
> improve the code maintenance, let me know. I will probably play with the
> coverity checker (http://scan.coverity.com), too.
> 
> 					Jaroslav
> 
> -- 
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
~Vinod
