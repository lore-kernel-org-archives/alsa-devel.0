From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: Alsa Issue - Sound playback starts on left speaker
 only
Date: Wed, 25 Jun 2008 09:52:21 -0700
Message-ID: <486277C5.10308@cox.net>
References: <6AA7F928714999469B70E7707C87F82C531570@TW-EVS02.corelcorp.corel.ics>	<4860AF67.7060507@cox.net>	<s5hr6alooar.wl%tiwai@suse.de>
	<48621229.8040603@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao103.cox.net (fed1rmmtao103.cox.net [68.230.241.43])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FECD243DC
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 18:53:21 +0200 (CEST)
In-Reply-To: <48621229.8040603@insite.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@insite.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pavel Hofman wrote:
>>>>   
>>>>         
>>> The ICE1724 driver has exactly this behavior.  It is a known bug and has 
>>> been there for years.
>>> You don't say what chip is having the problem, but I would guess that 
>>> this is it.  Most people
>>> just program a script to adjust the volume at startup to cure it.
>>>       
>> Well, this is likely a different problem.  The case of envy24*
>> drivers, the problem is the initialization of the registers via
>> I2C/SPI.  But, in the case of HD-audio, this can't be the case.
>>
>>     
>
> Is this bug still in git alsa? I thought it was already fixed. Which 
> cards does it afflict?
>
> Thanks,
>
> Pavel Hofman.
>   

It is present for my Revolution 5.1 card.
