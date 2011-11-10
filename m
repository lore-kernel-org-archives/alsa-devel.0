From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add SoundCard driver for OKI SEMICONDUCTOR
	ML7213 IOH
Date: Thu, 10 Nov 2011 11:22:46 +0000
Message-ID: <20111110112245.GA29931@opensource.wolfsonmicro.com>
References: <70D251FDDC55405882A8447CC455D56E@hacdom.okisemi.com>
	<8486F61FC3B94B908BFE654234DD6C97@hacdom.okisemi.com>
	<4E9BAEF7.1080406@dsn.lapis-semi.com>
	<s5h7h3ysa4l.wl%tiwai@suse.de> <4EA5563A.10703@dsn.lapis-semi.com>
	<20111024122015.GA26033@opensource.wolfsonmicro.com>
	<4EB8F079.9080703@dsn.lapis-semi.com>
	<20111108143818.GA5632@opensource.wolfsonmicro.com>
	<4EBB5A66.2020800@dsn.lapis-semi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9916D2441B
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 12:22:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EBB5A66.2020800@dsn.lapis-semi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>
Cc: alsa-devel@alsa-project.org, "Wang, Qi" <qi.wang@intel.com>, Takashi Iwai <tiwai@suse.de>, "Wang,
	Yong Y" <yong.y.wang@intel.com>, linux-kernel@vger.kernel.org, "Ewe, Kok Howg" <kok.howg.ewe@intel.com>, Liam Girdwood <lrg@ti.com>, "Clark, Joel" <joel.clark@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 10, 2011 at 02:00:22PM +0900, Tomoya MORINAGA wrote:
> (2011/11/08 23:38), Mark Brown wrote:
> >On Tue, Nov 08, 2011 at 06:03:53PM +0900, Tomoya MORINAGA wrote:

> >>struct snd_ml7213i2s_pcm {
> >>	enum snd_soc_control_type control_type;
> >>	struct snd_ml7213i2s *ml7213i2s;
> >>	spinlock_t lock;
> >>	unsigned int irq_pos;
> >>	unsigned int buf_pos;
> >>	struct snd_pcm_substream *substream;
> >>	struct cbdata cbd;              /* i2s callback info */
> >>	unsigned int channels;
> >>	unsigned int rw;
> >>	unsigned int rate;
> >>	unsigned int ch;
> >>	unsigned int setup_flag;
> >>	unsigned int format;
> >>	unsigned int bclkfs;
> >>	struct mutex i2c_mutex;
> >>};

> >...this looks *really* confused, there's things in here which are a mix
> >of DMA controller and CODEC driver things.  The CODEC and DMA drivers
> >shouldn't know anything about each other, let alone be referencing the
> >same data structure.

> Let me clarify your saying.
> I couldn't understand what your "DMA controller" mean.
> Which "snd_ml7213i2s_pcm" structure member do you mean ?

Things like irq_pos and buf_pos for example.
