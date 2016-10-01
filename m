From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH v2 0/2] support DP MST audio
Date: Sat, 1 Oct 2016 03:43:23 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D194FA320AA@SHSMSX103.ccr.corp.intel.com>
References: <1475115742-146473-1-git-send-email-libin.yang@linux.intel.com>
 <s5hk2dt1kpp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id BA0CE266629
 for <alsa-devel@alsa-project.org>; Sat,  1 Oct 2016 05:43:28 +0200 (CEST)
In-Reply-To: <s5hk2dt1kpp.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, September 30, 2016 11:17 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong <mengdong.lin@intel.com>;
> Yang, Libin <libin.yang@intel.com>
> Subject: Re: [alsa-devel] [RFC PATCH v2 0/2] support DP MST audio
> 
> On Thu, 29 Sep 2016 04:22:20 +0200,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > This patchset starts to support DP MST audio.
> >
> > This patchset is based on drm-intel-nightly on
> > git://anongit.freedesktop.org/drm-intel
> >
> > Libin Yang (2):
> >   ALSA: hda - add DP mst verb support
> >   ALSA: hda - add DP mst audio support
> 
> The codes looks much better now.  Of course we need further brush up in
> some places as well as more documentation, but it's a good step forward.

OK, I will add descriptions in the code and in the file
Documentation/sound/alsa/ HD-Audio-DP-MST-audio.txt

BTW: One of DK's patches is being reverted. This means DP MST audio will
not work now on the drm-intel-nightly branch.

Thanks & Regards,
Libin

> 
> 
> thanks,
> 
> Takashi
