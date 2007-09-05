From: Markus Franke <markus.franke@s2002.tu-chemnitz.de>
Subject: Re: DMA buffer gets played only once
Date: Wed, 05 Sep 2007 14:47:22 +0530
Message-ID: <46DE7422.5020900@hrz.tu-chemnitz.de>
References: <46DE4AB1.20206@hrz.tu-chemnitz.de>
	<1188983079.7844.1208974467@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lana.hrz.tu-chemnitz.de (lana.hrz.tu-chemnitz.de
	[134.109.132.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 7ADCB103803
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 11:15:41 +0200 (CEST)
In-Reply-To: <1188983079.7844.1208974467@webmail.messagingengine.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Markus Franke wrote:
>> It seems like that after the 8th period is transferred
>> pcm_trigger(TRIGGER_STOP) isn't getting called. 
> 
> Indeed.  The stop trigger is called when the entire stream is
> to be stopped.

Well, start and stop trigger get always called mutually. In pseudo code 
it would look like this:

---snip---
TRIGGER_START

transfer one period via DMA

TRIGGER_STOP

update DMAC settings in DMA transfer finished callback and call 
snd_pcm_period_elapsed()

TRIGGER_START

transfer one period via DMA

TRIGGER_STOP

update DMAC settings in DMA transfer finished callback and call 
snd_pcm_period_elapsed()

....and so on.
---snap---

At least this is the behaviour I experienced.

So long,
Markus
