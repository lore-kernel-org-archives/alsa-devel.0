From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: [PATCH] ASoC: pcm512x: Fix a double unlock in
 pcm512x_digital_mute()
Date: Fri, 21 Dec 2018 15:54:26 +0200
Message-ID: <87751c04-3bb9-0fc2-5ddc-2dd86dbe9b05@gmail.com>
References: <20181221091120.GG2735@kadam>
 <f8f14c6a-46c2-995d-2df4-4ae821e1b895@gmail.com>
 <20181221120056.GD2240@kadam> <20181221121050.GE4996@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BECF267A78
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 14:54:29 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id p6so5794242wmc.1
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 05:54:29 -0800 (PST)
In-Reply-To: <20181221121050.GE4996@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/21/18 2:10 PM, Mark Brown wrote:
> On Fri, Dec 21, 2018 at 03:00:56PM +0300, Dan Carpenter wrote:
>> On Fri, Dec 21, 2018 at 01:23:37PM +0200, Dimitris Papavasiliou wrote:
> 
>>> Maintainers, please let me know if there's anything I need to do
>>> with respect to this.
> 
>> All you need to is reply with a reviewed-by tag so we can mark on the
>> fix that you approved it.
> 
>> Reviewed-by: Your Name <email>
> 
> I've just gone and applied the tag but yeah, what Dan says - there's
> tools that can pick tags like this out of e-mail which is also useful.

Thanks to both, but Mark, I'm afraid you've misspelled "Reviewed" in
the patch you applied.
