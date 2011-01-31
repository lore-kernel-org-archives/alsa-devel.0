From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: UCM list/set/get
Date: Mon, 31 Jan 2011 15:57:48 -0600
Message-ID: <AANLkTinW-H+E_+3Nr+3P65D6vzhBbVSW4zQLVfO58Ckh@mail.gmail.com>
References: <AANLkTi=pwNpK-c+h_xSkiQG8V8nhLZs-9X8+DceDw0S3@mail.gmail.com>
	<20110131112257.GC11937@sirena.org.uk>
	<1296482038.3316.160.camel@odin>
	<alpine.LNX.2.00.1101311454510.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BAD891037EA
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 22:57:51 +0100 (CET)
Received: by iye19 with SMTP id 19so5941153iye.38
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 13:57:48 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1101311454510.6272@eeebox2.perex-int.cz>
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
Cc: Margarita Olaya <magi@slimlogic.co.uk>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

>> cset "name='Master Playback Switch' 1,1"
>
> For complete cset command look to 'amixer cset' syntax. You may get list of
> available identifiers using 'amixer controls'.

Thanks Jaroslav. I had not connected the dots with amixer. Works fine
now for the defaults. I am still not able to get/set a verb

$ ./alsaucm -c TestHDA get _verb
sh: my: command not found
./alsaucm: error failed to get _verb: No such file or directory

same for set. Isn't _verb a know identifier in src/ucm/main.c?

Thanks,
-Pierre
