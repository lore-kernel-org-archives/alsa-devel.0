From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: Re: safe support for rewind in ALSA
Date: Tue, 2 Feb 2010 00:10:18 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1002020003370.3125@ecabase.localdomain>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<20100201180139.GC15509@sirena.org.uk>
	<alpine.LNX.2.00.1002011903330.25340@eeebox2.perex-int.cz>
	<alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw01.mail.saunalahti.fi (gw01.mail.saunalahti.fi
	[195.197.172.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 38EDC24375
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 23:13:51 +0100 (CET)
In-Reply-To: <alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, pl bossart <bossart.nospam@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello,

spamming with one more mail.

On Mon, 1 Feb 2010, Kai Vehmanen wrote:

>  - at T3, application calls snd_pcm_delay() to query how many samples
>    of delay there is currently (e.g. if it write a sample to ALSA
>    PCM device now, how long before it hits the speaker)
>      - note that this is what snd_pcm_delay() is specifically for
[...]
> Anyways, the main problem is that snd_pcm_delay() accuracy is limited by
> the transfer/burst size used to move samples from main memory to the sound
> chip, _although_ the hardware _is_ able to tell the exact current position

It just occured to me that could drivers update 'runtime->delay' in their 
pointer callback...? :P And if yes, would it make sense?

Now this would fix snd_pcm_delay() right away (as it already takes 
runtime->delay into consideration). Although definitely not sure whether 
adding standardized side-effects to pointer() is a good idea...
