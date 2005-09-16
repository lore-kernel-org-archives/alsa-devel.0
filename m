From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0 modem
Date: Fri, 16 Sep 2005 22:09:42 +0800
Message-ID: <432AD226.6010706@netvigator.com>
References: <4325AEA3.1090602@netvigator.com> <20050913000909.GB19713@tecr> <20050913085552.GA2655@titan.lahn.de> <20050913173529.GD31269@sashak.softier1.local> <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com> <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <20050915204345.GC27700@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050915204345.GC27700@sashak.softier1.local>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sasha Khapyorsky <sashak@smlink.com>
Cc: openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sasha Khapyorsky wrote:
> On 17:35 Thu 15 Sep     , Sasha Khapyorsky wrote:
> 

> 
> 3. DMA
> 
> After some looking in au88x0 driver I think that it is possible that
> modem could use one ADB channels (predefined or programmable) for pcm
> data transfers (just like regular audio), similar scheme may be found
> with some other devices like ali5451.
> 
> If so we could try to find channel numbers (should be two - for playback
> and capture). It is very possible that channels should be configured
> somehow first.
> 
> Philipp, How looks your 'aplay -l' output?
> 
> 
> ANYBODY knows something about modem DMA/PCM with au88x0, please advise.
> 
>


The easy way is to create a PCM device "modem" on au8810


DMA -> FIFO -> SRC -> MIXIN --------> MIXOUT -> MC97(Modem Out)
                         |
		        +-----------> MIXOUT -> EQ -> AC97(Audio Left)

    				Modem Speaker  On or Off

                                   +-> MIXOUT -> EQ -> AC97(Audio Right)
                                   |
DMA <- FIFO <- SRC <- MIXOUT <- MIXIN <-------- MC97(Modem IN)


or


DMA -> FIFO -> SRC -> MC97(modem) (Playback)

DMA <- FIFO <- SRC <- MC97(modem) (Capture)



What is the difference between modem application and audio application ?

Do the modem application open two PCM streams (one for playback and the 
other for capture )?

Where is the class SND_PCM_CLASS_MODEM specificed in the driver ?






-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
