From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: pointer callback in pcm
Date: Sat, 11 Mar 2006 19:55:57 +0000
Message-ID: <1142106957.9496.45.camel@localhost.localdomain>
References: <1141942882.10937.5.camel@localhost.localdomain>
	 <1141952015.13319.90.camel@mindpipe>
	 <1142020261.9246.3.camel@localhost.localdomain>
	 <4412B17F.7080200@superbug.co.uk>
	 <1142076452.9496.8.camel@localhost.localdomain>
	 <4412F001.5020404@superbug.co.uk>
	 <1142098225.9496.25.camel@localhost.localdomain>
	 <44131B40.9080100@superbug.co.uk>
	 <1142104084.9496.34.camel@localhost.localdomain>
	 <441321E9.1050503@superbug.co.uk>
	 <1142104695.9496.35.camel@localhost.localdomain>
	 <441326EB.8070801@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <441326EB.8070801@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-03-11 at 19:37 +0000, James Courtier-Dutton wrote:
> Adrian McMenamin wrote:
> > On Sat, 2006-03-11 at 19:15 +0000, James Courtier-Dutton wrote:
> >
> >   
> >>>   
> >>>       
> >> Ok, that is not what is needed.
> >> The value returned should be the position of the ADC in the hardware's 
> >> ring buffer in units of frames.
> >> Not the cumulative number of samples played.
> >> E.g. If the buffer is 32768 frames long, the returned value should only 
> >> have a value from 0 to 32767
> >> Once it gets to 32767, it should then role over to 0 again.
> >>
> >>     
> > Yes, that's what I meant :) Sorry if I wasn't clear enough.
> >   
> Which application are you using to test.
> Have you tried "speaker-test"

I cannot get aplay to work so I am just do cat somefile.wav > /dev/dsp

As I couldn't get the ack callback to work I have just rewritten the
interrupt handler as below:

static irqreturn_t aica_period_elapsed(int irq, void *dev_id, struct
pt_regs *regs)
{
	int transferred;
	snd_pcm_runtime_t *runtime;
	if (dev_id != dreamcastcard) return IRQ_NONE;
	/* clear the interrupt on the ARM side */
	spu_memset(0x28BC, 0x20, 4);
	runtime = (((snd_card_aica_t *)dev_id)->substream)->runtime;
	dma_xfer(0, runtime->dma_area + (0x1000 * dreamcastcard->clicks),
0x11000 + (0x1000 * dreamcastcard->clicks), 0x1000, 5);
	do {
		mdelay(1);
		transferred = get_dma_residue(0);
		snd_printk("Transfer reports 0x%X\n", transferred);
	}
	while (transferred < 0x1000);

	snd_pcm_period_elapsed(((snd_card_aica_t *)dev_id)->substream);
	dreamcastcard->clicks++;
	if (dreamcastcard->clicks == 8) dreamcastcard->clicks = 0;
	snd_printk("Clicks is %d\n", dreamcastcard->clicks);	
	return IRQ_HANDLED;
}


which shows the transfers work (the rate is about 12 Mb/s so it's fast)
but still just plays the same stuff over and over in an endless loop :(



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
