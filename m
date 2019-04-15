From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ALSA: seq: Correct unlock sequence at
 snd_seq_client_ioctl_unlock()
Date: Mon, 15 Apr 2019 13:05:07 +0300 (EEST)
Message-ID: <alpine.DEB.2.21.1904151258340.20954@eliteleevi>
References: <20190415093105.23965-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACFD2F8962D
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2019 12:03:50 +0200 (CEST)
In-Reply-To: <20190415093105.23965-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, 15 Apr 2019, Takashi Iwai wrote:

> The doubly unlock sequence at snd_seq_client_ioctl_unlock() is tricky.
> I took a direct unref call since I thought it would avoid
> misunderstanding, but rather this seems more confusing.  Let's use
> snd_seq_client_unlock() consistently even if they look strange to be
> called twice, and add more comments for avoiding reader's confusion.
> 
> Fixes: 6b580f523172 ("ALSA: seq: Protect racy pool manipulation from OSS sequencer")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/seq/seq_clientmgr.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

thanks, looks good now (this and rest of the clean-up series):
  Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Br, Kai
