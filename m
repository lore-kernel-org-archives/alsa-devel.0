From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/6] ASoC: Intel: Add support for
 Haswell/Broadwell DSP
Date: Fri, 21 Feb 2014 15:05:56 +0200
Message-ID: <53074F34.9090301@linux.intel.com>
References: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140221050121.GA25940@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 87676265898
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2014 14:06:11 +0100 (CET)
In-Reply-To: <20140221050121.GA25940@sirena.org.uk>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

On 02/21/2014 07:01 AM, Mark Brown wrote:
> On Thu, Feb 20, 2014 at 09:48:42PM +0000, Liam Girdwood wrote:
>> Add support for low level differentiation functions for Haswell and Broadwell
>> SST DSPs. This includes suppoprt for DSP boot and reset, DSP firmware module
>> parsing and DSP memory block map initialisation.
> Applied, thanks.  Some terribly minor things below:
This patch appears to be missing from the tree. Can actually create a 
build error after commits
5207ab6b614e ("ASoC: Intel: Add build support for Haswell ADSP") and 
6edbf73e03fd ("ASoC: Intel: Add Haswell Machine support").

-- 
Jarkko
