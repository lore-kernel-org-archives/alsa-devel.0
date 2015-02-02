From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: rx51: Correct DAPM route for capture
Date: Mon, 02 Feb 2015 21:29:10 +0200
Message-ID: <54CFD006.6080505@bitmer.com>
References: <1422603163-13346-1-git-send-email-peter.ujfalusi@ti.com>
 <54CBCE44.6040907@bitmer.com> <54CFB01D.7080908@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 581732606FC
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 20:29:35 +0100 (CET)
In-Reply-To: <54CFB01D.7080908@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, pavel@ucw.cz
List-Id: alsa-devel@alsa-project.org

On 02/02/2015 07:13 PM, Lars-Peter Clausen wrote:
> On 01/30/2015 07:32 PM, Jarkko Nikula wrote:
> [...]
>> Here's additional data. Without this patch there are these errors below
>> when registering the card:
>>
>> [    8.804626] rx51-audio n900-audio: Connecting non-supply widget to
>> supply widget is not supported (DMic -> Mic Bias)
>> [    8.815795] rx51-audio n900-audio: ASoC: no dapm match for DMic -->
>> (null) --> Mic Bias
>> [    8.824249] rx51-audio n900-audio: ASoC: Failed to add route DMic ->
>> direct -> Mic Bias
>> [    8.832763] rx51-audio n900-audio: Connecting non-supply widget to
>> supply widget is not supported (HS Mic -> b Mic Bias)
>> [    8.844238] rx51-audio n900-audio: ASoC: no dapm match for HS Mic -->
>> (null) --> b Mic Bias
>> [    8.853057] rx51-audio n900-audio: ASoC: Failed to add route HS Mic
>> -> direct -> b Mic Bias
>>
>> This don't happen on v3.18 so in that sense Peter's patch is kind of
>> half-regression fix for v3.19.
> 
> What's new in v3.19 is that the kernel will shout if it encounters such
> a invalid route, previously it was just silently ignored. But either way
> it never actually worked, so it's not really a v3.19 regression.
> 
It used to work in the past, not sure about 3.18 since I didn't actually
test recording due missing mic bias from DT data (i.e. recording has
been actually broken quite many releases) but looks like your
e409dfbfccf9 ("ASoC: dapm: Add a few supply widget sanity checks") made
it visible. Fortunately Peter saw it from sources even without above
report. Good to have active users that report issues :-)

-- 
Jarkko
