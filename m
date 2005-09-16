From: Manuel Jander <manuel.jander@gmail.com>
Subject: Re: Re: au88x0 modem
Date: Fri, 16 Sep 2005 23:34:41 +0200
Message-ID: <1126906481.12111.7.camel@localhost.localdomain>
References: <4325AEA3.1090602@netvigator.com> <20050913000909.GB19713@tecr>
	 <20050913085552.GA2655@titan.lahn.de>
	 <20050913173529.GD31269@sashak.softier1.local>
	 <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com>
	 <20050914205608.GD14657@sashak.softier1.local>
	 <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de>
	 <20050915143533.GB23218@sashak.softier1.local>
	 <20050915204345.GC27700@sashak.softier1.local>
	 <432AD226.6010706@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <432AD226.6010706@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

> The easy way is to create a PCM device "modem" on au8810
> 
> 
> DMA -> FIFO -> SRC -> MIXIN --------> MIXOUT -> MC97(Modem Out)
>                          |
> 		        +-----------> MIXOUT -> EQ -> AC97(Audio Left)
> 
>     				Modem Speaker  On or Off
> 
>                                    +-> MIXOUT -> EQ -> AC97(Audio Right)
>                                    |
> DMA <- FIFO <- SRC <- MIXOUT <- MIXIN <-------- MC97(Modem IN)
> 
> 
> or
> 
> 
> DMA -> FIFO -> SRC -> MC97(modem) (Playback)
> 
> DMA <- FIFO <- SRC <- MC97(modem) (Capture)
> 

Remove the samplerate converter, it does not make any sense on a modem.
You will only loose signal precision with the samplerate converter
anyway, and there are very few of them. 
A direct route from the fifo to the modem codec will do it and the modem
signal device will run at the codec native samplerate without any
precision loss.

> 
> What is the difference between modem application and audio application ?

Nothing. The only modem extra functionality is the ability to switch the
modem line off/on hook. It just sends and captures QAM modulated
signals.

> Do the modem application open two PCM streams (one for playback and the 
> other for capture )?

Yes, it should be full duplex. This will require 2 DMA's.

> Where is the class SND_PCM_CLASS_MODEM specificed in the driver ?

At least i did not.

Best Regards,
Manuel Jander




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
