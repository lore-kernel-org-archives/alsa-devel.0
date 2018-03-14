From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 1/7] ASoC: amd: dma driver changes for BT
 I2S controller instance
Date: Wed, 14 Mar 2018 16:06:15 +0530
Message-ID: <284973fb-bcc9-19b9-2692-966e40129430@amd.com>
References: <1520836460-21809-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1520836460-21809-2-git-send-email-Vijendar.Mukunda@amd.com>
 <20180312182537.GO2186@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0046.outbound.protection.outlook.com [104.47.32.46])
 by alsa0.perex.cz (Postfix) with ESMTP id CC1682670F8
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 11:34:14 +0100 (CET)
In-Reply-To: <20180312182537.GO2186@sirena.org.uk>
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



On Monday 12 March 2018 11:55 PM, Mark Brown wrote:
> On Mon, Mar 12, 2018 at 12:04:14PM +0530, Vijendar Mukunda wrote:
>
>> +		 * It has fixed mapping as mentioned below.
>> +		 * designware-i2s.1.auto cpu dai will be used for I2S SP Instance playback device.
>> +		 * designware-i2s.2.auto cpu dai will be used for I2S SP Instance capture device.
>> +		 * designware-i2s.3.auto cpu dai will be used for I2S BT Instance playback/capture device.
> I'm still not thrilled about this.  If we're hard coding names they
> should be explicitly assigned names so that there's less chance that
> some other change in the subsystem will change things.
AMD Gpu driver creates devices for Playback and capture devices for both the I2S Controller instances using MFD framework.
Designware driver probe call gets invoked for every device creation with resource information and platform data provided by GPU driver.
In runtime , it seems exporting the device resource name from dwc driver to acp dma driver is not possible.
We understand your concern, but we have made the all necessary checks to avoid any fall-backs due to this.
Our design makes sure that the same naming convention is followed in machine driver too and there also we mention cpu dai name in the same way.
We explored other options but this seems to be the best which makes acp dma driver compatible with multiple platforms.
>
> Please make some effort to keep the code within 80 columns too.
We will fix it and share updated patch.
