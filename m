From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/3] ASoC: lpass-platform: Fix broken pcm data usage
Date: Fri, 28 Oct 2016 22:11:35 +0100
Message-ID: <7de5b48a-c3e4-0111-b21d-4d733786b5d9@linaro.org>
References: <1477668740-30389-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1477668740-30389-3-git-send-email-srinivas.kandagatla@linaro.org>
 <20161028182644.nbsbm6h7fcj3rlcj@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161028182644.nbsbm6h7fcj3rlcj@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Kenneth Westfield <kwestfie@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org



On 28/10/16 19:26, Mark Brown wrote:
> On Fri, Oct 28, 2016 at 04:32:19PM +0100, Srinivas Kandagatla wrote:
>> This patch fixes lpass-platform driver which was broken in v4.9-rc1.
>> lpass_pcm_data data structure holds information specific to stream.
>> Holding a single private pointer to it in global lpass_data
>> will not work, because it would be overwritten by for each pcm instance.
>
> This is a bug fix but you've made it depend on patch 1 which is just a
> refactoring and should therefore not be sent to Linus as a fix.  Please
> don't do this, fix bugs first then do any cleanups and new
> functionality.  That way we can send fixes to Linus without needing to
> pull in extra stuff.
Sorry about that, I will resend the fix patch without any dependencies.

Thanks,
srini


>
