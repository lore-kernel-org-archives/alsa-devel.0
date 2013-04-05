From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Fri, 5 Apr 2013 16:58:54 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8374085@SHSMSX101.ccr.corp.intel.com>
References: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
 <F46914AEC2663F4A9BB62374E5EEF8F8361C9E@SHSMSX101.ccr.corp.intel.com>
 <s5ha9ph8diu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 509012625C4
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 18:59:25 +0200 (CEST)
In-Reply-To: <s5ha9ph8diu.wl%tiwai@suse.de>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, April 02, 2013 5:53 PM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - delay resume haswell hdmi codec
> in system resume
> 
> At Tue, 26 Mar 2013 07:02:54 +0000,
> Lin, Mengdong wrote:
> >
> > Is it okay to add a new parameter to snd_hda_resume(), to indicate whether
> codec resume should be delayed or not?
> > Is because snd_hda_resume() is only only called by azx_resume() but also
> called by azx_bus_reset().
> > The latter can be called on a fatal verb execution failure and codec resume
> delay is not suitable for this case.
> 
> Well, I prefer creating a new function (e.g. snd_hda_bus_reset()) called from
> azx_bus_reset().
> 
> 
> Takashi

Hi Takashi,

Do you mean that in azx_bus_reset(), we can merge the snd_hda_suspend() and snd_hda_resume() to a new function like snd_hda_bus_reset()?
snd_hda_suspend() and snd_hda_resume() look symmetrical here and so I don't want to destroy the symmetry.

static void azx_bus_reset(struct hda_bus *bus)
{
	...
#ifdef CONFIG_PM
	if (chip->initialized) {
		struct azx_pcm *p;
		list_for_each_entry(p, &chip->pcm_list, list)
			snd_pcm_suspend_all(p->pcm);
		snd_hda_suspend(chip->bus);
		snd_hda_resume(chip->bus);
	}
#endif
	bus->in_reset = 0;
}

Thanks
Mengdong
