From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Exposing control of my device
Date: Tue, 29 Jul 2008 10:15:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0807291010350.7676@tm8103-a.perex-int.cz>
References: <9e4733910807281929s10561ec9w3d6c411d742a3b7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id CD39F1038BD
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 10:15:35 +0200 (CEST)
In-Reply-To: <9e4733910807281929s10561ec9w3d6c411d742a3b7d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 28 Jul 2008, Jon Smirl wrote:

> My device has 220 registers, some of these are quite long (32 bytes)
> and I have split them up into multiple 32b pseudo registers.  That
> results in about 300 registers for a TAS5504 and 450 for a TAS5508.
> 
> A large number of these registers are for BiQuads, DRC, loudness, etc.
> They're not general purpose ALSA functions. What is an efficient way
> to expose several hundred registers of this class? Making
> snd_kcontrols for all of them seems pretty inefficient.

Note you can handle up to 128 32-bit words in one snd_kcontrol, so if you 
can group some registers, you can reduce the number of controls.

Another possibility is to use the hwdep device and create own ioctl 
interface to drive your hw. But you'll lose nice things like event 
notifier (unless you implement it in hwdep, too).

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
