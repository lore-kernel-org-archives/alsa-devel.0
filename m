From: Rui Sousa <rui.sousa@laposte.net>
Subject: Re: Questions regarding SB live card (EMU10K1)
Date: Wed, 31 Jul 2002 01:10:36 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207310050560.2748-100000@localhost.localdomain>
References: <006b01c2379a$bfa15db0$223d6a40@dolphin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <006b01c2379a$bfa15db0$223d6a40@dolphin>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Vikram Bartakke <vikram@unm.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 30 Jul 2002, Vikram Bartakke wrote:

> Hello List,
> 
> 
> In EMU10k1, Can anyone please tell me how to do ping pong streaming for
> audiodata for playback without DMA

All audio playback and recording involves DMA. The SBLive, basically, has 
no onboard memory to store audio smaples.

> (ie. CPU controlled). I am also
> confused between wavetable cache memory and onboard mapped memory.

The names you used don't help much, but... All audio samples are in host
memory, the SBLive uses DMA to access them. The "memory" on the card 
itself consists of:

1. 32x32 bits (or close to this, I don't remember exactly) buffer per 
voice, which is used only in playback and to optimize DMA transfers.

2. 2048x32bits DSP memory. This is where the DSP microcode is stored.

3. All other configuration registers.

and that's it.

Rui

> What role does the cache as opposed to the sound memory play?
> 
> I would be really grateful if I could get to know some information about
> this.
> 
> Thanks in advance,
> 
> Regards,
> Vikram S Bartakke
> Grad Student - CS dept
> University of New Mexico
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: Dice - The leading online job board
> for high-tech professionals. Search and apply for tech jobs today!
> http://seeker.dice.com/seeker.epl?rel_code=31
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
