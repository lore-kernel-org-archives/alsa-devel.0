From: Sergej Sawazki <ce3a@gmx.de>
Subject: Re: [PATCH v2] ASoC: wm8741: Add differential mono
 mode support
Date: Mon, 11 May 2015 11:12:00 +0200
Message-ID: <55507260.1020307@gmx.de>
References: <1430858791-11825-1-git-send-email-ce3a@gmx.de>
 <20150511081225.GC3480@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id D513D2606F7
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 11:12:04 +0200 (CEST)
In-Reply-To: <20150511081225.GC3480@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 11.05.2015 at 10:12, Charles Keepax wrote:
> On Tue, May 05, 2015 at 10:46:31PM +0200, Sergej Sawazki wrote:
>> +static int wm8741_add_controls(struct snd_soc_codec *codec)
>> +{
>> +	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
>> +
>> +	switch (wm8741->pdata.diff_mode) {
>> +	case WM8741_DIFF_MODE_STEREO:
>> +	case WM8741_DIFF_MODE_STEREO_REVERSED:
>> +		snd_soc_add_codec_controls(codec, wm8741_snd_controls,
>> +				ARRAY_SIZE(wm8741_snd_controls));
>> +		break;
>> +	case WM8741_DIFF_MODE_MONO_LEFT:
>> +	case WM8741_DIFF_MODE_MONO_RIGHT:
>> +		/* The machine driver is responsible for mixer controls
>> +		 * if the codec is configured in differential mono mode.
>> +		 */
> Would it not be better to add controls but with a channel neutral
> name and then the machine driver can use the name_prefix stuff to
> stick left and right onto them? Seems a bit odd for the machine
> driver to have to know exact register details of the CODEC and
> manually add the volume controls?
>
> Thanks,
> Charles

Charles, could you point me to an "name_prefix" example please?

Thanks,
Sergej
