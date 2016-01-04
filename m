From: Geliang Tang <geliangtang@163.com>
Subject: Re: [PATCH 2/4] ALSA: hdac: drop unused dev_to_hdac
	macro
Date: Mon, 4 Jan 2016 22:54:22 +0800
Message-ID: <20160104145421.GA16267@bogon>
References: <00c81b79d57196a8a72ce9c4a0e8ca5d3ec2eba7.1451312334.git.geliangtang@163.com>
 <b86ede48c70d4f57bb72d52045e4f2afe12a88ae.1451312334.git.geliangtang@163.com>
 <20160104082347.GG2940@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m50-134.163.com (m50-134.163.com [123.125.50.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 828682604DF
 for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2016 15:54:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160104082347.GG2940@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 04, 2016 at 01:53:47PM +0530, Vinod Koul wrote:
> On Mon, Dec 28, 2015 at 10:47:11PM +0800, Geliang Tang wrote:
> > dev_to_hdac is not used anymore so drop it.
> 
> No harm in keeping this for now as the systems using these will be coming
> up and more users will be upstreamed...
> 

Thanks for your review. Sorry that I didn't make myself clear in the commit
log. What I droped is a repetitive macro. dev_to_hdac() in hdac_ext_bus.c 
and dev_to_hdac_dev() in hdaudio.h are the same:

 include/sound/hdaudio.h:
 #define dev_to_hdac_dev(_dev)   container_of(_dev, struct hdac_device, dev)

 sound/hda/ext/hdac_ext_bus.c:
 #define dev_to_hdac(dev) (container_of((dev), \
                         struct hdac_device, dev))

Users should use dev_to_hdac_dev() in hdaudio.h, not dev_to_hdac().

 -Geliang

> > 
> > Signed-off-by: Geliang Tang <geliangtang@163.com>
> > ---
> >  sound/hda/ext/hdac_ext_bus.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
> > index 2433f7c..58f6b98 100644
> > --- a/sound/hda/ext/hdac_ext_bus.c
> > +++ b/sound/hda/ext/hdac_ext_bus.c
> > @@ -197,8 +197,6 @@ void snd_hdac_ext_bus_device_remove(struct hdac_ext_bus *ebus)
> >  	}
> >  }
> >  EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_remove);
> > -#define dev_to_hdac(dev) (container_of((dev), \
> > -			struct hdac_device, dev))
> >  
> >  static inline struct hdac_ext_driver *get_edrv(struct device *dev)
> >  {
> > -- 
> > 2.5.0
