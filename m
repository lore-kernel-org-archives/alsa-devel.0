From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC] bind/unbind SoC devices with deferred list
Date: Wed, 22 Apr 2015 14:06:32 +0200
Message-ID: <55378EC8.2020509@metafoo.de>
References: <87383sh7i6.wl%kuninori.morimoto.gx@renesas.com>
 <s5h7ft4mkvu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-173.synserver.de (smtp-out-173.synserver.de
 [212.40.185.173])
 by alsa0.perex.cz (Postfix) with ESMTP id CC0D826057F
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 14:06:28 +0200 (CEST)
In-Reply-To: <s5h7ft4mkvu.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 04/22/2015 02:02 PM, Takashi Iwai wrote:
> At Wed, 22 Apr 2015 08:51:21 +0000,
> Kuninori Morimoto wrote:
>>
>>
>> Hi Takashi, Mark, Lars
>>
>> I worked for bind/unbind issue which was discussed before
>>
>> http://thread.gmane.org/gmane.linux.alsa.devel/134062/focus=134076
>> http://thread.gmane.org/gmane.linux.alsa.devel/134283/focus=134287
>>
>> I would like to know your opinion before sending patch to Greg
>>
>> The problem is ASoC has card/platform/cpu/codec relationship for each other,
>> but, we can unbind one of them, and then, other related devices doesn't know
>> about it. Thus, kernel will error if we use sound after that.
>
> Wouldn't the standard component (linux/component.h) be able to solve
> such a problem?

At least that is the idea. The long term plan for ASoC is to switch over to 
the component framework.

- Lars
