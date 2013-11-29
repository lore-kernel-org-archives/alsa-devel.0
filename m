From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: HD-Audio: can msleep in hda_set_power_state() to
	D3 be optional?
Date: Fri, 29 Nov 2013 02:41:26 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F80141F879@SHSMSX101.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F80141EF7F@SHSMSX101.ccr.corp.intel.com>
 <s5hvbzcd03u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id B8BF82654AA
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 03:41:32 +0100 (CET)
In-Reply-To: <s5hvbzcd03u.wl%tiwai@suse.de>
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
> Sent: Thursday, November 28, 2013 11:20 PM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org
> Subject: Re: HD-Audio: can msleep in hda_set_power_state() to D3 be
> optional?
> 
> At Thu, 28 Nov 2013 15:07:48 +0000,
> Lin, Mengdong wrote:
> >
> > Hi Takashi,
> >
> > In hda_set_power_state(), there is a mandatory sleep up to 100ms
> before setting state to D3.
> >
> > /* this delay seems necessary to avoid click noise at power-down */ if
> > (power_state == AC_PWRST_D3) {
> >                    msleep(codec->epss ? 10 : 100);   ... Could this
> be optional for specific codecs?
> >                    flags = HDA_RW_NO_RESPONSE_FALLBACK; }
> >
> > Some codecs implement their own sleep in patch_ops.suspend() to
> avoid the noise.
> > So is it okay to add a codec flag to decide whether the sleep is necessary
> here?
> 
> Rather add an integer value to indicate the codec delay, e.g.
> codec->d3_delay.  If it's zero, we can take the default delay (10 or 100) as
> of now.

How to set the integer value if a codec doesn't need sleep here? 
To set a very small value or "-1"?

Thanks
Mengdong
