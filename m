From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 1/6] ASoC: Intel: Add support for
 Haswell/Broadwell DSP
Date: Mon, 24 Feb 2014 20:09:52 +0000
Message-ID: <1393272592.2323.74.camel@loki>
References: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140221050121.GA25940@sirena.org.uk> <53074F34.9090301@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B15E26550D
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 21:10:56 +0100 (CET)
In-Reply-To: <53074F34.9090301@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-02-21 at 15:05 +0200, Jarkko Nikula wrote:
> Hi
> 
> On 02/21/2014 07:01 AM, Mark Brown wrote:
> > On Thu, Feb 20, 2014 at 09:48:42PM +0000, Liam Girdwood wrote:
> >> Add support for low level differentiation functions for Haswell and Broadwell
> >> SST DSPs. This includes suppoprt for DSP boot and reset, DSP firmware module
> >> parsing and DSP memory block map initialisation.
> > Applied, thanks.  Some terribly minor things below:
> This patch appears to be missing from the tree. Can actually create a 
> build error after commits
> 5207ab6b614e ("ASoC: Intel: Add build support for Haswell ADSP") and 
> 6edbf73e03fd ("ASoC: Intel: Add Haswell Machine support").
> 

Just did a remote update and I can see it now :)

Liam
