From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [PATCH] cmipci at 96kHz
Date: Tue, 30 Oct 2007 09:44:12 +0100
Message-ID: <1193733852.1219.1218549445@webmail.messagingengine.com>
References: <4725F492.9020304@ipi.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 46224246F0
	for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2007 09:44:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4725F492.9020304@ipi.ac.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Timofei V. Bondarenko" <tim@ipi.ac.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timofei V. Bondarenko wrote:
> This patch adds support for 88.2k, 96k, and 128k samplerates
> on cmi8738-55 chip.
> Analog playback works fine on all channels.
> Analog capture works well too, though the extra samples seems 
> interpolated by hardware.
> spdif playback and capture works fine.

> +		freq_ext = CM_CH0_SRATE_88K | CM_CH0_SRATE_96K;

I'd guess there should be a new symbol CM_CH0_SRATE_128K.

> +		case 88200:
> +			freq = 44100;
> +		case 96000:
> +			freq = 48000;
> +		case 128000:
> +			freq = 32000; /* not matter, 

Wouldn't it be simpler to divide freq by two in all three cases?


Regards,
Clemens
