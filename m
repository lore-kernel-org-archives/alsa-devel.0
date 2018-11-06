From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: GitHub - alsa-project - repositories
Date: Tue, 6 Nov 2018 09:05:08 -0600
Message-ID: <57f8965e-f5ec-a65f-47aa-97c67831f417@linux.intel.com>
References: <031c30f1-36b6-4cd9-3f67-3e8de8c77a3e@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F29A2678F2
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 16:05:16 +0100 (CET)
In-Reply-To: <031c30f1-36b6-4cd9-3f67-3e8de8c77a3e@perex.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


On 11/5/18 2:49 AM, Jaroslav Kysela wrote:
> Hi all,
>
>    URL: https://github.com/alsa-project
>
>    I finally finished the first phase of the integration with GitHub. All
> repositories are now on GitHub and all repositories are mirrored to
> alsa-project.org. The github repositories are master (developers should
> push changes only to those repositories). If you refer the repository as
> the code source (for packaging or so), please, keep to use the
> repositories on alsa-project.org (in case when we migrate to other
> service in future like GitLab or so). The mirroring is realtime, so the
> changes should be visible on git.alsa-project.org in few seconds after
> the push.
>
>    I invited few people to the GitHub team and actually Takashi has full
> access to all repos, Vinod Koul should have the write access to
> tinycompress and Takashi Sakamoto should have the write access to
> alsa-gi. If I omitted someone (or someone is not on github), please, let
> me know (and register before).
>
>    Because github adds possibility for the pull requests and issue
> tracking, I added notifications for them to this (alsa-devel) mailing
> list. The short notification should be sent when an pull request or an
> issue is opened or changed. I think that it would be best to handle this
> per request, so the developer can ask to resend the patch to the mailing
> list for the wider review or just push the change with the signing.
>
>    I activated Travis CI for alsa-lib and alsa-utils and I will add other
> repos soon, too. URL: https://travis-ci.org/alsa-project
>
>    If you have some ideas which other github applications can be used to
> improve the code maintenance, let me know. I will probably play with the
> coverity checker (http://scan.coverity.com), too.

Nice. If you figure out how to do the CI integration with Coverity I am 
all ears. I've been trying to enable it for SOF (which is also on 
github) but couldn't find anyone that has done this successfully.

While I am at it, I've only used the 'rebase-and-merge' solution to 
merge PRs, which gives you a linear history similar to what we've always 
had. when using the default merge you end up with a spaghetti plate of 
branches that quickly makes no sense for most people and make tools like 
gitk nearly useless. Maybe the merge is fine when dealing with different 
subsystems but when dealing with relatively small components it's more 
confusing that helpful.

-Pierre
