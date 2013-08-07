From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: dt: Move WM8903 pin list from Tegra
 board binding to CODEC binding
Date: Wed, 07 Aug 2013 11:02:55 -0600
Message-ID: <52027DBF.9010501@wwwdotorg.org>
References: <1375866978-14726-1-git-send-email-broonie@kernel.org>
 <52026F84.5030204@wwwdotorg.org> <20130807163031.GK6427@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AC522655C8
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 19:03:00 +0200 (CEST)
In-Reply-To: <20130807163031.GK6427@sirena.org.uk>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/07/2013 10:30 AM, Mark Brown wrote:
> On Wed, Aug 07, 2013 at 10:02:12AM -0600, Stephen Warren wrote:
>> On 08/07/2013 03:16 AM, Mark Brown wrote:
>>> From: Mark Brown <broonie@linaro.org>
> 
>>> diff --git
>>> a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
>>> b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
>>
>>>
>>> 
the second being the connection's source. Valid names for sources and
>> ...
>>> +  sinks are the WM8903's pins (documented in the WM8903
>>> binding document), +  and the jacks on the board:
> 
>>> Board connectors:
> 
>> Probably want to remove the line "Board connectors:" ?

What I mean is that there's only 1 list of the jacks now, and that's
already introduced by the trailing colon you added in the line "+  and
the jacks on the board:".

> The board is still defining some jacks.
> 
>>> diff --git a/Documentation/devicetree/bindings/sound/wm8903.txt
>>> b/Documentation/devicetree/bindings/sound/wm8903.txt
> 
>>> +Pins on the device (for linking into audio routes): + +  *
>>> IN1L +  * IN1R
> 
>> I thought all the pins were going to be assigned numbers too so
>> that bindings could use either?
> 
> I think someone who wants to start using those should get to pick 
> numbers they find pleasing :)  More to the point it's more effort
> and I'd like to see it in action to see the nicest way to write it
> up - create a header and refer to it or just put it in the docs and
> have the numbers assigned with new DAPM widget types embedding the
> numbers for example?

I suppose it's fine to add that later. That rather encourages people
to think that only strings are acceptable for identifying the pins
though, which I'd rather avoid, but I guess it's fine.
