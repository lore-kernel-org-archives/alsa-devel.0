From: Daniel Mack <zonque@gmail.com>
Subject: Re: A plea for help on mixer support for Fast Track
 Ultra (8R)
Date: Thu, 19 May 2011 10:52:05 +0200
Message-ID: <BANLkTi=6CHJyFxvk9eVA430uhiwJ7f86vA@mail.gmail.com>
References: <4DD3E39D.30100@showlabor.de>
	<BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>
	<4DD413FC.2090808@showlabor.de>
	<BANLkTi=2NeMGL6n7B0n-2p9La=45pM7ZHg@mail.gmail.com>
	<s5hhb8r1c20.wl%tiwai@suse.de> <4DD4BC97.5090702@showlabor.de>
	<s5h39kb17bv.wl%tiwai@suse.de> <4DD4D162.20608@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D9AAE10397D
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 10:52:11 +0200 (CEST)
Received: by pzk26 with SMTP id 26so1312391pzk.38
	for <alsa-devel@alsa-project.org>; Thu, 19 May 2011 01:52:06 -0700 (PDT)
In-Reply-To: <4DD4D162.20608@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 19, 2011 at 10:14 AM, Felix Homann <linuxaudio@showlabor.de> wrote:
> Please, Clemens, Daniel and Takashi.
>
> Every single one of you knows at least one way of doing it correctly. I
> don't.
>
> I don't understand most of your suggestions, I don't understand the whole
> quirk framework. I'm just a layman who knows one way of making the FTU mixer
> work which would break others (just by calling snd_usb_create_mixer() too
> many times).
>
> The "blueprint patch" I've send is very small. It's just three functions,
> one of them is very simple the others are almost identical to already
> present functions.
>
> So please, couldn't someone fill the gap between what I have found and a
> proper implementation? As I see it, you might easily spend the same amount
> of time explaining to me how it should be done or why my next proposed patch
> (which would probably take at least a couple of weeks) is not acceptable and
> so on. But this would probably run for weeks or even months.

I'll have a look later. I was just under the impression you wanted to
try yourself :)

Daniel
