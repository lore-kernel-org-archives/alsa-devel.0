From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH 1/2] ASoC: AMD: Use single dai for da7219
 playback and capture
Date: Tue, 13 Mar 2018 09:56:51 +0530
Message-ID: <6c6c0820-836f-0672-d5cf-1422657b4a55@amd.com>
References: <1520845883-24062-1-git-send-email-akshu.agrawal@amd.com>
 <20180312170118.GL2186@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0067.outbound.protection.outlook.com [104.47.38.67])
 by alsa0.perex.cz (Postfix) with ESMTP id CF067266F68
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 05:27:14 +0100 (CET)
In-Reply-To: <20180312170118.GL2186@sirena.org.uk>
Content-Language: en-US
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On 3/12/2018 10:31 PM, Mark Brown wrote:
> On Mon, Mar 12, 2018 at 02:41:22PM +0530, Akshu Agrawal wrote:
>> BT I2S is a bi-directional dai, we will use the same
>> cpu dai for playback and capture.
>>
>> TEST=Build, apply grunt_mixer_settings:
>> iotools mmio_write32 0xfed80e40 0x040c40c0
>> iotools mmio_write32 0xfed80e28 0x10000
>> aplay -D hw:0,0 -vv <file>
>> arecord -D hw:0,0 -f dat -d 5 -vv <file>
> 
> These reproduction instructions don't make much sense outside of your
> test environment (how is anyone supposed to know what
> grunt_mixer_settings is?).  I'm also rather worried about the random
> magic numbers you're using with this iowrite tool - what do they do?  It
> sounds like this driver might not work at all without some missing
> bit...
> 
write instructions are actually setting up the oscillator. These are 
being done in coreboot and patch is being pushed for same.
I will remove these noise from TEST field and submit again.
