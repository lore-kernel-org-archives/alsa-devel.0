From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: UCM updates and fixes
Date: Tue, 11 Jan 2011 17:46:52 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101111743420.28150@eeebox2.perex-int.cz>
References: <1292969520-18047-1-git-send-email-lrg@slimlogic.co.uk>
	<1294764191.3338.18.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id F411E24459
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 17:46:52 +0100 (CET)
In-Reply-To: <1294764191.3338.18.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 11 Jan 2011, Liam Girdwood wrote:

> On Tue, 2010-12-21 at 22:11 +0000, Liam Girdwood wrote:
>> Jarolsav,
>>
>> This fixes the remaining issues I can currently see in the alsa-lib
>> ucm branch. It also includes a patch to execute commands, although I
>> dont know if this is what you had in mind for exec.
>>
>> I've also done quite a bit of testing now. What is your merge plan for
>> UCM ? We really need UCM merged soon as there are many users who
>> depend on it.
>>
>
> Have you had a chance to look over this patch series yet ?

Your patches are in my branch. Thank you. I'm actually thinking about more 
inline functions in use-case.h header file like snd_use_case_card_list() to help 
application developers. But I'm having mixed feelings about this right 
now. What do you think?

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
