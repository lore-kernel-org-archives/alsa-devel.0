From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [[PATCH] - hdspm 1/2] Add support for RME
	RayDAT	and AIO
Date: Wed, 26 Jan 2011 19:35:48 +0100
Message-ID: <20110126183548.GF15327@ltw.loris.tv>
References: <1296057510-10047-1-git-send-email-adi@drcomp.erfurt.thur.de>
	<1296057510-10047-2-git-send-email-adi@drcomp.erfurt.thur.de>
	<s5hbp33zkdh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 99E49103A1D
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 19:36:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hbp33zkdh.wl%tiwai@suse.de>
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

On Wed, Jan 26, 2011 at 05:43:06PM +0100, Takashi Iwai wrote:

> >  struct hdspm_version {
> > +	uint8_t card_type; /* enum hdspm_io_type */
> > +	char cardname[20];
> > +	unsigned int serial;
> >  	unsigned short firmware_rev;
> > +	int addons;
> >  };
> >  
> >  #define SNDRV_HDSPM_IOCTL_GET_VERSION _IOR('H', 0x43, struct hdspm_version)
> 
> Changing the existing ioctl isn't so pretty.
> If any, I'd vote for changing the ioctl number.

I chose to change the ioctl number. Luckily, until now, there's no
userspace tool calling this ioctl, but of course, you never know.


> > +static char channel_map_unity_ss[HDSPM_MAX_CHANNELS] = {
> 
> Please don't put static arrays in the public header files.

Dropped the static now.


> Otherwise it looks OK.  It's huge, and maybe there are something to be
> fixed. But We can fix things after merging.

ACK.

>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> Could you rebase your patch to the git tree above?

Done. Hope it applies cleanly now.


Ciao

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver

Don't try to be different. Just be good. To be good is different enough.
        --Arthur Freed
