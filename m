From: Daniel Mack <zonque@gmail.com>
Subject: Re: A plea for help on mixer support for Fast Track
 Ultra (8R)
Date: Fri, 20 May 2011 17:54:15 +0200
Message-ID: <BANLkTikJRO-WGqo+F1P17DJ+-tMhwQpkeA@mail.gmail.com>
References: <4DD3E39D.30100@showlabor.de>
	<BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>
	<4DD413FC.2090808@showlabor.de>
	<BANLkTi=2NeMGL6n7B0n-2p9La=45pM7ZHg@mail.gmail.com>
	<s5hhb8r1c20.wl%tiwai@suse.de> <4DD4BC97.5090702@showlabor.de>
	<s5h39kb17bv.wl%tiwai@suse.de> <4DD4D162.20608@showlabor.de>
	<BANLkTi=6CHJyFxvk9eVA430uhiwJ7f86vA@mail.gmail.com>
	<BANLkTi=OsrZKq3ZmC5cdFfuWb7qSOkPitw@mail.gmail.com>
	<4DD51E38.7090406@showlabor.de>
	<BANLkTiksJbpMr61QOfJ26iVhETDhSBDRFA@mail.gmail.com>
	<4DD63E8F.2030306@showlabor.de> <4DD64D13.9070200@showlabor.de>
	<BANLkTik-_m-Anr2s5=+G7ksyCHdOEGfN2w@mail.gmail.com>
	<BANLkTik9LLnvZRXE=8LW2UOrOOVCjp+kDg@mail.gmail.com>
	<BANLkTimS+VrNTsicpJQ30En7cH68VTFOXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 81F13243FB
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 17:54:16 +0200 (CEST)
Received: by pvf33 with SMTP id 33so2082392pvf.38
	for <alsa-devel@alsa-project.org>; Fri, 20 May 2011 08:54:15 -0700 (PDT)
In-Reply-To: <BANLkTimS+VrNTsicpJQ30En7cH68VTFOXQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

On Fri, May 20, 2011 at 5:43 PM, Grant Diffey <gdiffey@gmail.com> wrote:
> So something is very whacky with the control map. not sure how to debug
> this.
>
> The original patch felix posted works as I expect this one doesn't where
> should I start debugging this?

The first thing would be to define what you refer to with the term "wacky" :)

Does it fail creating the controls? Don't the control do what they're
supposed to? Is the behaviour deterministic?

An easy way to track things in the driver is to add
printk(KERN_WARNING ...); lines in the driver, then compile, unloaded
and load the module again. Then find these lines in your syslog.

Daniel
