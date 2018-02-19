From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH 0/1] Use of shared resource in designware
Date: Mon, 19 Feb 2018 09:26:16 +0530
Message-ID: <bb4dfe21-18f2-f17f-7371-e6a19ddb58bd@amd.com>
References: <1518767009-15232-1-git-send-email-akshu.agrawal@amd.com>
 <20180216114754.GD5886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0078.outbound.protection.outlook.com [104.47.42.78])
 by alsa0.perex.cz (Postfix) with ESMTP id AE1D8266C0E
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 04:56:40 +0100 (CET)
In-Reply-To: <20180216114754.GD5886@sirena.org.uk>
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



On 2/16/2018 5:17 PM, Mark Brown wrote:
> On Fri, Feb 16, 2018 at 01:13:28PM +0530, Akshu Agrawal wrote:
>> This patch will allow the driver to map same registers
>> to multiple instances of driver.
>>
>> It is useful when playback and capture have same regsiters
>> and are required to be present on separate cpu dais.
> 
> Please don't send cover letters for single patches, if there is anything
> that needs saying put it in the changelog of the patch or after the ---
> if it's administrative stuff.  This reduces mail volume and ensures that
> any important information is recorded in the changelog rather than being
> lost.
> 
Got it. The reason for making a cover letter was to let you all know 
that its dependent on "Add devm_ioremap_shared_resource()"
patch. https://patchwork.kernel.org/patch/10177127/
