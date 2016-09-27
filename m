From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASOC: max9867/rt5616/wm8960: remove usage
 of obsoleted TLV-related macro
Date: Tue, 27 Sep 2016 09:49:35 +0100
Message-ID: <20160927084935.GZ21682@localhost.localdomain>
References: <1474933860-15692-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 881E2266F1C
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 10:49:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1474933860-15692-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, anish kumar <yesanishhere@gmail.com>, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 27, 2016 at 08:51:00AM +0900, Takashi Sakamoto wrote:
> TLV_DB_RANGE_HEAD macro was obsoleted by commit bf1d1c9b6179 ("ALSA: tlv:
> add DECLARE_TLV_DB_RANGE()").
> 
> This commit removes usage of the macro, with the obsoleting macro renamed
> to SNDRV_CTL_TLVD_DECLARE_DB_RANGE().
> 
> Cc: Bard Liao <bardliao@realtek.com>
> Cc: Oder Chiou <oder_chiou@realtek.com>
> Cc: patches@opensource.wolfsonmicro.com
> Cc: anish kumar <yesanishhere@gmail.com>
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
