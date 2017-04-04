From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Mon, 3 Apr 2017 19:07:42 -0500
Message-ID: <97218d8f-4ba9-6f57-5ec7-d495826b41c4@tabi.org>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
 <20170403220811.GA21156@Asurada-Nvidia>
 <CAG5mAdxDiH4_FVqT5fC+PFGZ108GQCZiLLhja8xGRK0RdWo3oQ@mail.gmail.com>
 <20170403235542.GA23047@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 03F80266972
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 02:07:45 +0200 (CEST)
In-Reply-To: <20170403235542.GA23047@Asurada-Nvidia>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Max Krummenacher <max.krummenacher@toradex.com>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Nicolin Chen wrote:
> So your test case involve both TX and RX. That's why this change
> would impact it. My understanding is: because you can not enable
> TX and RX in the same time from user space but only through two
> separate back-to-back system calls. So when the 2nd system call
> happens (RX for example), the RE bit, supposed to be enabled by
> this 2nd system call, has already been set by the 1st TX system
> call -- there's some random data in the RX FIFO already.

This makes sense to me.  I don't have the bandwidth to test it just yet, but I 
suspect that this patch will break PowerPC systems as well.
