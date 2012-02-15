From: Jean-Yves Avenard <jyavenard@gmail.com>
Subject: Re: 1ca3d59d5a3e762fb1c002bcd912914bc858b430 broke
 passthrough [Was: Re: ALSA 1.0.25 broke AC3 passthrough?]
Date: Wed, 15 Feb 2012 21:34:45 +1100
Message-ID: <CANpj82LR6ZDuFS0FNESuT3WUbQvan5ENq-XghaTXs=bRFUO9Kw@mail.gmail.com>
References: <CANpj82JKFx1YXgaY3HZyTSyCZs83ZdvEtYGAbNJPdb6q7qN7kg@mail.gmail.com>
	<4F37BBDD.1090207@iki.fi>
	<CANpj82J+MmYNGbOqmFMCA587sCiUZfjRqDfesfmOG616478SqQ@mail.gmail.com>
	<s5h39ae3lhk.wl%tiwai@suse.de>
	<CANpj82Ktb8BZiOA50HuR5r0n6NpHk+Y5Bt0uU+mk=01q4VdAPg@mail.gmail.com>
	<4F3B2D6D.20400@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1735C103954
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 11:34:46 +0100 (CET)
Received: by yhr47 with SMTP id 47so515959yhr.38
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 02:34:46 -0800 (PST)
In-Reply-To: <4F3B2D6D.20400@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

On 15 February 2012 14:58, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> This is surprising, the hardware folks at Intel confirmed the rounding
> to multiple of 128 bytes is not needed and this patch has been there for
> over 6 months now without generating any complaints. Can you get us more
> information on that case, and ask this user to see what happens by
> enabling this rounding again.

Seeing that 1.0.25 broke it for any nvidia user and not many people
have complained yet, my guess is that it's not much in use yet.

The default ALSA prealloc size is 64, with that value, the problem
isn't seen much.

Following the recommendation of the pulseaudio folks, he set the value
to 2048, with this value the user reported that it failed with mythtv.

I have asked him more details about his configuration... I'm hoping to
be able to pass that information on soon

I will also ask him if he can patch it to disable the rounding and if
that makes any differences to him.

Thanks
Jean-Yves
