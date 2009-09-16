From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH 1/7] ak4114 - fix errors in output selector
	bits
Date: Wed, 16 Sep 2009 09:48:53 +0200
Message-ID: <4AB09865.20805@ivitera.com>
References: <1253054396-7978-1-git-send-email-pavel.hofman@ivitera.com>	<s5hbplbzarg.wl%tiwai@suse.de>	<4AB08D2B.5070604@ivitera.com>
	<s5h63bjz625.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id EEAA21038DC
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Sep 2009 09:48:32 +0200 (CEST)
In-Reply-To: <s5h63bjz625.wl%tiwai@suse.de>
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
> At Wed, 16 Sep 2009 09:00:59 +0200,
> Pavel Hofman wrote:
>> Takashi Iwai wrote:
>>> At Wed, 16 Sep 2009 00:39:50 +0200,
>>> pavel.hofman@ivitera.com wrote:
>>>> From: Pavel Hofman <pavel.hofman@ivitera.com>
>>>>
>>>>
>>>> Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>
>>> Could you describe *what* are exactly fixed?
>>> Do these change influence on any driver behavior?
>> It is just a fix - the original version had a typo - see the equal
>> values for
>> AK4114_OPS12 = AK4114_OPS02
>> AK4114_OPS11 = AK4114_OPS01
>> AK4114_OPS10 = AK4114_OPS00
>>
>> Since no cards actually use this feature, the bug was not uncovered earlier.
> 
> OK, then could you write it in the changelog?

OK, in the evening.

Thanks,

Pavel.
