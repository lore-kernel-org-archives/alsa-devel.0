From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5677: Use specific r/w function
	for DSP mode
Date: Mon, 3 Nov 2014 02:31:41 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694F320FF@RTITMBSV03.realtek.com.tw>
References: <1414378351-2329-1-git-send-email-oder_chiou@realtek.com>
 <20141028222915.GG18557@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694F30527@RTITMBSV03.realtek.com.tw>
 <20141031175226.GN18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id B74A0260448
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 03:31:49 +0100 (CET)
In-Reply-To: <20141031175226.GN18557@sirena.org.uk>
Content-Language: zh-TW
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@google.com" <benzh@google.com>, "anatol@google.com" <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Saturday, November 01, 2014 1:52 AM
> To: Oder Chiou
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Bard Liao; Flove;
> anatol@google.com; benzh@google.com
> Subject: Re: [PATCH] ASoC: rt5677: Use specific r/w function for DSP mode
> 
> On Wed, Oct 29, 2014 at 01:44:57AM +0000, Oder Chiou wrote:
> 
> > > This looks like standard regmap stuff - what's different?
> 
> > They are not different with regmap stuff, but they are called by
> > rt5677_dsp_mode_i2c_write_addr(), rt5677_dsp_mode_i2c_read_addr(),
> > rt5677_read() and rt5677_write().
> 
> > The customize access function is implemented by rt5677_read() and
> > rt5677_write() that are assigned to regmap_config "rt5677_regmap" for
> > using between codec mode or DSP mode.
> 
> Sorry, I'm not quite following what you're saying here - if you're saying that they're
> slightly different to the main register map I/O for this device then it's OK to create
> two regmaps and only access the DSP one through separate functions.
> 
Sorry for my weak explanations. In this codec, there are 2 access modes, and it
only can be chosen one mode at the same time. In codec mode, we use the normal
access method to access codec settings, and in DSP mode, we also can access the
codec settings, but it should use the method of memory address map to access.
Ex. If we want to access the MX-01 in the DSP mode, we need to convert to
memory address 0x18020000 + (01 * 2). We want to use the same regmap table to
handle the codec settings, so the customize r/w functions are needed in it.
In the DSP mode, the registers MX-00 ~ MX-04 are used for DSP address access,
so it also need the native function to avoid the regmap handle, thanks.
