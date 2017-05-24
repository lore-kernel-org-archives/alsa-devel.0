From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: BUG: double free of PCM structure upon
	module	removal
Date: Wed, 24 May 2017 09:58:47 +0200
Message-ID: <87bmqi1ya0.fsf@belgarion.home>
References: <87k2571px9.fsf@belgarion.home>
 <20170523171405.iyahe4zfxerd7rn7@sirena.org.uk>
 <s5hefvfo2z4.wl-tiwai@suse.de> <87fufu22b8.fsf@belgarion.home>
 <s5ho9uin4gv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr
 [80.12.242.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 14F07265142
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 09:58:50 +0200 (CEST)
In-Reply-To: <s5ho9uin4gv.wl-tiwai@suse.de> (Takashi Iwai's message of "Wed,
 24 May 2017 08:39:28 +0200")
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

> On Wed, 24 May 2017 08:31:39 +0200,
> I see, so my patch should cure such a case.
Indeed.

>> > In anyway the calls there look in a wrong order.  Basically we should
>> > start with snd_card_free() to sync with the whole operation finishes,
>> > then release everything.  Below is an untested patch to do that.
>> With you patch, the bug is gone in my first 3 tries.
>
> I think the patch below is simpler and has the same effect.
> If this works for you, I'll submit the proper patch.
Yep, I just tested it.
Feel free to add my :
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Thanks.

--
Robert
