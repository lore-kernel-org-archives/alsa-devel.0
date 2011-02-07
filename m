From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/7] ASoC: neo1973_wm8753: Remove scenario
 management code.
Date: Mon, 07 Feb 2011 18:01:41 +0100
Message-ID: <4D502575.8080501@metafoo.de>
References: <1297033463-14577-1-git-send-email-lars@metafoo.de>
	<20110207114255.GB10564@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id B095A24492
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 18:00:19 +0100 (CET)
In-Reply-To: <20110207114255.GB10564@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 02/07/2011 12:42 PM, Mark Brown wrote:
> On Mon, Feb 07, 2011 at 12:04:17AM +0100, Lars-Peter Clausen wrote:
> 
>> +	snd_soc_dapm_disable_pin(codec, "Audio Out");
>> +	snd_soc_dapm_disable_pin(codec, "GSM Line Out");
>> +	snd_soc_dapm_disable_pin(codec, "GSM Line In");
>> +	snd_soc_dapm_disable_pin(codec, "Headset Mic");
>> +	snd_soc_dapm_disable_pin(codec, "Call Mic");
> 
> This will mean that it's impossible to enable most (if not all) of the
> audio paths in the system which probably isn't what you want.

I've seem to have overlooked to add DAPM_SWITCH_PIN controls for these pins, since it
has been done implicitly in the patch merging the gta01 and gta02 driver.

I'll resend a updated version.

- Lars
