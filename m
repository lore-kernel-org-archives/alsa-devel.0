From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 01/13] ASoC: topology: Able to create BE
	DAIs
Date: Tue, 30 Aug 2016 12:42:06 +0800
Message-ID: <57C50E9E.3080402@linux.intel.com>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
 <390c016a47953561511f529467a1985b77cfd043.1471599648.git.mengdong.lin@linux.intel.com>
 <20160823173354.GZ22076@sirena.org.uk> <57BE92E2.7030807@linux.intel.com>
 <20160828141215.GA3950@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C2F31266468
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 06:36:12 +0200 (CEST)
In-Reply-To: <20160828141215.GA3950@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


Hi Mark,

Here is the info from our audio platform enabling team that answers why 
we need this feature. Please review.

Intel platform supports too many different types of DAIs based on the 
platform variant  e.g. I2S, HDA, DMIC and in future there are few more 
like soundwire in the pipelines.

Using this framework our attempt is to create DAI based on what is 
supported on the platform. If the platform does not support HDA then we 
would like not to create the HDA DAIs. e.g. SKL Chrome topology does not 
use HDA Codec and so there is only I2S and DMIC DAIs.

Based on the SoC pin count limitation not all the interface pins are 
taken out of the SoC to connect various peripherals. So even though 
technically hardware supports many physical interfaces but the platform 
may have limited what can be connected on the platform.

Surely we can create worst case number of DAIs but that would be too much.

Here is the example of SKL/BXT:
6 SSP Ports Rx and Tx, 2 DMIC Ports, 7 Playback DMA channels, 6 Capture 
DMA channels.We are creating topology diagram in text to explain 
different configuration for different use case,like Android, Linux, 
Chrome and Automotive.

Thanks
Mengdong

On 08/28/2016 10:12 PM, Mark Brown wrote:
> On Thu, Aug 25, 2016 at 02:40:34PM +0800, Mengdong Lin wrote:
>
>> In previous design, we had thought that BE DAI and BE DAI links should be
>> created based on ACPI info in BIOS. But unfortunately, the BIOS doesn't have
>> enough physical information, so BE DAI & DAI links are hard coded in
>> platform and machine driver. But when new platforms are coming out with
>> different physical connections, this BIOS gap blocks us from sharing a
>> generic driver across platforms. Now the gap in BIOS ACPI info still exists,
>> the implementations also vary for different generations of platforms, BIOS
>> for public shipped machines cannot change ... So finally we fall back to
>> topology to overcome the BIOS gap and make driver sharing possible. We have
>> tried creating BE DAI & DAI links to new platforms and plan to back port
>> this to upstream drivers for existing platforms like SKL.
>
> I don't understand why we're not able to just enumerate all the possible
> back ends in the driver and then select the required one at runtime
> - even if we do this there's going to be some fairly strict limits on
> the set of back ends that can be added.  Do we have any concrete
> examples here?
>
