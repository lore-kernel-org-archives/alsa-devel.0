From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How to support software mixing on QUALCOMM
	72XX	without mmap?
Date: Mon, 31 May 2010 10:38:32 +0100
Message-ID: <20100531093832.GA7799@sirena.org.uk>
References: <AANLkTinNq7FzySM5mmW8eEImcdcBUiZ4Z3RZNb359Gd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 07D6F103814
	for <Alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 11:38:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinNq7FzySM5mmW8eEImcdcBUiZ4Z3RZNb359Gd6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Berg <bergtian@gmail.com>
Cc: swetland@google.com, Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, May 30, 2010 at 12:54:17AM +0800, Berg wrote:

>     I'm porting ASLA1.0.23 to qualcomm 72xx base on ARM11.

You might want to coordinate your efforts with the other people working
on Qualcomm chipsets.  I've CCed in Brian Swetland who I know is one
such person but there were a few others.

>     The first instance,"aplay test.wav", works now, but the second
> instance should fail with "device busy" error message.
>     I have tried plug dmix and dshare "aply -D plug:mycard
> test.wav", but met a fail again for the soc chip doesn't support mmap.
> Of course,pcm_mycard is defined in /etc/asound.conf.

I'd generally suggest PulseAudio over dmix for software mixing.

>     My questions are:
>         1)Is  software mixing  implemented in ALSA Driver,or in ALSA LIB?

It's implemented in user space, via an ALSA library plugin.
