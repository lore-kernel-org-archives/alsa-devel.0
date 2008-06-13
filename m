From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 11:14:26 +0100
Message-ID: <48524882.6050606@superbug.co.uk>
References: <20080609190225.GA4534@tango.0pointer.de>	<s5h1w333o7r.wl%tiwai@suse.de>	<20080612205225.GB20818@tango.0pointer.de>	<s5hd4mlhlau.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806130958000.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net
	[194.217.242.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 72F5024499
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 12:14:31 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0806130958000.1798@tm8103-a.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Fri, 13 Jun 2008, Takashi Iwai wrote:
>
>   
>> - Add some new API functions,
>>     
>
> I would prefer to extend the current API than to change meaning of hw_ptr 
> to handle extra latencies.
>
>   
I would prefer the definition of snd_pcm_delay() to be:
Before the next sample is written to the buffer, snd_pcm_delay() returns 
the expect time delay, in frames, indicating the time the next sample 
will reach the speakers.
This is what snd_pcm_delay() was introduced into the ALSA api for. I 
remember, because it was added as a result of me requesting it.


Then implement a totally different api call to help with under run timings.


James
