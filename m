From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: cs42l73: Don't mix
 SNDRV_PCM_RATE_KNOT with specific rates
Date: Tue, 04 Feb 2014 22:01:13 +0100
Message-ID: <52F15519.7090109@metafoo.de>
References: <1391543731-9085-1-git-send-email-lars@metafoo.de>
 <A40422ED-1EEB-4A09-A550-0AAAAA89464D@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-089.synserver.de (smtp-out-189.synserver.de
 [212.40.185.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FC8A261AA4
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 22:14:23 +0100 (CET)
In-Reply-To: <A40422ED-1EEB-4A09-A550-0AAAAA89464D@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/04/2014 09:30 PM, Austin, Brian wrote:
>> On Feb 4, 2014, at 13:55, "Lars-Peter Clausen" <lars@metafoo.de> wrote:
>>
>> SNDRV_PCM_RATE_KNOT means that the device can support rates that can not be
>> expressed using the rate bits. The driver will provide a list of those rates
>> specified through constraints. Any rate bits that are set in the rates mask will
>> be ignored. So setting other rate bits besides SNDRV_PCM_RATE_KNOT wont have any
>> effect, but might be confusing to the casual reader, so remove them.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
 >
> I don't see how this makes it any less confusing to the casual reader. I think the
 > define works well in the descriptive sense. maybe a comment about what 
KNOT really
 > means instead of just using a non-rate define?

The thing is SNDRV_PCM_RATE_8000_48000 does something if 
SNDRV_PCM_RATE_{KNOT,CONTINUOUS} is not set, but does nothing at all if 
either of them is set. While when reading the code it will, in my opinion, 
give the impression that the rates that are specified by 
SNDRV_PCM_RATE_8000_48000 are definitely among the supported rates and 
somewhere else additional rates are specified as well. But this is not the 
case all the supported rates need to be specified somewhere else, e.g. by a 
rate list constraint. I find this confusing when casually reading the code. 
And this is the only driver that does it.

Also there was a bug, which is now fixed, where additionally specifying 
rates in the rate bitmap when KNOT or CONTINUOUS was set did something, but 
did the wrong thing and caused additional rates which where outside of the 
range of the rates set in the bitmap to be ignored. Better avoid that by not 
mixing KNOT or CONTINUOUS with other rate bits.

- Lars
