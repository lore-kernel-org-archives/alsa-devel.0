From: "Andrey Mazo" <mazo@telum.ru>
Subject: Re: alsa-lib changes in pcm file plugin
Date: Sun, 17 Nov 2013 13:55:46 +0400
Message-ID: <op.w6otu8d3vp3tvr@hippo-yoga>
References: <1384636316-26706-1-git-send-email-mazo@telum.ru>
 <s5hsiuvv15f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.telum.ru (mail.telum.ru [62.141.76.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 4137E261603
 for <alsa-devel@alsa-project.org>; Sun, 17 Nov 2013 10:56:06 +0100 (CET)
In-Reply-To: <s5hsiuvv15f.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you very much for replying so quickly!

On Sun, 17 Nov 2013 13:16:28 +0400, Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 17 Nov 2013 01:11:53 +0400,
> Andrey Mazo wrote:
>>
>> Hi,
>>
>> This short patch series contains three independent changes in pcm file  
>> plugin.
>> The first two of them are trivial fixes and should not cause any  
>> behavior changes and regressions.
>> The third one contains changes to make pcm_file.c access input/output  
>> files only when needed and thus to make its behavior more intuitive  
>> (from my point of view) (i.e., write to output file only on playback  
>> and read from input file only on capture).
>>
>> The patches should apply cleanly against current HEAD  
>> (ae035b7fe5620fcaf4f5ea33ecabcf93b8e056cd).
>
> Thanks, applied all three patches.
>
>
> Takashi

-- 
Andrey Mazo
