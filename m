From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Support for platform bus
Date: Thu, 01 Sep 2005 07:55:45 +0100
Message-ID: <1125557745.3636.5.camel@mayday.localdomain>
References: <1125531756.3348.11.camel@mayday.localdomain>
	 <1125547962.19563.76.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1125547962.19563.76.camel@mindpipe>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-09-01 at 00:12 -0400, Lee Revell wrote:
> On Thu, 2005-09-01 at 00:42 +0100, Adrian McMenamin wrote:
> > I am attempting to write an ALSA driver for the sound card on the
> > Dreamcast.
> 
> Please post your driver source code.
> 
> Lee

Anybody who wants to see all of it can look at
http://newgolddream.dyndns.info/repos but here's the relevant bit
(obviously this is a work in progress so be gentle with me):

static int __init aica_pcm_init(void)
{

	
	int err;
	int idx;
	struct snd_aicapcmchip *chip;
	snd_printk("Probing for AICA device\n");

	
	/* Are we in a Dreamcast at all? */
	if (!mach_is_dreamcast()) return -ENODEV;
	dreamcastcard = NULL;
	/* Can only be one real device on a Dreamcast
	   but we might have the dummy or some other driver loaded */
	for (idx = 0; idx < SNDRV_CARDS; idx++)
	{	
		dreamcastcard = snd_card_new(idx, "AICA", THIS_MODULE, 0);
		if (dreamcastcard) break;
	}
	if (!dreamcastcard) return -ENODEV;
	strcpy(dreamcastcard->shortname, "AICA ");
	strcpy(dreamcastcard->longname, "Dreamcast AICA PCM Sound device ");

	/* Load the PCM 'chip' */
	if ((err = snd_aicapcmchip(dreamcastcard, &chip)) < 0) {
		snd_card_free(dreamcastcard);
		snd_printk("Could not initialise AICA PCM device\n");
		return err;
	}

	/* Set up the ALSA PCM subsystem */


	/* register with sysfs etc - this is not on a 'proper' bus so just use
the generic */
	snd_card_set_dev(dreamcastcard, &platform_bus);

	/* Register the card with ALSA subsystem */
	if ((err = snd_card_register(dreamcastcard)) < 0) {
		snd_card_free(dreamcastcard);
		return err;
	}
	snd_printk("Dreamcast AICA device registered on slot %d\n", idx);



	return 0; 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
