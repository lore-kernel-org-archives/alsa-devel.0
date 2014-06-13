From: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Subject: Re:
 =?utf-8?q?=5BRFC=5D=5BPATCH_0/2=5D_Fix_aplay_and_als?=
 =?utf-8?q?a-lib_write=5Fareas=28=29_freezing_with_100=25_cpu_usage_on_stu?=
 =?utf-8?q?ck_slave_pcm?=
Date: Fri, 13 Jun 2014 16:13:45 +0400
Message-ID: <1402661625.359891425@f87.i.mail.ru>
References: <1402642371.496174944@f39.i.mail.ru>
 <539ABED4.9000105@perex.cz>
Reply-To: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f87.i.mail.ru (f87.i.mail.ru [128.140.169.159])
 by alsa0.perex.cz (Postfix) with ESMTP id F2A07261606
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 14:13:46 +0200 (CEST)
In-Reply-To: <539ABED4.9000105@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?YWxzYS1kZXZlbA==?= <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Fri, 13 Jun 2014 Jaroslav Kysela wrote:

>> First patch fixes snd_pcm_write_areas() stuck in a loop because of transfer
>> func() always returning 0. That caused application calling it to freeze.
>> In the example above it have frozen aplay. If it was called by firefox,
>> it would freeze firefox.
>> 
>> Is it a good way to fix it? Should snd_pcm_read_areas() be fixed like that too?
>
>Nope: The whole culprit was in the null plugin - the stream was not
>started, thus new samples were not delivered.
>
>I tried to fix this in:
>
>http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=9c3086fb749cd5545be3f15cdde1592390006258
>
>> Second patch fixes aplay itself, not returning from pcm_write() after SIGINT.
>
>Thanks, looks good, but I added the in_aborting check to other
>functions, too:
>
>http://git.alsa-project.org/?p=alsa-utils.git;a=commit;h=c06dbf077459923066c96556678835cd1f55123a

It works great. Thank you!

PS: What do you think about that small aplay patch?:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-June/077665.html
aplay -vvv output looks weird without it.

-- 
  Sergey

fprintf(stderr, "%-20.*s %i%%\n", perc[0]/5, "####################", perc[0]);
