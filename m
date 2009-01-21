From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH] ASoC: Complete Beagleboard support
Date: Wed, 21 Jan 2009 08:35:54 -0800
Message-ID: <5e088bd90901210835neb0d8f1s309d4668cf444cc0@mail.gmail.com>
References: <5e088bd90901202305m26900888jcaa2b0ec57d3fab1@mail.gmail.com>
	 <200901210953.36630.peter.ujfalusi@nokia.com>
	 <5e088bd90901210640v4ce21f8clae9469b60226a6f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <5e088bd90901210640v4ce21f8clae9469b60226a6f0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, linux-omap <linux-omap@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 21, 2009 at 6:40 AM, Steve Sakoman <sakoman@gmail.com> wrote:
> On Tue, Jan 20, 2009 at 11:53 PM, Peter Ujfalusi
> <peter.ujfalusi@nokia.com> wrote:
>> Hello,
>>
>> for ure now you can build it, but does it actually works?
>> I mean there has been quite a bit of change in the twl4030
>> codec driver... The DAPM routing implementation might require
>> some change in the board file also (SND_SOC_DAPM_HP,
>> SND_SOC_DAPM_LINE, etc).
>
> I will test this morning.  I expect it should work since Overo works
> and Beagle is largely identical.

I did a quick mplayer test and was able to play an mp3 with this patch
applied to linux-omap top of tree.

Hardware was Beagle Rev C1D

Steve
