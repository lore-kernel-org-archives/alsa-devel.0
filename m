From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib][PATCH v2 0/2] ctl: deprecate APIs of
 dimension information
Date: Mon, 13 Nov 2017 09:18:06 +0900
Message-ID: <51d7b10c-da98-8f31-34d0-f5ae69319b9d@sakamocchi.jp>
References: <20171113001411.7430-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id CC558266A73
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 01:18:11 +0100 (CET)
In-Reply-To: <20171113001411.7430-1-o-takashi@sakamocchi.jp>
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
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Nov 13 2017 09:14, Takashi Sakamoto wrote:
> Hi,
> 
> This patchset is to update my previous one:
> [alsa-devel] [alsa-lib][PATCH 0/2] ctl: deprecate APIs of dimension information
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-November/126972.html
> 
> In ALSA control interface of asound.h, 'struct snd_ctl_elem_info' has
> 'dimen' member to deliver information for multi-dimensional array, however
> there's no common way to handle the member. As a result, drivers can
> force userspace applications to handle the information by inconsistent
> ways. A series of echoaudio drivers is an actual example of the
> inconsistent usage.
> 
> This issue was addressed in a commit 51db452df07b ('Revert "ALSA: echoaudio:
> purge contradictions between dimension matrix members and total number of
> members"') to Linux kernel[1]. Fortunately, at present, this feature of
> interface is just used by the drivers, and there's a way to obsolete usage
> of the feature. We can obsolete it without large impacts to userland.
> 
> As a result of discussion at Linux miniconference 2017, usage of 'dimen'
> member of 'struct snd_ctl_elem_info' is going to be deprecated for future
> removal. This patchset is for proposed tasks at a development period of
> Linux kernel v4.15[3]. Some APIs of dimension information are deprecated.
> 
> In a short discussion in my previous patchset, it's clear that actual
> removal of kernel interface is uncertain depending on several conditions.
> Thus the timing to remove the library APIs is not decided yet. This updated
> version reflects the issue in API documentation (but simply removes
> statement of the schedule...).
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/pci/echoaudio?id=51db452df07bb4c5754b73789253ba21681d9dc2
> 
> [2] [alsa-devel] [ANNOUNCE] Audio Mini Summit 2017 at Prague, Oct 27
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-July/123110.html
> 
> [3] https://github.com/takaswie/presentations/blob/master/20171027/contents.md
> 
> Takashi Sakamoto (2):
>    ctl: deprecate APIs of dimensional information
>    test: obsolete usage of APIs of dimensional information
> 
>   src/control/control.c       |  9 +++++++++
>   test/user-ctl-element-set.c | 31 -------------------------------
>   2 files changed, 9 insertions(+), 31 deletions(-)

Oops. I forgot to add my signature... I'm sorry but would you please add 
below when applying these patches into your repository, maintainers?

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thanks

Takashi Sakamoto
