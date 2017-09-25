From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v2] ALSA: hda - program ICT bits to support
 HBR audio
Date: Mon, 25 Sep 2017 20:26:53 +0530
Message-ID: <20170925145649.GA5063@subhransu-desktop>
References: <20170919222505.28654-1-pierre-louis.bossart@linux.intel.com>
 <s5h60cdelkx.wl-tiwai@suse.de>
 <8af5af38-f220-f58a-e7be-4e25dfff452a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 145B6266ECE
 for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2017 18:22:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8af5af38-f220-f58a-e7be-4e25dfff452a@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 20, 2017 at 08:12:36AM -0500, Pierre-Louis Bossart wrote:
> On 9/20/17 5:00 AM, Takashi Iwai wrote:
> >On Wed, 20 Sep 2017 00:25:05 +0200,
> >Pierre-Louis Bossart wrote:
> >>
> >>From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
> >>
> >>On recent Intel platforms (Haswell, Broadwell, Skylake, ApolloLake,
> >>KabyLake, ...), the IEC Coding Type (ICT) bitfield in the Digital
> >>Converter Control #3 needs to be set explicitly for HDMI/DisplayPort
> >>High Bit Rate (HBR) audio playback to work. This was not required in
> >>earlier platforms when HBR was first introduced. The ICT bits are
> >>defined in Section 7.3.3.9 of the HDaudio 1.0a specification.
> >>
> >>Since the ICT bitfield was not specified for HDAudio 1.0 devices
> >>(before 2009), we only program it on machines more recent than
> >>Haswell.
> >>
> >>We tested that this fix is not needed on Baytrail-I (MinnowBoard
> >>Turbot) and believe by extension it also does not apply to Braswell.
> >>
> >>Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=98797
> >>
> >>Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
> >>Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >>Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> >>---
> >>v2: move digi3 verb in Set section, only set ICT for haswell and newer
> >
> >Applied now with a slight fix (moving *_SET_* definition to the right
> >place).
> 
> Thanks Takashi. Not sure what happened since I have a clear memory
> of doing that change and making a note of it...

Hi Takashi,

I think this patch should have also gone to stable. We didn't cc. Please
suggest whether we should submit it separately for stable.

Regards,
Subhransu

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
