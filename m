From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 7/9] ASoC: amd: modifications in dma stop
	sequence
Date: Fri, 23 Feb 2018 12:39:50 +0530
Message-ID: <405ebbaa-3dc7-675b-bcf6-c3f783722241@amd.com>
References: <1518766434-7911-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1518766434-7911-8-git-send-email-Vijendar.Mukunda@amd.com>
 <20180219165055.GK32761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0061.outbound.protection.outlook.com [104.47.38.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 50AF22671E9
 for <alsa-devel@alsa-project.org>; Fri, 23 Feb 2018 08:08:17 +0100 (CET)
In-Reply-To: <20180219165055.GK32761@sirena.org.uk>
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
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On Monday 19 February 2018 10:20 PM, Mark Brown wrote:
> On Fri, Feb 16, 2018 at 01:03:52PM +0530, Vijendar Mukunda wrote:
>> As per design, non-circular dma also need to be
>> stopped explicitly for both playback and capture
>> scenarios.
>>
>> Added condition checks to stop non-circular dma for
>> both the I2S controller instances.
> Shouldn't this have been going in as a bugfix at the start of the
> series?
This patch also includes changes for BT I2S controller instance.
Either we can split the patch in to two ( one for I2S SP Instance and one for I2S BT Instance) or
we can let go these changes as one patch.
