From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: UCM list/set/get
Date: Mon, 31 Jan 2011 23:40:44 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101312334410.6272@eeebox2.perex-int.cz>
References: <AANLkTi=pwNpK-c+h_xSkiQG8V8nhLZs-9X8+DceDw0S3@mail.gmail.com>
	<20110131112257.GC11937@sirena.org.uk>
	<1296482038.3316.160.camel@odin>
	<alpine.LNX.2.00.1101311454510.6272@eeebox2.perex-int.cz>
	<AANLkTinW-H+E_+3Nr+3P65D6vzhBbVSW4zQLVfO58Ckh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 624E62412E
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 23:40:45 +0100 (CET)
In-Reply-To: <AANLkTinW-H+E_+3Nr+3P65D6vzhBbVSW4zQLVfO58Ckh@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: Margarita Olaya <magi@slimlogic.co.uk>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 31 Jan 2011, pl bossart wrote:

>>> cset "name='Master Playback Switch' 1,1"
>>
>> For complete cset command look to 'amixer cset' syntax. You may get list of
>> available identifiers using 'amixer controls'.
>
> Thanks Jaroslav. I had not connected the dots with amixer. Works fine
> now for the defaults. I am still not able to get/set a verb
>
> $ ./alsaucm -c TestHDA get _verb
> sh: my: command not found
> ./alsaucm: error failed to get _verb: No such file or directory

No verb is active here, so the error code is correct. In this state, you 
can just list available verbs or devices and set one. The command to list 
devices for TestHDA case is:

list _devices/Case1

> same for set. Isn't _verb a know identifier in src/ucm/main.c?

This works for me:

ALSA_CONFIG_UCM="$HOME/alsa/alsa-lib/test/ucm" ./alsaucm open TestHDA \
set _verb Case1 get _verb set _enadev Device1.0 list _devices

You may split commands to the interactive mode or you may use a batch file 
and run:

ALSA_CONFIG_UCM="$HOME/alsa/alsa-lib/test/ucm" ./alsaucm -b test.batch

test.batch file contents:

open TestHDA
set _verb Case1
get _verb
set _enadev Device1.0
list _devices

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
