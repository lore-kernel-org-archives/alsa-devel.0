From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: hda - program ICT bits to support
	HBR audio
Date: Tue, 19 Sep 2017 22:07:18 +0530
Message-ID: <20170919163717.GN30097@localhost>
References: <1505833201-22363-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id E1FB62671C3
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 18:33:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1505833201-22363-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Sriram Periyasamy <sriramx.periyasamy@intel.com>, lgirdwood@gmail.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 19, 2017 at 08:30:01PM +0530, Subhransu S. Prusty wrote:
> From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
> 
> On recent Intel platforms (Haswell, Broadwell, Skylake, ApolloLake,
> KabyLake, ...), the IEC Coding Type (ICT) bitfield in the Digital
> Converter Control #3 needs to be set explicitly for HDMI/DisplayPort
> High Bit Rate (HBR) audio playback to work. This was not required in
> earlier platforms when HBR was first introduced. The ICT bits are
> defined in Section 7.3.3.9 of the HDaudio 1.0a specification.
> 
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=98797
> 
> Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
