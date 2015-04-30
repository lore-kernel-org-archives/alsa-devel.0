From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC 6/7] ASoC: hda: Add support for SSP register
 settings
Date: Thu, 30 Apr 2015 10:55:45 -0500
Message-ID: <55425081.3040702@linux.intel.com>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
 <1429390653-8194-7-git-send-email-vinod.koul@intel.com>
 <20150424175532.GD22845@sirena.org.uk> <20150426141831.GS2738@intel.com>
 <20150427141509.GS22845@sirena.org.uk> <55416D07.6060204@linux.intel.com>
 <55416E36.7090208@linux.intel.com> <20150430043941.GK3521@localhost>
 <20150430143642.GX22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B4848264F0A
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 17:56:01 +0200 (CEST)
In-Reply-To: <20150430143642.GX22845@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On 4/30/15 9:36 AM, Mark Brown wrote:
> On Thu, Apr 30, 2015 at 10:09:41AM +0530, Vinod Koul wrote:
>> On Wed, Apr 29, 2015 at 06:50:14PM -0500, Pierre-Louis Bossart wrote:
>
>>>> That said I am not sure how this code would work on SKL. Vinod, isn't
>>>> this for BXT only? how do you get 19.2 on SKL, shouldn't you guys use a
>>>> 24 MHz root frequency to find the divider?
>
>>> And regardless you should make sure that the actual blck does not
>>> exceed the maximum serial bit-rate supported by the SOC (AC timing).
>
>> Yes botha re valid points. But I do rember one of the platforms has 10.2 and
>> another has 25, so we need to be agnostic here and do compare, or use ACPI
>> blobs :)
>
> If this is under the control of the system integrators then I'd suggest
> you're going to see the configuration being used.

It's an SOC/chipset parameter that can't be changed, not sure why it 
would come from ACPI - it's really frozen in silicon. The code can 
remain generic but needs to have an initialization for the root 
frequency that depends on the SOC/chipset.
Rethinking on the bclock check, I withdraw my comment, it's impractical 
since there can be all sorts of 'optimizations' or limitations that 
can't be modeled here in this generic code. This check should be done 
elsewhere with additional platform information.
