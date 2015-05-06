From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 1/7] ASoC: hda - add soc hda codec
	driver wrapper
Date: Wed, 6 May 2015 09:17:50 +0530
Message-ID: <20150506034750.GO3521@localhost>
References: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
 <1430250870-3169-2-git-send-email-vinod.koul@intel.com>
 <20150504131226.GV15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A16AC2604CA
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 05:47:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150504131226.GV15510@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 04, 2015 at 02:12:26PM +0100, Mark Brown wrote:
> On Wed, Apr 29, 2015 at 01:24:24AM +0530, Vinod Koul wrote:
> 
> > For ASoC HDA codecs we need to provide match function based on id_table and
> > driver register/unregister wrapper functions
> 
> This changelog doesn't really leave me that much the wiser as to what
> this is intended to do...  what are we matching in what ID table and
> what are we wrapping?
> 
> > ---
> >  sound/soc/Kconfig             |    1 +
> >  sound/soc/Makefile            |    1 +
> >  sound/soc/hda/Kconfig         |    3 ++
> >  sound/soc/hda/Makefile        |    3 ++
> >  sound/soc/hda/soc-hda-codec.c |   85 +++++++++++++++++++++++++++++++++++++++++
> >  sound/soc/hda/soc-hda-codec.h |   44 +++++++++++++++++++++
> >  6 files changed, 137 insertions(+)
> 
> If this is for CODECs why is it in a new directory?
yes it is for HDA codecs which are enumerated over HDA links, but this is
the HDA bus code which is ASoC specfic. All generic HDA code which uses the
hda lib (new sound/hda) is kept in sound/soc/hda
All intel driver updates will go to sound/soc/intel/skylake
The codecs drivers will as usual show up in sound/soc/codecs/

> 
> > +const struct soc_hda_device_id * +snd_soc_hda_get_device_id( +
> > struct hdac_device *hdev, +			struct soc_hda_codec_driver
> > *drv)
> 
> Please can we have more normal indentation - put at least the first
> argument for the function on the same line as the function name.
Yes Takashi also pointed out, fixed now. The zeal to keep under 80 chars
made it look funny.

Thanks
-- 
~Vinod
