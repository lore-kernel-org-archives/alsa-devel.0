From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: Re: [Openvortex-dev] aplay - How to use device 3
	of card 0 ?
Date: Mon, 07 Mar 2005 09:22:14 -0300
Message-ID: <1110198136.3252.14.camel@localhost>
References: <422C08CD.2000200@netvigator.com>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <422C08CD.2000200@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>, openvortex-dev <openvortex-dev@nongnu.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Raymond,

On Mon, 2005-03-07 at 15:54 +0800, Raymond wrote:
> >> 2) How did you perform your "WT DMA" test ?
> 
> >Using:
> >aplay -d hw:0,1 test.wav
> 
> >The result for me was that aplay did newer finish, because data was
> >never being transfered. After some time it timed out with an error.
> 
> http://savannah.nongnu.org/cgi-bin/viewcvs/openvortex/alsa/pci/au88x0/au88x0_pcm.c.diff?r1=1.9&r2=1.10
> 
> #define VORTEX_PCM_TYPE(x) (x->name[40])
> 
> http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/au88x0/au88x0_pcm.c?rev=1.6&view=markup
> 
> snd_vortex_new_pcm()
> {
> ...
> 	strcpy(pcm->name, vortex_pcm_name[idx]);
> 	chip->pcm[idx] = pcm;
> 	// This is an evil hack, but it saves a lot of duplicated code.
> 	VORTEX_PCM_TYPE(pcm) = idx;
> 	pcm->private_data = chip;
> ...
> }

I'm the author of that ugly thing :) 

> Added debug statement in snd_vortex_pcm_open()
> 
> 
> 	/* Avoid PAGE_SIZE boundary to fall inside of a period. */
> 	if ((err =
> 	     snd_pcm_hw_constraint_pow2(runtime, 0,
> SNDRV_PCM_HW_PARAM_PERIOD_BYTES)) < 0)
> 		return err;
> +	printk(KERN_INFO "vortex_pcm_open()
> %d\n",VORTEX_PCM_TYPE(substream->pcm));
> 
> 	if (VORTEX_PCM_TYPE(substream->pcm) != VORTEX_PCM_WT) {
> 
> 
> Don't know why VORTEX_PCM_TYPE(substream->pcm) is always zero when using
> "aplay -d hw:0,1 test.wav" or "aplay -d hw:0,3 test.wav"

Hmm, if we are lucky, you are the one, who finally found out why the WT
engine does not work. The thing to be done, is to change the mechanism
in which we differentiate between WT and ADB channels. I just used
char[40] of the name string, but thats not a very safe thing. One thing
would be using a intermediate struct for substream->pcm->private_data,
for example:

typedef struct _au_pcm {
  int type;
  chip_t *chip;  /* type is probably wrong here. */
} au_pcm;

Best Regards
-- 
Manuel Jander
Electronic Engineer



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
