From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa-driver: compilation fails
Date: Wed, 24 Nov 2010 07:50:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011240750230.8433@eeebox2.perex-int.cz>
References: <AANLkTi=KTF89RVmRkNXidW3U08BoeXihHmu8vggE6kBr@mail.gmail.com>
	<s5hy68jnulg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 743B524529
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 07:50:50 +0100 (CET)
In-Reply-To: <s5hy68jnulg.wl%tiwai@suse.de>
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
Cc: pl bossart <bossart.nospam@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Nov 2010, Takashi Iwai wrote:

> At Tue, 23 Nov 2010 18:10:37 -0600,
> pl bossart wrote:
>>
>> Somehow I pulled the latest and greatest code alsa-kmirror and
>> alsa-driver, and the compilation now fails. ./gitcompile yells about a
>> problematic patch on pcm_native.c.
>> Any idea on how to refresh this patch ?
>> Thanks,
>> -Pierre
>
> This was already fixed on alsa-driver-build.git.
>  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver-build.git

I pulled from this repo, so gitcompile should work again.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
