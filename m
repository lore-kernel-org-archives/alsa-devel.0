From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/9] ALSA: Compress - dont use lock for all ioctls
Date: Tue, 27 Aug 2013 15:14:15 +0530
Message-ID: <20130827094415.GU2748@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
 <1377585639-29516-2-git-send-email-vinod.koul@intel.com>
 <s5hk3j7juvs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hk3j7juvs.wl%tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 27, 2013 at 12:22:31PM +0200, Takashi Iwai wrote:
> At Tue, 27 Aug 2013 12:10:31 +0530,
> Vinod Koul wrote:
> > 
> > Some simple ioctls like timsetamp query, capabities query can be done anytime
> > and should not be under the stream lock. Move these to
> > snd_compress_simple_iotcls() which is invoked without lock held
> > 
> > While at it, improve readblity a bit by sprinkling some empty lines
> > 
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > Cc: <stable@vger.kernel.org>
> 
> Why it's needed for stable?  Fixing any real bugs?
yup, users are complaining that while streams are draining they can't read
timstamps. Also one case where a user hit pause didnt go thru as lock preveted
the pause to be executed..

Since 3.10 is next LTS kernel, I forsee lots of folks using taht for a while so
makes sense to fix there as well
 
> > +	default:
> > +		mutex_unlock(&stream->device->lock);
> > +		return snd_compress_simple_ioctls(f, stream, cmd, arg);
> 
> In this code, it still locks/unlocks shortly unnecessarily.
> It should be rather like:
> 	switch (_IOC_NR(cmd)) {
>  	case _IOC_NR(SNDRV_COMPRESS_IOCTL_VERSION):
> 		...
>  	case _IOC_NR(SNDRV_COMPRESS_GET_CAPS):
> 		....	
> 	default:
> 		retval = snd_compress_locked_ioctls(f, stream, cmd, arg);
> 	}
Hmmm, okay no point in blocking. I will reverse the flow

~Vinod

-- 
