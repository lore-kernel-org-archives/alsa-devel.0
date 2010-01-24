From: Brendan Pike <spike@spykes.net>
Subject: Re: How much of the X-Fi (emu20k1) chip has Creative
 documented?
Date: Sun, 24 Jan 2010 09:26:55 -0500
Message-ID: <20100124092655.18d6a92c@darius>
References: <20100123174104.5dbac1a3@darius>
	<880778.92550.qm@web52906.mail.re2.yahoo.com>
	<s5h7hr7bxvm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.spykes.net (dsl.spykes.net [76.10.173.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C698103820
	for <alsa-devel@alsa-project.org>; Sun, 24 Jan 2010 15:26:58 +0100 (CET)
In-Reply-To: <s5h7hr7bxvm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 24 Jan 2010 11:28:13 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 23 Jan 2010 14:46:37 -0800 (PST),
> Chris Rankin wrote:
> > 
> > --- On Sat, 23/1/10, Brendan Pike <spike@spykes.net> wrote:
> > > I'm 100% sure that HwMix is supported. When I said direct
> > > hardware access I meant it. I'm sure anyone else with an XFi card
> > > can confirm this too.
> > 
> > That's just it - someone on Phoronix is saying that it isn't supported:
> > http://www.phoronix.com/forums/showthread.php?t=21486
> > 
> > "Just as a FYI multi voice hardware mixing is not present in the linux x-fi drivers."
> > 
> > That post is dated 17th Jan 2010.
> 
> It's a wrong information.
> 
> 
> Takashi

X-Fi is such a generic term these days with Creative.
There are non emu20k1/2 based X-Fi's that do NOT support HWMix.
The Phoronix post was probably referring to those cards and thinking
it applies to all of them as a result.

Just a peek in the source code would show you that the hardware SRC is
supported.
