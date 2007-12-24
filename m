From: "Daniele (Mastro)" <daniele.bilug@gmail.com>
Subject: Re: Notebook Toshiba satellite x200-21g with realtek
 snd-hda-intel audio device still not supported (codec ALC268)
Date: Mon, 24 Dec 2007 21:40:18 +0100
Message-ID: <47701932.9010402@gmail.com>
References: <47672BCB.9080608@gmail.com>	<476912F3.8090609@gmail.com>	
	<476A2BCC.4060109@gmail.com> <s5h1w9h4g5d.wl%tiwai@suse.de>	
	<476B031C.1070304@gmail.com>
	<1198199454.26685.109.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D7AB10383A
	for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2007 19:40:27 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id f40so2061524fka.0
	for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2007 10:40:26 -0800 (PST)
In-Reply-To: <1198199454.26685.109.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tobin Davis ha scritto:
> What I can do, is ask you to download and run
> http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh .

that's the one with model=toshiba (useless)
http://pastebin.ca/831128

> Also, rebuild the modules with "./configure --with-cards=snd-hda-intel
> --with-debug=detect" and load them with "model=auto".  This will leave
> output in dmesg as to what the driver finds in bios.  It's not always
> reliable, but it helps.

done..
i recompiled all the alsa-source with that option (--with-debug=detect)

you can see dmesg here: http://pastebin.ca/831221
and the result of the alsa-info.sh script with this modules/setting
here: http://pastebin.ca/831224

i've added 2 note to the bug (
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3659 )

still i don't know how to use the info from dmesg for fixing my card...
can you help me understanding it?

> As to 5.1 surround, the only way to get 6 channel output would be
> through the SPDIF port, as it acts as a digial passthrough.  If your
> system has a subwoofer, it is very likely tied into the main speaker
> out, just like the 2.1 speakers you can get at most stores.

as you can read into the bug report i think it's NOT  a 5+1 sound card
there are 2 middle frequency speaker, 2 twitter and 1 subwoofer (a total
of 5 speaker)
but probably, as you said, it's a 2.1 or something like this...

anyway it doesn't work as it should

i can recompile the driver with -with-debug=full option if you need it

i didn't compiled only the hda-intel driver.. i recompiled all using
debian way (module assistant + modification to the debian/rules script)

merry Christmas and thanks for your time

-- 
Daniele
