From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 00/10] Enable HDA Codec support on Intel
 Platforms (Series2)
Date: Mon, 4 Dec 2017 22:47:52 +0530
Message-ID: <20171204171751.GJ32417@localhost>
References: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hh8tajy3r.wl-tiwai@suse.de>
 <23319967-3571-9e8c-3077-94200bff813f@linux.intel.com>
 <s5ha7z2gqr6.wl-tiwai@suse.de> <20171203172037.GS32417@localhost>
 <780726ad-3587-1f05-89e4-800ad8ce7375@linux.intel.com>
 <20171204032229.GZ32417@localhost>
 <c7fa4232-2ee0-7dd5-14c0-82a5772f931b@linux.intel.com>
 <20171204042157.GC32417@localhost>
 <f88097de-835e-f980-fa3b-6c40b77894fa@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B7D45266BBC
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 18:14:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f88097de-835e-f980-fa3b-6c40b77894fa@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 04, 2017 at 08:52:06AM -0600, Pierre-Louis Bossart wrote:
> On 12/3/17 10:21 PM, Vinod Koul wrote:
> >On Sun, Dec 03, 2017 at 09:44:56PM -0600, Pierre-Louis Bossart wrote:

> >>That gets complicated. you'd have
> >>1. DSP-based ASoC driver for SKL+ w/ DSP
> >>2. coupled-mode ASoC driver for SKL+ w/o DSP
> >>3. legacy for pre-SKL platforms.
> >>
> >>I don't see what simplification this brings, it's complicated enough with 1.
> >>and 3, and legacy is not going away.
> >
> >in long term we _need_ to converge. 1 and 2 should be same driver detecting
> >presence of DSP dynamically and doing DSP based or coupled mode.
> 
> Did we ever enable the coupled mode? if not then it's an hypothetical
> direction...

and prerequisite for that is HDA, so it can be done once this support is
merged!

-- 
~Vinod
