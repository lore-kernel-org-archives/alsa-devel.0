From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: Failed to create DAPM debugfs
Date: Thu, 09 Apr 2015 10:29:39 +0200
Message-ID: <55263873.108@metafoo.de>
References: <CAOMZO5DP4fahmC9W6eBFdjxR1DqPMgyhgwxwSZP_TcqxLSy=7A@mail.gmail.com>
 <55258272.2010205@metafoo.de>
 <CAOMZO5AxT9dgE=QaH18FUYD5CbMvn67XpMo4dH6T0v9Qen-RRg@mail.gmail.com>
 <55262C9D.5080005@metafoo.de> <20150409082246.GB62585@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-026.synserver.de (smtp-out-026.synserver.de
 [212.40.185.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 22C412651D2
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 10:29:39 +0200 (CEST)
In-Reply-To: <20150409082246.GB62585@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On 04/09/2015 10:22 AM, Nicolin Chen wrote:
> On Thu, Apr 09, 2015 at 09:39:09AM +0200, Lars-Peter Clausen wrote:
>
>> The whole thing is a bit confusing. The message you get is what
>> you'd get if the 'dapm' sub-directory in the card debugfs directory
>> can not be created. One of the few reasons why it would fail is if
>> it already existed, but we should never register two dapm contexts
>> for the card, so that's a bit strange. One of the few reasons I can
>> imagine this could happen is if the parent directory could not be
>> created and now we try to create multiple dapm directories at the
>> top-level.
>>
>> Try to do some more debugging and see why and where exactly things
>> go wrong. Can you also try this:
>>
>> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
>> index b6f8820..7810262 100644
>> --- a/sound/soc/soc-dapm.c
>> +++ b/sound/soc/soc-dapm.c
>> @@ -1898,6 +1898,11 @@
>>   {
>>   	struct dentry *d;
>>
>> +	if (!parent) {
>> +		dev_warn(dapm->dev, "No debugfs parent!\n");
>
> I tried, yes, the parent is NULL. And I did a little tracing and found
> that the card->debugfs_root, which is NULL, should be initialized in
> the soc_init_card_debugfs() while snd_soc_dapm_debugfs_init() seems
> to access this card->debugfs_root before calling soc_init_card_debugfs().
>
> I think I must have missed something over here....

Looks like this is the culprit: 
http://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=4e2576bd36a12e78ac3786d05b99a820dffe687f
