From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH][ASoC v2] Replace snd_soc_free_codec with
 snd_soc_unregister_codec
Date: Thu, 24 Apr 2008 11:33:37 -0500
Message-ID: <4810B661.2040308@freescale.com>
References: <1209054001-1155-1-git-send-email-timur@freescale.com>
	<s5hmynjb4cu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D2F024591
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 18:33:40 +0200 (CEST)
In-Reply-To: <s5hmynjb4cu.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>> -void snd_soc_free_codec(struct snd_soc_codec *codec);
>> +void snd_soc_deregister_codec(struct snd_soc_codec *codec);
> 
> s/deregister/unregister/ ??

Arg, I thought I got all those.


-- 
Timur Tabi
Linux kernel developer at Freescale
