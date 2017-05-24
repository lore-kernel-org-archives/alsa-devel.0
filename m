From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: BUG: double free of PCM structure upon
	module	removal
Date: Wed, 24 May 2017 08:31:39 +0200
Message-ID: <87fufu22b8.fsf@belgarion.home>
References: <87k2571px9.fsf@belgarion.home>
 <20170523171405.iyahe4zfxerd7rn7@sirena.org.uk>
 <s5hefvfo2z4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp11.smtpout.orange.fr
 [80.12.242.133])
 by alsa0.perex.cz (Postfix) with ESMTP id AA5FC267222
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 08:31:41 +0200 (CEST)
In-Reply-To: <s5hefvfo2z4.wl-tiwai@suse.de> (Takashi Iwai's message of "Tue,
 23 May 2017 20:14:07 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> On Tue, 23 May 2017 19:14:05 +0200,
> Mark Brown wrote:
>> 
>> On Tue, May 23, 2017 at 06:46:58PM +0200, Robert Jarzmik wrote:
>> 
>> > Did you notice the same behavior on other platforms, and if not would you have a
>> > hint why it happens to me ?
>> 
>> This is the only report I've seen, sorry.  It's not ringing any bells
>> immediately either - I'll have a think.
>
> What's the problem?  soc_free_pcm_runtime() just calls kfree() of rtd,
> but it's not called in snd_pcm_free(), isn't it?
You're right, it's not called, but it's dereferenced.
The way I see it, what happens is :
 - soc_free_pcm_runtime() calls kfree(rtd)
   - ... guess ...
   - some other call does a kmalloc() which gets the same bucket as rtd
   - this other call puts data in the previous rtd
     => in my backtrace, this data is 35343848, which looks like the string
     "548H"
 - snd_pcm_free() calls soc_pcm_free()
 - soc_pcm_free() uses in the for_each loop rtd->card->component_dev_list, and
   triggers the BUG.

> In anyway the calls there look in a wrong order.  Basically we should
> start with snd_card_free() to sync with the whole operation finishes,
> then release everything.  Below is an untested patch to do that.
With you patch, the bug is gone in my first 3 tries.

Cheers.

--
Robert
