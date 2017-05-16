From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/6] Cleanup and removal of set_fs() from
	HD-audio
Date: Tue, 16 May 2017 20:41:49 +0900
Message-ID: <947fc8de-6a12-9103-0f27-ea198aa56817@sakamocchi.jp>
References: <20170516072350.25070-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 75E1D26751C
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 13:41:56 +0200 (CEST)
In-Reply-To: <20170516072350.25070-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On May 16 2017 16:23, Takashi Iwai wrote:
> Hi,
>
> this is the resubmission of a part of the previous RFC patchset.
> There is no change since then for them, it's just officially submitted
> for merging to 4.13.
>
>
> Takashi
>
> ===
>
> Takashi Iwai (6):
>   ALSA: hda - Simplify bound-beep mute control for ALC268
>   ALSA: hda - Move bind-mixer switch codes to generic parser
>   ALSA: hda - Remove the generic bind ctl helpers
>   ALSA: hda - Remove the use of set_fs()
>   ALSA: hda - Fix a typo in comment
>   ALSA: hda - Remove superfluous header inclusions
>
>  sound/pci/hda/hda_codec.c     | 251 ++++++------------------------------------
>  sound/pci/hda/hda_generic.c   |  46 +++++++-
>  sound/pci/hda/hda_local.h     |  61 ----------
>  sound/pci/hda/patch_realtek.c |  37 +++++--
>  4 files changed, 103 insertions(+), 292 deletions(-)

For all changes:

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Regards

Takashi Sakamoto
