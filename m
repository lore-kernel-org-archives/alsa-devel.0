From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Why is snd_pcm_hw_params_set_format() not setting
 the format at all?
Date: Mon, 3 Jan 2011 18:08:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101031805490.28150@eeebox2.perex-int.cz>
References: <AANLkTi=BLZ-HFM4G6D6ZTLtUT5JCaXANS-hgVBC2SAXn@mail.gmail.com>
	<alpine.LNX.2.00.1101011604200.28150@eeebox2.perex-int.cz>
	<0520A3FE5EDCF24F88B3F1451CFC64AE03E2D3767B@EDPREX01.logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 76F361038B4
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 18:08:11 +0100 (CET)
In-Reply-To: <0520A3FE5EDCF24F88B3F1451CFC64AE03E2D3767B@EDPREX01.logicpd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philip Chu <Philip.Chu@logicpd.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 3 Jan 2011, Philip Chu wrote:

> When I call snd_pcm_hw_params_set_format() to set up a new format, it seems to call following in order and none of them is setting up the format bit?
>
> snd_pcm_hw_params_set_format() -> snd_pcm_hw_param_set() -> _snd_pcm_hw_param_set() -> snd_mask_refine_set() -> snd_mask_single() + snd_mask_leave()

Please, post or analyze snd_pcm_hw_params_dump() output before and after 
snd_pcm_hw_params_set_format() call.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
