From: Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 02/14] ALSA: hdac: fix memory release for
 SST and SOF drivers
Date: Thu, 6 Jun 2019 14:57:44 +0200
Message-ID: <20190606145744.4ea389db@xxx>
References: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
 <20190605134556.10322-3-amadeuszx.slawinski@linux.intel.com>
 <190f5c09-e6ae-918e-3fcc-d91a72a895da@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <190f5c09-e6ae-918e-3fcc-d91a72a895da@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 5 Jun 2019 10:06:47 -0500
Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:

> On 6/5/19 8:45 AM, Amadeusz Sławiński wrote:
> > During the integration of HDaudio support, we changed the way in
> > which we get hdev in snd_hdac_ext_bus_device_init() to use one
> > preallocated with devm_kzalloc(), however it still left kfree(hdev)
> > in snd_hdac_ext_bus_device_exit(). It leads to oopses when trying to
> > rmmod and modprobe. Fix it, by just removing kfree call.
> > 
> > SOF also uses some of the snd_hdac_ functions for HDAudio support
> > but allocated the memory with kzalloc. A matching fix is provided
> > separately to align all users of the snd_hdac_ library.  
> 
> There are stability issues with this change (already shared in a 
> separate series) and additional findings reported by Libin so this 
> should not be applied for now.
> 

Yes, as mentioned in cover letter there is pending discussion, I
provided it for completeness.

> > 
> > Fixes: 6298542fa33b ("ALSA: hdac: remove memory allocation from
> > snd_hdac_ext_bus_device_init") Reviewed-by: Takashi Iwai
> > <tiwai@suse.de> Signed-off-by: Amadeusz Sławiński
> > <amadeuszx.slawinski@linux.intel.com> Signed-off-by: Pierre-Louis
> > Bossart <pierre-louis.bossart@linux.intel.com> ---
> >   sound/hda/ext/hdac_ext_bus.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/sound/hda/ext/hdac_ext_bus.c
> > b/sound/hda/ext/hdac_ext_bus.c index c203af71a099..f33ba58b753c
> > 100644 --- a/sound/hda/ext/hdac_ext_bus.c
> > +++ b/sound/hda/ext/hdac_ext_bus.c
> > @@ -170,7 +170,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_init);
> >   void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev)
> >   {
> >   	snd_hdac_device_exit(hdev);
> > -	kfree(hdev);
> >   }
> >   EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_exit);
> >   
> >   
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
