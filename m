From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [Alsa-user] ALSA Newbie - Getting Ensoniq
 SoundscapeVivo to work? [Solved]
Date: Mon, 30 Apr 2007 00:04:20 +0200
Message-ID: <46351664.2010509@gmail.com>
References: <d382e1990704291418x20550cc7l17239562227f2a61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <d382e1990704291418x20550cc7l17239562227f2a61@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cody Jung <funkycat32@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, ALSA user <alsa-user@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/29/2007 11:18 PM, Cody Jung wrote:

> Instead I added the following 4 lines to a file and included it in my
> init scripts.
> 
> echo activate > /sys/bus/pnp/devices/01\:01.00/resources
> sleep 1
> modprobe snd
> modprobe snd-cs4231 port=0x534 irq=5 dma1=1 dma2=0

Sure, that'll do as well. Bit strange that (/if) you need to "modprobe snd" 
seperately; "modprobe snd-cs4231" should pull it in automatically, but not 
important.

Do note that if you change the machine's hardware configuration the VIVOs 
resources migth change again. If you for example put another card on IRQ9, 
the PnP layer won't be able to use the VIVOs preferred options, and will 
configure it on irq 7 instead of 5. Checking the resources in the /sys tree 
after activating as I showed will work...

> And it works great!
> 
> Thanks again for putting up with my incompetence.

Not so much incompetence; just the misfortune that your card isn't (really) 
supported by ALSA. That's the kind of thing that immediately gets you deep 
into the bowels of a Linux system. Glad I could at least help and as said, 
some future verson of ALSA will probably grow a real/better driver for the card.

Rene.
