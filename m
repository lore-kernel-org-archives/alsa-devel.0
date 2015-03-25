From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC v2 1/3] ALSA: hda: add HDA_MAX_CODECS
Date: Wed, 25 Mar 2015 13:21:33 +0530
Message-ID: <20150325075133.GF32683@intel.com>
References: <1427263299-14707-1-git-send-email-vinod.koul@intel.com>
 <1427263299-14707-2-git-send-email-vinod.koul@intel.com>
 <s5hegodh8s3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 60874264EFA
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 08:55:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hegodh8s3.wl-tiwai@suse.de>
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
Cc: jeeja.kp@intel.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 25, 2015 at 07:48:44AM +0100, Takashi Iwai wrote:
> At Wed, 25 Mar 2015 11:31:37 +0530,
> Vinod Koul wrote:
> > 
> > This moves AZX_MAX_CODECS define to HDA_MAX_CODECS so that common code can
> > use this as well
> 
> Well, HDA_MAX_CODECS = 8 isn't about the codec specification, but
> rather a limitation of the current standard HD-audio controller h/w.
> The spec itself limits to 16 (= 0x0f).
> 
> So, I don't want to mix this into hda_verbs.h that is the place
> defining the specification.  It's fine to move to hdaudio.h instead,
> though.
Sure I will move it there...

-- 
~Vinod
