From: Pekka Enberg <penberg@gmail.com>
Subject: Re: Oops in 2.6.10-rc1
Date: Mon, 8 Nov 2004 21:18:09 +0200
Message-ID: <84144f02041108111816dc0b3a@mail.gmail.com>
References: <418D7959.4020206@g-house.de> <20041107130553.M49691@g-house.de>
	 <418E4705.5020001@g-house.de>
	 <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org>
	 <20041107182155.M43317@g-house.de> <418EB3AA.8050203@g-house.de>
	 <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>
	 <418F6E33.8080808@g-house.de>
	 <84144f0204110810444400761f@mail.gmail.com>
	 <20041108190040.GC27386@kroah.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <20041108190040.GC27386@kroah.com>
Sender: linux-sound-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Christian Kujau <evil@g-house.de>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, alsa-devel@lists.sourceforge.net, linux-sound@vger.kernel.org, penberg@cs.helsinki.fi
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, 8 Nov 2004 11:00:40 -0800, Greg KH <greg@kroah.com> wrote:
> But 2.6.10-rc1-bk15 does have the problem?
> 
> Trying to figure out where the issue is...

No, -bk14 is just the kernel I am running right now (I haven't tried
-bk15) and I haven't had the problem. I cannot reproduce the oops _at
all_ which is why I suspect it's his hardware. I included my lspci and
dmesg output because we have similar (but not exactly the same)
setups.

FWIW, I've asked Christian for an obdump of the kernel to see if I can
track down where it oopses at because I cannot find anything in the
code. I suspected pcibios_enable_irq  (which is a function pointer)
might be wrong but looking at his logs, I don't think we get that far.

                          Pekka
