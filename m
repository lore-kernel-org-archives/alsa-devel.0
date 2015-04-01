From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda_intel:
	add	AZX_DCAPS_I915_POWERWELL for skl
Date: Wed, 1 Apr 2015 08:00:41 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19633E41@SHSMSX103.ccr.corp.intel.com>
References: <1427440204-49331-1-git-send-email-libin.yang@intel.com>
 <s5hfv8q98lm.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19622F1C@SHSMSX103.ccr.corp.intel.com>
 <s5hegoa97jj.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19622F67@SHSMSX103.ccr.corp.intel.com>
 <s5ha8yy971s.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19622F84@SHSMSX103.ccr.corp.intel.com>
 <96A12704CE18D347B625EE2D4A099D1962E18F@SHSMSX103.ccr.corp.intel.com>
 <551B9EC0.2060308@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BE0C9260504
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 10:00:46 +0200 (CEST)
In-Reply-To: <551B9EC0.2060308@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>, 'Takashi Iwai' <tiwai@suse.de>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi David,

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> bounces@alsa-project.org] On Behalf Of David Henningsson
> Sent: Wednesday, April 01, 2015 3:31 PM
> To: Yang, Libin; 'Takashi Iwai'
> Cc: 'alsa-devel@alsa-project.org'
> Subject: Re: [alsa-devel] [PATCH] ALSA: hda_intel: add
> AZX_DCAPS_I915_POWERWELL for skl
> 
> 
> 
> On 2015-03-30 04:47, Yang, Libin wrote:
> >  From our silicon team's comment, it seems we need power on
> > the powerwell when detecting and probing the HDMI codec.
> >
> > For the skl case (HDMI codec is in powerwell, while controller not),
> > my thinking is:
> >
> > 1. power on the power well
> > 2. read STATESTS to determine the codec_mask
> > 3. if codec is not present, power off the power well
> >      and remove the flag. (seems we need a new flag)
> > 4. if codec is present, we will power on the power well
> >      when dealing with HDMI codec.
> >
> > What do you think?
> 
> Side question - do you know if it's the same for braswell? I e, the HDMI
> codec is in the powerwell but the controller is not?

Yes, BSW has the same issue.

At first, my thinking is:
1. define a new flag, power on the power well if flag is set
2. read STATESTS to determine the codec_mask
3. if codec is not present, power off the power well
    and remove the flag.
4. after initialization, power off the power well if new flag
    is set and AZX_DCAPS_I915_POWERWELL is not set
5. power on power well when pcm open
6. power off the power well when pcm close

After a second thought, the method may have limitation:
the codec may send the unsolicited responses. 

So my currently thinking is:
If the codec is in powerwell, the behavior is like the flag
AZX_DCAPS_I915_POWERWELL: always power on unless
suspend. 
This method may cause power consumption. But consider
normally audio will be in suspend state in most case.

> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
