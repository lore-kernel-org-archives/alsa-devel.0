From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 03/11] ALSA: hda - add generic function to
 unregister all devices on bus
Date: Tue, 14 Apr 2015 10:06:59 +0530
Message-ID: <20150414043659.GF2963@intel.com>
References: <1428842178-7105-1-git-send-email-subhransu.s.prusty@intel.com>
 <1428842178-7105-4-git-send-email-subhransu.s.prusty@intel.com>
 <s5hbnisp7kk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AE5512619BF
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 06:42:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hbnisp7kk.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 13, 2015 at 01:54:19PM +0200, Takashi Iwai wrote:
> At Sun, 12 Apr 2015 18:06:10 +0530,
> Subhransu S. Prusty wrote:
> > 
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > This will be used by SKL controller in driver remove
> > to unregister  all hda devices added during probe.
> > 
> > Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  include/sound/hdaudio.h |  2 ++
> >  sound/hda/hdac_bus.c    | 10 ++++++++++
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
> > index b63cd03..247c4a7 100644
> > --- a/include/sound/hdaudio.h
> > +++ b/include/sound/hdaudio.h
> > @@ -268,6 +268,8 @@ void snd_hdac_bus_remove_device(struct hdac_bus *bus,
> >  				struct hdac_device *codec);
> >  int snd_hdac_bus_match_id(struct hdac_device *dev, struct hdac_driver *drv);
> >  
> > +void snd_hdac_bus_device_unregister(struct hdac_bus *bus);
> > +
> >  static inline void snd_hdac_codec_link_up(struct hdac_device *codec)
> >  {
> >  	set_bit(codec->addr, &codec->bus->codec_powered);
> > diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
> > index 4ecb4ec..23b6076 100644
> > --- a/sound/hda/hdac_bus.c
> > +++ b/sound/hda/hdac_bus.c
> > @@ -240,3 +240,13 @@ void snd_hdac_driver_unregister(struct hdac_driver *drv)
> >  	driver_unregister(&drv->driver);
> >  }
> >  EXPORT_SYMBOL_GPL(snd_hdac_driver_unregister);
> > +
> > +void snd_hdac_bus_device_unregister(struct hdac_bus *bus)
> > +{
> > +	struct hdac_device *hdev;
> > +
> > +	/*unregister all devices on bus */
> > +	list_for_each_entry(hdev, &bus->codec_list, list)
> > +				snd_hdac_device_unregister(hdev);
> > +}
> > +EXPORT_SYMBOL_GPL(snd_hdac_bus_device_unregister);
> 
> Again, I don't think we need to keep this in the core code until it's
> really shared among multiple drivers.
Sure, since this was quote generic we kept it in corre, but its fine in asoc
too

-- 
~Vinod
