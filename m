From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: KNOT / CONTINUOUS
Date: Tue, 26 Nov 2013 21:27:22 +0100
Message-ID: <5295042A.1000302@metafoo.de>
References: <20131126104140.16e3eb87@armhf> <s5h8uwba2gv.wl%tiwai@suse.de>
 <20131126200916.47a45929@armhf> <5294F85C.4000105@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-025.synserver.de (smtp-out-054.synserver.de
 [212.40.185.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C01226165C
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 21:26:51 +0100 (CET)
In-Reply-To: <5294F85C.4000105@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Jassi Brar <jassi.brar@samsung.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

[...]
> In your codec driver you should specify the minimum and maximum supported
> rate by calling snd_pcm_hw_constraint_minmax() in the DAI startup callback.

It is also possible to set the min and max rate directly in the dai_driver
struct.
