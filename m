From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: PC Beep or PC Speaker or just Beep? and HDA Beep
 code...
Date: Tue, 3 Nov 2009 15:55:23 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0911031552000.5500@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.0910221740280.5519@eeebox2.perex-int.cz>
	<s5h1vklythl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id EC02A103839
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 15:55:24 +0100 (CET)
In-Reply-To: <s5h1vklythl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 30 Oct 2009, Takashi Iwai wrote:

>>  	I think that the original purpose of PC Speaker is a beep
>> generator. Also, many SoC platforms use AC97 codecs, so removing
>> abbreviation PC might make sense. It would be probably best to change all
>> control names in drivers to 'Beep'. Comments?
>
> Yes, I agree to rename all to Beep.  The word "PC Speaker" has been
> always confusing.

Patch is here:

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=d2f1919956dbabd17afbc3a236b758f49f6c0658

I only don't know details about MAC (ppc) drivers. The "PC Speaker" 
controls are for beep generator or for full featured build-in internal 
speakers? I would propose to use "Internal Speaker" name for full featured 
outputs.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
