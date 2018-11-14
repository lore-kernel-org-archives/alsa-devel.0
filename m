From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: GitHub - alsa-project - repositories
Date: Thu, 15 Nov 2018 00:50:22 +0900 (JST)
Message-ID: <alpine.DEB.2.21.1811142352060.2496@laptop>
References: <031c30f1-36b6-4cd9-3f67-3e8de8c77a3e@perex.cz>
 <fe3a3e44-f712-fac0-a76b-c91b5a1a222e@sakamocchi.jp>
 <970ae06c-be01-8cef-930e-a7c0bccfa31b@perex.cz>
 <fea4f32f-625c-7e2e-3911-667221a43877@sakamocchi.jp>
 <7943ec40-aff5-0157-530b-cd08ad3ef732@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D37C267A61
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 16:50:27 +0100 (CET)
Received: by mail-pg1-f193.google.com with SMTP id d72so4100629pga.9
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 07:50:27 -0800 (PST)
In-Reply-To: <7943ec40-aff5-0157-530b-cd08ad3ef732@perex.cz>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

Sorry for late reply.

On Thu, 8 Nov 2018, Jaroslav Kysela wrote:
>> Well, I have another concern when having conversation with Daniel
>> Baluta[1]. He post his 'Reviewed-by' tag to the github issue. In this
>> case, how can we apply the tag to commit history? I don't know exactly
>> services in github.com have good solution for this issue, or not...
>>
>> [1] https://github.com/alsa-project/alsa-utils/pull/1#issuecomment-436164565
>
> I believe that the maintainer who signs and pushes the commits should
> handle those tags, too.
>
> It means that we are not allowed to use the github web merge button! (no
> signing - seems like on github's issue list -
> https://github.com/todogroup/gh-issues/issues/50)

Thank you. It's completely against out maintainance policy that we can
handle no tag such as 'Reviewed-by:' and 'Signed-off-by:', thus the web 
merge button in github.com can not be used. I'm OK to avoid pushing 
the button.

I think it good to push a small guideline message for userspace work to 
somewhere for smooth communication between people, like:

1. contributors
  * prepare change history so that fast-forward to remote repository
  * each of commit should have 'Signed-off-by:' tag
  * For bug fix, additional 'Fixes:' tag is preferable
  * two communication paths; 'git format-patch/send-email' to alsa-devel
    list, or PR on github.com
  * put enough information in cover-letter of email or PR comment so that
    reviers/maintainers can get purpose of this work
2. reviewers
  * any review action is welcome and expected
  * after review work, send comments with 'Reviewed-by:', 'Tested-by:' tags
    as reply to the list or PR so that contributors and reviewers can catch
3. maintainers
  * apply the patches from contributor to local repository by hand without
    web UI of github.com so that the history has no merge commits
  * add reviewer's tags to applied commits
  * add 'Signed-off-by:' tag to applied commits
  * reply to list or PR when push to remote repository

Any thoughts?


Thanks

Takashi Sakamoto
