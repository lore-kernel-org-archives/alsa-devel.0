From: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>
Subject: Re: [PATCH] Add SoundCard driver for OKI SEMICONDUCTOR ML7213 IOH
Date: Thu, 10 Nov 2011 14:00:22 +0900
Message-ID: <4EBB5A66.2020800@dsn.lapis-semi.com>
References: <70D251FDDC55405882A8447CC455D56E@hacdom.okisemi.com> <8486F61FC3B94B908BFE654234DD6C97@hacdom.okisemi.com> <4E9BAEF7.1080406@dsn.lapis-semi.com> <s5h7h3ysa4l.wl%tiwai@suse.de> <4EA5563A.10703@dsn.lapis-semi.com> <20111024122015.GA26033@opensource.wolfsonmicro.com> <4EB8F079.9080703@dsn.lapis-semi.com> <20111108143818.GA5632@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111108143818.GA5632@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, perex@perex.cz, linux-kernel@vger.kernel.org, "Wang, Qi" <qi.wang@intel.com>, "Wang, Yong Y" <yong.y.wang@intel.com>, "Clark, Joel" <joel.clark@intel.com>, "Ewe, Kok Howg" <kok.howg.ewe@intel.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(2011/11/08 23:38), Mark Brown wrote:
> On Tue, Nov 08, 2011 at 06:03:53PM +0900, Tomoya MORINAGA wrote:
>
> So, I started looking at this but...
>
>> struct snd_ml7213i2s_pcm {
>> 	enum snd_soc_control_type control_type;
>> 	struct snd_ml7213i2s *ml7213i2s;
>> 	spinlock_t lock;
>> 	unsigned int irq_pos;
>> 	unsigned int buf_pos;
>> 	struct snd_pcm_substream *substream;
>> 	struct cbdata cbd;              /* i2s callback info */
>> 	unsigned int channels;
>> 	unsigned int rw;
>> 	unsigned int rate;
>> 	unsigned int ch;
>> 	unsigned int setup_flag;
>> 	unsigned int format;
>> 	unsigned int bclkfs;
>> 	struct mutex i2c_mutex;
>> };
>
> ...this looks *really* confused, there's things in here which are a mix
> of DMA controller and CODEC driver things.  The CODEC and DMA drivers
> shouldn't know anything about each other, let alone be referencing the
> same data structure.

Let me clarify your saying.
I couldn't understand what your "DMA controller" mean.
Which "snd_ml7213i2s_pcm" structure member do you mean ?


-- 
tomoya
ROHM Co., Ltd.
