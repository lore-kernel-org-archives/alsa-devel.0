From: Ivan Sorokin <vanyacpp@gmail.com>
Subject: Re: possibly memory leak in alsa-lib
Date: Wed, 31 Oct 2012 01:36:09 +0400
Message-ID: <50904849.5030101@gmail.com>
References: <508EFF67.6020901@gmail.com>
 <20121030114835.5cb85160@t510.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 085A42608E7
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 22:35:51 +0100 (CET)
Received: by mail-la0-f51.google.com with SMTP id m15so518690lah.38
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 14:35:51 -0700 (PDT)
In-Reply-To: <20121030114835.5cb85160@t510.perex-int.cz>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 30.10.2012 14:48, Jaroslav Kysela wrote:
> On Tue, 30 Oct 2012 02:12:55 +0400
> Ivan Sorokin <vanyacpp@gmail.com> wrote:
>
>> The following program shows a few leaks in valgrind (ubuntu 12.04,
>> alsa-lib 1.0.25, eglibc 2.15):
>>
>> I'm not sure, but probably some leaks are caused by glibc.
>
> Most of them are glibc leaks, but I found a little issue in alsa-lib,
> too. This commit should fix it:
>
> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=edcd677bf2065c560ef578940bab8f0aacddf0e6

Thank you very much. I looked into those leaks in glibc and they 
appeared to be fixed (at least some of them):

http://sourceware.org/git/?p=glibc.git;a=commitdiff;h=d44638b0a7fc1f01c3b2153cfa1bbb849f01f217;hp=da0331a873dbb62462c151c3d824da2f6fe2e770

Sadly this fix is in 2.16 and ubuntu 12.04 is shipped with glibc 2.15. 
When I get next version of glibc, I will check my program again.
