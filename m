From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH 1/7] ak4114 - fix errors in output selector
	bits
Date: Mon, 21 Sep 2009 20:38:08 +0200
Message-ID: <4AB7C810.7060402@ivitera.com>
References: <1253132741-15688-1-git-send-email-pavel.hofman@ivitera.com>
	<s5hpr9kwfqr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.pilsfree.net (mail.pilsfree.net [81.201.60.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 59441103842
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Sep 2009 20:38:17 +0200 (CEST)
In-Reply-To: <s5hpr9kwfqr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 16 Sep 2009 22:25:35 +0200,
> pavel.hofman@ivitera.com wrote:
>> From: Pavel Hofman <pavel.hofman@ivitera.com>
>>
>> * the previous version had a typo - values of AK4114_OPS10-12 were
>>   identical with AK4114_OPS00-02
>> * Since no cards actually use this feature, the bug was not identified earlier
>>
>> Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>
> 
> Thanks.  Now all patches have been applied to sound git tree.
> 

Takashi, thanks a lot.

Do you have any idea when we can expect the changes to propagate to
http://git.alsa-project.org/?p=alsa-kmirror.git;a=summary so that people
can install using description in
http://alsa-project.org/main/index.php/GIT_Server#Occasional_Developers ?

I am planning a few more fixes and compiling the whole kernel seems a
bit of overhead.

Regards,

Pavel.
