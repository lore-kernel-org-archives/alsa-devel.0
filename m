From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: add RT5639 CODEC driver
Date: Tue, 25 Mar 2014 21:58:17 -0600
Message-ID: <53325059.4020000@wwwdotorg.org>
References: <1395627397-6580-1-git-send-email-oder_chiou@realtek.com>
 <20140325133017.GY2269@sirena.org.uk> <5331A1D6.2070109@wwwdotorg.org>
 <20140325165738.GZ2269@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D126943580E4@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 719852650B3
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 04:58:21 +0100 (CET)
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
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 03/25/2014 08:57 PM, Oder Chiou wrote:
>> -----Original Message-----
>> From: Mark Brown [mailto:broonie@kernel.org]
>> Sent: Wednesday, March 26, 2014 12:58 AM
>> To: Stephen Warren
>> Cc: Oder Chiou; Bard Liao; alsa-devel@alsa-project.org; lgirdwood@gmail.com;
>> Flove
>> Subject: Re: [alsa-devel] [PATCH] ASoC: add RT5639 CODEC driver
>>
>> On Tue, Mar 25, 2014 at 09:33:42AM -0600, Stephen Warren wrote:
>>> On 03/25/2014 07:30 AM, Mark Brown wrote:
>>
>>>> Looking at the level of code similiarity between this and the rt5640
>>>> driver I can't help but think that these should be supported from a
>>>> single driver - a few quick spot checks of the register map suggests
>>>> that there's at least some overlap.  There will need to be some
>>>> device specific handling but it looks like there's more shared than not shared.
>>>> What are the issues that prevent the code being shared, there may be
>>>> something I've missed?
>>
>>> FWIW, I was informed internally (although this certainly isn't
>>> normative) that RT5639 is RT5640 plus a DSP, and otherwise compatible.
>>> Related, I have a board that has a RT5639 and I'm running the RT5640
>>> driver on it for at least a simple use-case, without issue.
> 
> The RT5639 is a simplified version of RT5640. There was only a pair of DACs and there was no MONO out.
> The RT5639 and RT5640 didn't have the DSP function, and the RT5642 was the RT5640 plus a DSP.
> In our side, the Tegra4 was broken, and it also was EOL in your company.
> So, do you have the code base of Tegra5 which can use for verifying the upsteam driver?

Don't you still have the Dalmore (Tegra114/Tegra4) board that you used
last time? While our internal/downstream SW stack deprecates chip SW at
a rather annoying pace, upstream Linux still supports everything all the
way back to Tegra2/Tegra20, including Dalmore specifically. That has RT5640.
