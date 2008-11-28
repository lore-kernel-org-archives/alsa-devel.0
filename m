From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: simplest volume control possible
Date: Fri, 28 Nov 2008 16:45:12 +0000
Message-ID: <828540C2-D3BB-4057-979A-578089F9F39C@sirena.org.uk>
References: <520f0cf10811280650x195e1dc5lf1239ade86fc7090@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 5G77)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CE6BC1037E3
	for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2008 17:45:08 +0100 (CET)
In-Reply-To: <520f0cf10811280650x195e1dc5lf1239ade86fc7090@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Kacur <jkacur@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 28 Nov 2008, at 14:50, "John Kacur" <jkacur@gmail.com> wrote:

> don't care about power, the thing can be powered on all the time. I
> put a one pulse on a gpio for volume up and a zero pulse on a gpio for
> volume down, 0 - 63 pulses though.
>
> Question, then, what would be an appropriate widget to use?

You don't need to implement DAPM if you don't want/need to. It'd be  
helpful to define noop controls for the DAC and output pins like the  
current TWL4030 driver does but it's not essential.

For your volume control you'll need to write a custom control - all  
the standard ASoC stuff is for chips with registers.
