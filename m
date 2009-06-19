From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: RFC: PCM extra attributes
Date: Fri, 19 Jun 2009 10:47:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906191031001.3983@eeebox2.perex-int.cz>
References: <s5hiqiseiwj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D412103894
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 10:47:32 +0200 (CEST)
In-Reply-To: <s5hiqiseiwj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Jun 2009, Takashi Iwai wrote:

> Hi,
>
> this is yet another topic I'm (currently) working on -- the addition
> of PCM ioctls to get/set some extra attributes.  Basically, it adds
> two simple ioctls for getting/setting extra attributes to the PCM
> substream.  The attribute has a sort of TLV form,
>
>  /* PCM extra attributes */
>  struct snd_pcm_attr {
>  	unsigned int type;	/* SNDRC_PCM_TYPE_ATTR_XXX */
>  	unsigned int len;	/* GET R: the max elements in value array
>  				 *     W: the actually written # elements
>  				 * SET R/W: # elements to store
>  				 */
>  	unsigned int value[0];	/* value(s) to read / write */
>  };
>
> And corresponding two ioctls
>  #define SNDRV_PCM_IOCTL_GET_ATTR	_IOWR('A', 0x14, struct snd_pcm_attr)
>  #define SNDRV_PCM_IOCTL_SET_ATTR	_IOWR('A', 0x15, struct snd_pcm_attr)

I would prefer to implement similar TLV implementation as for the control 
API. The amount of information for reading (get) will be small, so 
filtering in this direction is not necessary. Also, common parts of 
implementation (future merging of more TLVs to compounds) can be shared.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
