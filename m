From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH 00/10] ASoC: codec: devm_ related modifications
Date: Mon, 26 Nov 2012 08:54:09 +0530
Message-ID: <50B2E0D9.1050000@linaro.org>
References: <1353557322-25353-1-git-send-email-tushar.behera@linaro.org> <20121123143710.GQ4529@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121123143710.GQ4529@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

On 11/23/2012 08:07 PM, Mark Brown wrote:
> On Thu, Nov 22, 2012 at 09:38:32AM +0530, Tushar Behera wrote:
>> This patchset includes devm_ related modifications for sound codecs.
>>
>> First 2 patches fix warning for freeing of devm_ allocated data.
>> The next patch introduces usage of devm_kzalloc() in wm8995 codec.
>> Following 7 patches introduce usage of devm_regmap_init_xxx() in
>> remaining codecs.
> 
> Applied all, thanks.  If you're doing stuff like this it's helpful to
> sort by part.
> 
Thanks. I will keep that in mind.

-- 
Tushar Behera
