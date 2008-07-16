From: Timur Tabi <timur@freescale.com>
Subject: Re: Requiring the same sample rate for playback and
 record?
Date: Wed, 16 Jul 2008 14:19:43 -0500
Message-ID: <487E49CF.7010709@freescale.com>
References: <485C0042.4050008@freescale.com>	<s5h7icg4dsd.wl%tiwai@suse.de>	<487BC430.8040109@freescale.com>
	<s5hmyki14d5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 95E0F2438D
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 21:19:48 +0200 (CEST)
In-Reply-To: <s5hmyki14d5.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> In a simple case, you don't need hw_constraint functions.  Just
> override the corresponding fields of runtime->hw in open callback.

It looks like ASoC overwrites runtime->hw in *its* _open callback, so I have to
use the hw_constraint functions.

-- 
Timur Tabi
Linux kernel developer at Freescale
