From: Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2 1/3] Revert "ASoC: Intel: Skylake: Acquire irq after
 RIRB allocation"
Date: Wed, 12 Sep 2018 13:32:21 -0600
Message-ID: <20180912193221.GA194302@google.com>
References: <20180910211718.200802-1-yuzhao@google.com>
 <20180911211246.31914-1-yuzhao@google.com>
 <20180912102020.GB6062@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180912102020.GB6062@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Naveen Manohar <naveen.m@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 12, 2018 at 11:20:20AM +0100, Mark Brown wrote:
> On Tue, Sep 11, 2018 at 03:12:46PM -0600, Yu Zhao wrote:
> > This reverts commit 12eeeb4f4733bbc4481d01df35933fc15beb8b19.
> > 
> > The patch doesn't fix accessing memory with null pointer in
> > skl_interrupt().
> 
> Please use normal subject lines and so on even for revert patches -
> they're patches just the same as any other.

Well, they seem pretty normal to me, and have been used by many:

  commit 82ab86e82911107ead6fc7cd73568f75bc266a57
  Author: Mark Brown <broonie@kernel.org>
  Date:   Mon Oct 30 19:40:25 2017 +0000
  
      Revert "ASoC: rt5651: Enable jack detection on JD* pins"
      
      This reverts commit 60d5a1a47b9a8381c08d2263b11ac9c757c87746.
      
      Signed-off-by: Mark Brown <broonie@kernel.org>

Anyway, I'll update them in v3.
