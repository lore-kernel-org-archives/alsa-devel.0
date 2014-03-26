From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] ASoC: add RT5639 CODEC driver
Date: Wed, 26 Mar 2014 09:11:59 +0200
Message-ID: <53327DBF.6080402@linux.intel.com>
References: <1395627397-6580-1-git-send-email-oder_chiou@realtek.com>
 <20140325133017.GY2269@sirena.org.uk> <5331A1D6.2070109@wwwdotorg.org>
 <20140325165738.GZ2269@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D126943580E4@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 12479265112
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 08:12:18 +0100 (CET)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D126943580E4@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>
Cc: Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 03/26/2014 04:57 AM, Oder Chiou wrote:
>> -----Original Message-----
>> From: Mark Brown [mailto:broonie@kernel.org]
>> Sent: Wednesday, March 26, 2014 12:58 AM
>> To: Stephen Warren
>> Cc: Oder Chiou; Bard Liao; alsa-devel@alsa-project.org; lgirdwood@gmail.com;
>> Flove
>> Subject: Re: [alsa-devel] [PATCH] ASoC: add RT5639 CODEC driver
>>
>> On Tue, Mar 25, 2014 at 09:33:42AM -0600, Stephen Warren wrote:
>>> FWIW, I was informed internally (although this certainly isn't
>>> normative) that RT5639 is RT5640 plus a DSP, and otherwise compatible.
>>> Related, I have a board that has a RT5639 and I'm running the RT5640
>>> driver on it for at least a simple use-case, without issue.
> The RT5639 is a simplified version of RT5640. There was only a pair of DACs and there was no MONO out.
> The RT5639 and RT5640 didn't have the DSP function, and the RT5642 was the RT5640 plus a DSP.
> In our side, the Tegra4 was broken, and it also was EOL in your company.
> So, do you have the code base of Tegra5 which can use for verifying the upsteam driver?
>
FWIW, we are using RT5640 upstream driver on Intel reference designs 
that have RT5642 so if those DSP features are going to be supported some 
day I propose to have them implemented in a same driver.

sound/soc/codecs/tlv320aic3x.c comes to my mind how to implement support 
for different codec variants in the same driver.

-- 
Jarkko
