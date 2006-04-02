From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: More mixer questions
Date: Sun, 02 Apr 2006 10:39:28 +0100
Message-ID: <1143970769.9564.2.camel@localhost.localdomain>
References: <1143933507.9228.60.camel@localhost.localdomain>
	 <1143947370.6601.17.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id B81F318C
	for <alsa-devel@alsa-project.org>; Sun,  2 Apr 2006 11:39:33 +0200 (MEST)
In-Reply-To: <1143947370.6601.17.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-04-01 at 22:09 -0500, Lee Revell wrote:
> On Sun, 2006-04-02 at 00:18 +0100, Adrian McMenamin wrote:
> > Sorry to hit the list with another question about the mixer/control
> > stuff, but I'm pretty puzzled as to what I am getting wrong.
> > 
> > I am using mpg123 compiled to only hack oss, so I am reliant on oss
> > emulation.
> > 
> > I have the control code attached below, which defines both master and
> > pcm functions (mapped together as the device only plays PCM).
> 
> Where's your __devinit snd_aica_mixer() routine that actually creates
> the mixer controls, with snd_ctl_new1()?

The controls do work though, and they are being created - the code
fragment is below (with lots of printks for debugging)

static int __devinit add_aicamixer_controls()
{
	int err;
	err = snd_ctl_add
	     (dreamcastcard->card,
	      snd_ctl_new1(&snd_aica_pcmvolume_control,
			   dreamcastcard));
	     if (err < 0){
		snd_printk("pcmvolume failed\n");
		return err;
	     }
	    
	    err= snd_ctl_add
	     (dreamcastcard->card,
	      snd_ctl_new1(&snd_aica_pcmswitch_control,
			   dreamcastcard));
	     if (err < 0){
		snd_printk("pcmswitch failed\n");
		return err;
	     }

	    
	    err = snd_ctl_add
	     (dreamcastcard->card,
	      snd_ctl_new1(&snd_aica_mastervolume_control,
			   dreamcastcard));
	     if (err < 0){
		snd_printk("mastervolume failed\n");
		return err;
	     }

	    
	    err = snd_ctl_add
	     (dreamcastcard->card,
	      snd_ctl_new1(&snd_aica_masterswitch_control,
			   dreamcastcard));
	     if (err < 0){
		snd_printk("masterswitch failed\n");
		return err;
	     }

	    
	  
	/* succeeded */
	return 0;
}





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
