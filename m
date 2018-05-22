From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [PATCH 31/33] ASoC: max98088: use match_string() helper
Date: Tue, 22 May 2018 20:30:16 +0800
Message-ID: <92b32dee-7ba9-ad6d-573b-9924453a69fb@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-32-git-send-email-xieyisheng1@huawei.com>
 <CAHp75Vf2ZTf0w=Kg_w7CJ-9XdGqipe3UVS=E=aeRDxGt3BHM3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vf2ZTf0w=Kg_w7CJ-9XdGqipe3UVS=E=aeRDxGt3BHM3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Andy,

On 2018/5/22 6:24, Andy Shevchenko wrote:
> On Mon, May 21, 2018 at 2:58 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> match_string() returns the index of an array for a matching string,
>> which can be used intead of open coded variant.
> 
>>  static int max98088_get_channel(struct snd_soc_component *component, const char *name)
>>  {
> 
>> +       int ret = match_string(eq_mode_name, ARRAY_SIZE(eq_mode_name), name);
> I would rather split this and move an assignment to the line before 'if'

hmm, you mean something like:

	int ret;

	ret = match_string(eq_mode_name, ARRAY_SIZE(eq_mode_name), name);
	if (ret < 0) /* Shouldn't happen */
		dev_err(component->dev, "Bad EQ channel name '%s'\n", name);
	return ret;
>>
>>         /* Shouldn't happen */
> 
>> +       if (ret < 0)
>> +               dev_err(component->dev, "Bad EQ channel name '%s'\n", name);
> 
>>         return -EINVAL;
> 
> return ret;
Right, sorry for this big mistake.

Thanks
Yisheng
> 
> ?
> 
>>  }
>>
>> --
>> 1.7.12.4
>>
> 
> 
> 
