From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [patch 1/4] ASoC: dapm: fix error path in
	snd_soc_dapm_new_pcm
Date: Fri, 1 Sep 2017 18:25:15 -0700
Message-ID: <1647EB0E-8F21-465A-A308-9BEBF2859E09@gmail.com>
References: <20170826082925.35472-1-yesanishhere@gmail.com>
 <20170827124305.ux5jj3uzycf5eqm7@sirena.org.uk>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 372C9266BA4
 for <alsa-devel@alsa-project.org>; Sat,  2 Sep 2017 03:25:18 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id t193so1044259pgc.4
 for <alsa-devel@alsa-project.org>; Fri, 01 Sep 2017 18:25:18 -0700 (PDT)
In-Reply-To: <20170827124305.ux5jj3uzycf5eqm7@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



> On Aug 27, 2017, at 5:43 AM, Mark Brown <broonie@kernel.org> wrote:

Thanks for reviewing.
> 
>> On Sat, Aug 26, 2017 at 01:29:25AM -0700, anish kumar wrote:
>> Before freeing the memory, check if it was allcoated.
> 
>> -outfree_w_param:
>>    for (count = 0 ; count < num_params; count++)
>> -        devm_kfree(card->dev, (void *)w_param_text[count]);
>> +            if (w_param_text[count])
>> +            devm_kfree(card->dev, (void *)w_param_text[count]);
> 
> There's no need to do this, devm_kfree() will handle null pointers fine.

Got it. I am waiting for comments on my other patches in this series before sending again.
