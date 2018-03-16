From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 1/7] ASoC: amd: dma driver changes for BT
 I2S controller instance
Date: Fri, 16 Mar 2018 18:46:23 +0530
Message-ID: <4c1d57bc-5165-9217-0331-d51110c6c7e8@amd.com>
References: <1520836460-21809-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1520836460-21809-2-git-send-email-Vijendar.Mukunda@amd.com>
 <20180312182537.GO2186@sirena.org.uk>
 <284973fb-bcc9-19b9-2692-966e40129430@amd.com>
 <20180314162424.GU2186@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0055.outbound.protection.outlook.com [104.47.42.55])
 by alsa0.perex.cz (Postfix) with ESMTP id CD1E42674CE
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 14:14:28 +0100 (CET)
In-Reply-To: <20180314162424.GU2186@sirena.org.uk>
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



On Wednesday 14 March 2018 09:54 PM, Mark Brown wrote:
> On Wed, Mar 14, 2018 at 04:06:15PM +0530, Mukunda,Vijendar wrote:
>
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.
>
>> On Monday 12 March 2018 11:55 PM, Mark Brown wrote:
>>> I'm still not thrilled about this.  If we're hard coding names they
>>> should be explicitly assigned names so that there's less chance that
>>> some other change in the subsystem will change things.
>> AMD Gpu driver creates devices for Playback and capture devices for both the I2S Controller instances using MFD framework.
>> Designware driver probe call gets invoked for every device creation with resource information and platform data provided by GPU driver.
>> In runtime , it seems exporting the device resource name from dwc driver to acp dma driver is not possible.
> This is not the case, if you are instantiating a platform device you can
> pass platform data to it when you do so by initializing the dev.platform_data
> field.
We understood your point.
We will implement required code changes and post updated patch.
