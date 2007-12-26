From: "Daniele (Mastro)" <daniele.bilug@gmail.com>
Subject: Re: Notebook Toshiba satellite x200-21g with realtek
 snd-hda-intel audio device still not supported (codec ALC268)
Date: Wed, 26 Dec 2007 17:08:12 +0100
Message-ID: <47727C6C.6080401@gmail.com>
References: <47672BCB.9080608@gmail.com>	<476912F3.8090609@gmail.com>	<476A2BCC.4060109@gmail.com>
	<s5h1w9h4g5d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by alsa0.perex.cz (Postfix) with ESMTP id A59C5103889
	for <alsa-devel@alsa-project.org>; Wed, 26 Dec 2007 17:08:17 +0100 (CET)
Received: by mu-out-0910.google.com with SMTP id i10so1775850mue.3
	for <alsa-devel@alsa-project.org>; Wed, 26 Dec 2007 08:08:16 -0800 (PST)
In-Reply-To: <s5h1w9h4g5d.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai ha scritto:
> I recommend you to hack the driver code by yourself.
> The coding itself isn't too difficult.  The problem is the guess work,
> which PIN really corresponds to which I/O, and what control is missing
> (EAPD, GPIO, etc).

hum..
i guess the file i should edit is patch_realtek.c
but i really have no idea on what to change/add and how to understand
what i have to change...

in my other message there are the debug info you requested and i don't
know how to use them

i'm really want to do something to help you but i keep reading the code
without knowing what to do or understanding it very much... i never
developed kernel drivers and I've no idea on what to do

I'm putting here my good will but think i miss the knowledge to do what
you suggested and i don't know where to achieve it either

> What I'm wondering is how to support 5.1 output.  The ALC268 codec is
> at most for 4 channels (2 + 2).  Are you sure that you can get 5.1
> distinct outputs?

probably this isn't a 5.1 as i said in the other message

thanks for any reply you will give me
i'm sorry i'm so annoying

-- 
Daniele
