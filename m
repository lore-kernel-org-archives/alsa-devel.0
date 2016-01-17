From: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH] ALSA: at73c213: manage SSC clock
Date: Sun, 17 Jan 2016 22:34:46 +0100
Message-ID: <20160117213446.GC1703@samfundet.no>
References: <1452969349-9810-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassarossa.samfundet.no (cassarossa.samfundet.no [193.35.52.29])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AF96260449
 for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2016 22:34:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1452969349-9810-1-git-send-email-mans@mansr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mans Rullgard <mans@mansr.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Around Sat 16 Jan 2016 18:35:49 +0000 or thereabout, Mans Rullgard wrote:
> Since commit 49af54ff0fc7 ("misc: atmel-ssc: prepare clock only when
> request") the SSC driver expects clients to manage the SSC clock.
> Update this driver accordingly.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

I assume this will go through the alsa tree.

> ---
>  sound/spi/at73c213.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

<snipp diff>

-- 
Best regards, Hans-Christian Egtvedt.
