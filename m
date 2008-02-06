From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] aplay/arecord - Add support for IEEE float
 32-bit WAV files
Date: Wed, 06 Feb 2008 15:39:42 +0100
Message-ID: <47A9C6AE.3090007@ladisch.de>
References: <711f7227eb13715f8a4b.1201991392@am2>
	<200802061503.47269.mgerdau@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 615F1103829
	for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2008 15:37:52 +0100 (CET)
In-Reply-To: <200802061503.47269.mgerdau@tiscali.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Gerdau <mgerdau@tiscali.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Michael Gerdau wrote:
>> +/* WAVE fmt block constants from Microsoft mmreg.h header */
>> +#define WAV_FMT_PCM             0x0001
>> +#define WAV_FMT_IEEE_FLOAT      0x0003
>> +#define WAV_FMT_DOLBY_AC3_SPDIF 0x0092
> 
> Does this mean "copy and paste" from M$ copyrighted work ?

No, mmreg.h actually uses "WAVE_FORMAT_PCM".


Regards,
Clemens
