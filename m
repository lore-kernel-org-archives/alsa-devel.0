From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ucm: change msleep to usleep
Date: Fri, 19 Aug 2011 17:12:52 +0100
Message-ID: <4E4E8B84.1070700@ti.com>
References: <20110819072217.4790.29949.stgit@localhost6.localdomain6>
	<s5hpqk1luh6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 1657C10380B
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 18:13:05 +0200 (CEST)
In-Reply-To: <s5hpqk1luh6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 19/08/11 08:40, Takashi Iwai wrote:
> At Fri, 19 Aug 2011 15:22:17 +0800,
> Lu Guanqun wrote:
>>
>> In file src/ucm/parser.c:
>> 	if (strcmp(cmd, "usleep") == 0) {
>> string `usleep' is compared, however, in the comment and example conf file,
>> `msleep' is used, it's better to unify them all.
> 
> Don't we scale the value appropriately (although it's just a demo)?
> 

msleep is more useful here for pop prevention, but I suppose usleep could be useful too.

Could you redo to support both usleep and msleep ?

Thanks

Liam
