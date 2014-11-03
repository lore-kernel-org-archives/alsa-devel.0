From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: Match the CMR divider only in full
 duplex.
Date: Mon, 3 Nov 2014 09:25:29 +0800
Message-ID: <5456D989.8000108@atmel.com>
References: <544A1121.6080900@atmel.com> <1414178759-7252-1-git-send-email-peda@axentia.se> <1414178759-7252-2-git-send-email-peda@axentia.se> <20141031181210.GQ18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141031181210.GQ18557@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 11/01/2014 02:12 AM, Mark Brown wrote:
> On Fri, Oct 24, 2014 at 09:25:59PM +0200, Peter Rosin wrote:
>> The CMR divider register is shared by playback and capture. The SSC driver
>> therefore tries to enforce rules so that the needed register content do
>> not conflict during simultaneous playback/capture. However, the
>> implementation also prevents changing the register content in
>> half-duplex scenarios, which is needed when using the OSS API.
>
> Bo, is this OK?

I have acked this patch. However Peter resend with "git send-email" 
command while not add Acked-by tag. Anyway:

Acked-by: Bo Shen <voice.shen@atmel.com>

Best Regards,
Bo Shen
