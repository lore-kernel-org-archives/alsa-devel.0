From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH V2] ASoC: amd: dma driver changes for BT
 I2S controller instance
Date: Tue, 17 Apr 2018 11:38:01 +0530
Message-ID: <e64456ce-4122-35b4-85cd-d38e1f1f03be@amd.com>
References: <1522355994-32039-1-git-send-email-Vijendar.Mukunda@amd.com>
 <20180416172233.GG20726@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0082.outbound.protection.outlook.com [104.47.32.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 75537266C99
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 08:06:04 +0200 (CEST)
In-Reply-To: <20180416172233.GG20726@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, Akshu Agrawal <akshu.agrawal@amd.com>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org



On Monday 16 April 2018 10:52 PM, Mark Brown wrote:
> On Fri, Mar 30, 2018 at 02:09:54AM +0530, Vijendar Mukunda wrote:
> 
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> v1->v2: fixed kbuild errors
>> ---
> 
> Please put inter-version changelogs after the --- as covered in
> SubmittingPatches.
> 
>> +#ifdef CONFIG_SND_DESIGNWARE_PCM
>> +		adata->i2s_capture_instance = dev->i2s_instance;
>> +#else
>> +		adata->i2s_capture_instance = I2S_SP_INSTANCE;
>> +#endif
> 
> These ifdefs aren't great - we should be able to build a single kernel
> image that works on all systems so if we've got configuration options
> based on the presence of other drivers then presumably existing systems
> are going to be disrupted here.  On the other hand if all systems are
> able to use the Designware driver then we should just do that
> unconditionally.
> 
> This will also break in cases where the Designware driver gets built as
> a module.
> 
I removed Ifdefs and further simplified DMA Driver design.
I had posted fresh series.
