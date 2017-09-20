From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [Resend] [PATCH 1/4] ASoC: dapm: fix error path in
 snd_soc_dapm_new_pcm
Date: Wed, 20 Sep 2017 12:02:05 +0100
Message-ID: <20170920110205.erts27ibxhfe4lhs@localhost.localdomain>
References: <1505896116-43310-1-git-send-email-yesanishhere@gmail.com>
 <1505896116-43310-2-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 73CBF266B21
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 13:02:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1505896116-43310-2-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yesanishhere@gmail.com
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 20, 2017 at 01:28:33AM -0700, yesanishhere@gmail.com wrote:
> From: anish kumar <yesanishhere@gmail.com>
> 
> w_param_text[count] is freed in the wrong error path.
> Fix it by shifting the outfree_w_param label.
> 
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
