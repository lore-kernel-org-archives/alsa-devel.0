From: Sergej Sawazki <sergej@taudac.com>
Subject: Re: [PATCH 2/3] ASoC: wm8741: Set OSR mode in
	hw_params()
Date: Mon, 18 Sep 2017 21:30:36 +0200
Message-ID: <61568e45-844d-34eb-a9df-518d18843b01@taudac.com>
References: <1504553653-8144-1-git-send-email-sergej@taudac.com>
 <1504553653-8144-3-git-send-email-sergej@taudac.com>
 <20170905161221.qopgxgaw4zhfzfvs@localhost.localdomain>
 <575ad555-0cab-66de-95b7-4dc1b379ca9c@taudac.com>
 <20170906082037.tgseyekunu2cf4qx@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s62.goserver.host (s62.goserver.host [37.17.224.62])
 by alsa0.perex.cz (Postfix) with ESMTP id AE6E4266E55
 for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2017 21:30:38 +0200 (CEST)
In-Reply-To: <20170906082037.tgseyekunu2cf4qx@localhost.localdomain>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Am 06.09.2017 um 10:20 schrieb Charles Keepax:
> On Tue, Sep 05, 2017 at 08:36:24PM +0200, Sergej Sawazki wrote:
>> Am 05.09.2017 um 18:12 schrieb Charles Keepax:
>>> On Mon, Sep 04, 2017 at 09:34:12PM +0200, Sergej Sawazki wrote:

[...]

>>>> @@ -243,6 +250,7 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
>>>>    		params_width(params), params_rate(params));
>>>>    	snd_soc_write(codec, WM8741_FORMAT_CONTROL, iface);
>>>> +	snd_soc_write(codec, WM8741_MODE_CONTROL_1, mode);
>>>
>>> Better to use an update_bits rather than basically open-code it
>>> with read and then this write.
>>>
>>
>> I have used write() and not update_bits() here to be consistent with the way
>> the WM8741_FORMAT_CONTROL register is written. If we change it to
>> update_bits(), we should refactor the WM8741_FORMAT_CONTROL write to use
>> update_bits() too, right?
>>
> 
> Yeah that should probably be an update bits too by the looks of
> it.

Charles,

I think we should split "adding the OSR mode configuration" and
"refactoring the code to use update_bits()" in at least two commits.

For consistency, I would keep the write() in this patch, and provide
the update_bits() refactoring later. What do you think?

Thanks,
Sergej
