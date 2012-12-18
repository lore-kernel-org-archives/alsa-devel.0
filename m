From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 1/1] ALSA: hda - bug fix for invalid
 connection list of more Haswell HDMI codec pins
Date: Tue, 18 Dec 2012 07:36:59 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F829955B@SHSMSX101.ccr.corp.intel.com>
References: <1355854914-13010-1-git-send-email-mengdong.lin@intel.com>
 <s5hip7zq1lq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D4A42615E3
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2012 08:37:13 +0100 (CET)
In-Reply-To: <s5hip7zq1lq.wl%tiwai@suse.de>
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
> Sent: Tuesday, December 18, 2012 3:08 PM
> 
> Mengdong, your previous patch was currently dropped because it's not clear
> whether it's correct.  As asked in the previous thread, the usage of fixup is
> doubtful in this case.
> 
> Is the fix really needed only for a certain PCI (or codec) *SSID*?
> If you need to apply it generically to a certain codec, you have to choose
> another way.

Hi Takashi,

Will OEM change the PCI (or codec) SSID so that this fixup will not be applied at all?

In Haswell, there are two HD-A controllers: one for display codec and the other for legacy 3rd-party codec.
I'm not sure if OEM will change the PCI SSID of the display HD-A controller.

> >
> > +	snd_hda_override_conn_list(codec, 0x05, 3, list);
> > +	hdmi_read_pin_conn(codec, 1);
> > +
> >  	snd_hda_override_conn_list(codec, 0x06, 3, list);
> >  	hdmi_read_pin_conn(codec, 1);
> > +
> > +	snd_hda_override_conn_list(codec, 0x07, 3, list);
> > +	hdmi_read_pin_conn(codec, 1);
> 
> What's the reason to call hdmi_read_pin_conn() multiple times?
Sorry, it's not necessary here.

Thanks
Mengdong
