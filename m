From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [RFC PATCH] ucm: Add support for device positions
Date: Tue, 3 Jan 2017 18:09:26 +0800
Message-ID: <586B7856.6090005@linux.intel.com>
References: <1483423758-8986-1-git-send-email-mengdong.lin@linux.intel.com>
 <20170103082143.GF3573@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BE3BC266E2E
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 11:06:25 +0100 (CET)
In-Reply-To: <20170103082143.GF3573@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org



On 01/03/2017 04:21 PM, Vinod Koul wrote:
> On Tue, Jan 03, 2017 at 02:09:18PM +0800, mengdong.lin@linux.intel.com wrote:
>> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>>
>> Users can provide prosition info of audio devices as a device value. This
>> will help the sound server to choose an audio devices from some candidates
>> based on the their locations and the status of the machine.
>
> This is good thing to have but some bits are bit unclear to me atm. When you
> say device, do you mean sound card?

No, the device here does not mean a sound card, but mean an I/O device 
like speaker or dmic, defined by 'SectionDevice'.

> For me, position makes sense for dmics and speakers. So can you help me out
> by understanding how we can describe these...
>

For example, if there are two DMICs, one is in the front and one on the 
back, we can define their positions as below:

SectionDevice."MainMIC" {

        ...

         EnableSequence [
                ...
         ]

         DisableSequence [
                 ...
         ]

         Value {
                 Position "Front"
         }
}

SectionDevice."SecondaryMIC" {

	...

	EnableSequence [
	...
	]

	DisableSequence [
	...
	]

	Value {
		Position "Back"
	}
}


Thanks
Mengdong
