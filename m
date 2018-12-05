From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: Re: [resend PATCH] dt-bindings: sound: Add documentation for pcm3060
 property out-single-ended
Date: Wed, 5 Dec 2018 08:04:34 +0100
Message-ID: <7cbf1452-354f-07d6-2310-cadc4358433e@birdec.tech>
References: <20181115071253.22558-1-kmarinushkin@birdec.tech>
 <20181204214313.GA7847@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204214313.GA7847@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thank you Rob,

Mark already applied this patch, with a slightly modified subject:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=fd7de6370cb62b147185834d60069568a21acacd

Best Regards,
Kirill

On 12/04/18 22:43, Rob Herring wrote:
> On Thu, 15 Nov 2018 08:12:53 +0100, Kirill Marinushkin wrote:
>> Output of pcm3060 codec may be configured as single-ended or differential
>>
>> Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
>> Cc: devicetree@vger.kernel.org
>> ---
>> Hello Mark,
>>
>> yesterday there was a misunderstanding: when I wrote you
>>
>>> I think you forgot one patch in the series
>>
>> you accidently applied the already-applied patch instead of the forgotten
>> one. To avoid the confusion, in this e-mail I resend you the proper
>> forgotten patch in a separate mailing thread.
>>
>> Please apply this patch for-next.
>>
>> Best Regards,
>> Kirill
>> ---
>>  Documentation/devicetree/bindings/sound/pcm3060.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
