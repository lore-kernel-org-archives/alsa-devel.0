From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: GitHub - alsa-project - repositories
Date: Tue, 6 Nov 2018 09:49:44 +0900
Message-ID: <fe3a3e44-f712-fac0-a76b-c91b5a1a222e@sakamocchi.jp>
References: <031c30f1-36b6-4cd9-3f67-3e8de8c77a3e@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by alsa0.perex.cz (Postfix) with ESMTP id A14AD267930
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 01:49:48 +0100 (CET)
Received: by mail-pf1-f177.google.com with SMTP id j22-v6so5273311pfh.3
 for <alsa-devel@alsa-project.org>; Mon, 05 Nov 2018 16:49:48 -0800 (PST)
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

Hi Jaroslav,

On 2018/11/05 17:49, Jaroslav Kysela wrote:
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

Thanks for your arrangement. This is what I wish for a long time ;)
(however, I apologize my laziness forward to it...)

Just now I sent my PR to alsa-utils[1], and a notification is sent[2]. A
job of Travis-CI runs automatically on Ubuntu 14.04 LTS (probably in a
docker container)[3]. In the job, alsa-lib was firstly built, then
alsa-utils was built, as described in '.travis.yaml'. It takes a bit
time to download tex-related packages from us mirror of repository
(http://us-east-1.ec2.archive.ubuntu.com/). A few minutes later,
check icon becomes green on github.com.

I have two concerns.

1. For Ubuntu 14.04 LTS (trusty), End-of-life (EOL) is scheduled April
2019. A few months remained but it's better to use recent LTSs such as
18.04 (bionic) to reduce future maintenance cost. (I guess packages
except on 'main' pocket are not already maintained for security
updates.)

2. Message for PR
In my opinion, notification to alsa-devel list is an alternative of
cover-letters in the past. But in this time it doesn't includes change
summary, like:

```
Takashi Sakamoto (3):
   aplay: delete paragraph for obsoleted '--sleep-min' ('-s') option from
     aplay manual
   aplay: add a paragraph for '--samples' ('-s') option to aplay manual
   aplay: improve available conditions for '--samples' and '--duration'
     options

  aplay/aplay.1 | 10 +++++++---
  1 file changed, 7 insertions(+), 3 deletions(-)
```

If it's difficult to include the change summary automatically into the
notification, it's worth to discuss that PR senders should include it
handy to PR message.

[1] https://github.com/alsa-project/alsa-utils/pull/1
[2] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-November/141505.html
[3] 
https://travis-ci.org/alsa-project/alsa-utils/builds/451149201?utm_source=github_status&utm_medium=notification
[4] https://www.ubuntu.com/about/release-cycle


Thanks

Takashi Sakamoto
