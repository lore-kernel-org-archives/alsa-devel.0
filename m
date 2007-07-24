From: Timur Tabi <timur@freescale.com>
Subject: Re: How do I tell ALSA that my driver supports every
 possible sample rate?
Date: Tue, 24 Jul 2007 09:54:24 -0500
Message-ID: <46A612A0.6000807@freescale.com>
References: <46A4CF38.3050107@freescale.com>
	<1185210867.7590.1201603759@webmail.messagingengine.com>
	<46A4E503.50207@freescale.com>
	<1185261264.6647.1201715813@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 8248C10380B
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 16:54:28 +0200 (CEST)
In-Reply-To: <1185261264.6647.1201715813@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

>> So I should do this:
>>
>> 	SNDRV_PCM_RATES_5512 | SNDRV_PCM_RATE_8000_192000 | SNDRV_PCM_RATE_CONTINUOUS
> 
> Yes.
> 
>> That's not really elegant.
> 
> How could this be made more elegant?

Well, you could add SNDRV_PCM_RATE_ALL which be the sum of all SNDRV_PCM_RATE_xxx macros, 
where xxx is some number.  So for today, that would be something like this:

#define SNDRV_PCM_RATE_ALL (SNDRV_PCM_RATE_8000_192000 | SNDRV_PCM_RATES_5512)

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
