From: Konstantin Ozerkov <kozerkov@parallels.com>
Subject: Re: [PATCH 0/3] ALSA: intel8x0: Improve virtual
	environment detection
Date: Thu, 10 Nov 2011 12:10:12 +0300
Message-ID: <4EBB94F4.9070008@parallels.com>
References: <1320852536-11786-1-git-send-email-kozerkov@parallels.com>
	<s5hsjlxb3d1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.parallels.com (mx2.parallels.com [64.131.90.16])
	by alsa0.perex.cz (Postfix) with ESMTP id 80C5B243ED
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 10:10:41 +0100 (CET)
In-Reply-To: <s5hsjlxb3d1.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09.11.11 20:41, Takashi Iwai wrote:
> At Wed, 9 Nov 2011 19:28:53 +0400,
> Konstantin Ozerkov wrote:
>> Improve detection logic as discussed early: add secondary checks by PCI SSID.
>>
>> Note: patch [3/3] is made for alsa-driver tree.
> Thanks, applied now.
>
> The patch 3 couldn't be applied cleanly to my tree, so I refreshed
> by myself.
>
> Which git trees are you referring to?  At the next time, please create
> patches based on sound git tree, which is the base for linux-next:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>
> Also for the external alsa-driver, please use the git tree below:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver-build.git
>
>
> Takashi
Thanks for advise.

I follow tutorial from http://www.alsa-project.org/main/index.php/GIT_Server
I use
git://git.alsa-project.org/alsa-driver.git
git://git.alsa-project.org/alsa-kmirror.git
