From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: Don't add prefix to widget
 stream name
Date: Tue, 21 Jul 2015 16:54:02 +0200
Message-ID: <55AE5D0A.7030800@metafoo.de>
References: <1437472295-5524-1-git-send-email-lars@metafoo.de>
 <1437486892.30798.14.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-101.synserver.de (smtp-out-101.synserver.de
 [212.40.185.101])
 by alsa0.perex.cz (Postfix) with ESMTP id B411E264EFA
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 16:54:30 +0200 (CEST)
In-Reply-To: <1437486892.30798.14.camel@mtksdaap41>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

On 07/21/2015 03:54 PM, Koro Chen wrote:
> On Tue, 2015-07-21 at 11:51 +0200, Lars-Peter Clausen wrote:
>> Commit fdb6eb0a1287 ("ASoC: dapm: Modify widget stream name according to
>> prefix") fixed the case where a DAPM route between a DAI widget and a
>> DAC/ADC/AIF widget with a matching stream name was not created when the
>> DAPM context was using a prefix.
>>
>> Unfortunately the patch introduced a few issues on its own like leaking the
>> dynamically allocated stream name memory and also not checking whether the
>> allocation succeeded in the first place.
>>
>> It is also incomplete in that it still does not handle the case where
>> stream name of the widget is a substring of the stream name of the DAI,
>> which is explicitly allowed and works fine if no DAPM prefix is used.
>>
> I think your solution looks reasonable.
> However, just curious, why didn't we use strstr(dai_w->name, w->sname)
> in the first place?

It's probably just an oversight when the code was developed initially.
