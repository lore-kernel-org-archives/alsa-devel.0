From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH for-3.2 2/2] ASoC: Davinci: Fix FS polarity
	for I2S format
Date: Fri, 30 Sep 2011 15:14:48 +0300
Message-ID: <4E85B2B8.4090308@bitmer.com>
References: <1317369333-20814-1-git-send-email-jarkko.nikula@bitmer.com>
	<1317369333-20814-2-git-send-email-jarkko.nikula@bitmer.com>
	<20110930115501.GG5366@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 926B82437F
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 14:15:11 +0200 (CEST)
In-Reply-To: <20110930115501.GG5366@opensource.wolfsonmicro.com>
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
Cc: Kevin Hilman <khilman@ti.com>, alsa-devel@alsa-project.org, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>
List-Id: alsa-devel@alsa-project.org

On 09/30/2011 02:55 PM, Mark Brown wrote:
> On Fri, Sep 30, 2011 at 10:55:33AM +0300, Jarkko Nikula wrote:
>> Commit 75d9ac4 ("ASoC: Allow DAI formats to be specified in the dai_link")
>> changed DAI format flag values and we cannot simply invert anymore e.g.
>> frame-sync with ^= SND_SOC_DAIFMT_NB_IF (which was anyway misuse) as there
>> is no anymore fixed bit position for bit-clock or frame-sync inversion.
>
> Actually it does, sorry - the for-3.2 bit was causing confusion (I don't
> know why you started doing that?).

Well, it's Friday. My attempt to emphasize that "Fix foo bar" is 
definitely not for 3.1 did rather opposite, sorry about that :-)

-- 
Jarkko
