From: Nikesh <noswal@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: make dapm cache search depth configurable
Date: Thu, 10 Sep 2015 10:42:50 +0100
Message-ID: <55F1509A.4040303@opensource.wolfsonmicro.com>
References: <1441707097-11200-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
 <20150908104241.GA9751@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150908104241.GA9751@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Nikesh.Oswal@cirrus.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

The reason I though this will be usefull is as below:

While adding paths the source or sink widgets of consecutive path that 
are being added, may not be immediate neighbours in widget list. Hence 
in such scenarios the cache hits will reduce. One possible solution is 
to rearrange the widgets in the codec driver but sometimes
codec driver uses some macros to create a bunch of related widgets which 
we may want to skip in the cache search. So a configurable cache search 
depth caters to such scenarios.

For example in wm5110.c the frequently occuring mixer routes are defined 
by ARIZONA_MIXER_INPUT_ROUTES, so as to maximise the cache hit codec 
driver can register all the source widgets in exactly the same order (by 
rearranging the widgets in wm5110_dapm_widgets[]) as defined in this 
macro. But if you notice the way DSP widgets are created they use a 
WM_ADSP2 macro which creates a preloader widget for every DSP widget and 
we want to skip past this preloader widget when doing a cache search so 
increasing the cache search depth helps here.

Thanks,
Nikesh

On 08/09/15 11:42, Mark Brown wrote:
> On Tue, Sep 08, 2015 at 11:11:37AM +0100, Nikesh Oswal wrote:
>> cache search depth will have a default value of 2 and can
>> be modified by the respective component probe function
> Why?
