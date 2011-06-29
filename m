From: Michele Da Rold <michele.darold@ecsproject.com>
Subject: Re: wm8974 sam9g45 part #2
Date: Wed, 29 Jun 2011 18:58:52 +0200
Message-ID: <4E0B59CC.1040602@ecsproject.com>
References: <4DF0E2B4.7040401@ecsproject.com>	<20110610103118.GA26441@sirena.org.uk>	<4DFB1CEA.2060308@ecsproject.com>
	<4DFB6CA5.9010202@ecsproject.com>	<20110624120943.GG9483@opensource.wolfsonmicro.com>	<4E09AB6F.4060905@ecsproject.com>
	<20110629030307.GB22472@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cp-out9.libero.it (cp-out9.libero.it [212.52.84.109])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DEEE1038FA
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 18:59:00 +0200 (CEST)
In-Reply-To: <20110629030307.GB22472@opensource.wolfsonmicro.com>
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
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Il 29/06/2011 05:03, Mark Brown ha scritto:
> On Tue, Jun 28, 2011 at 12:22:39PM +0200, Michele Da Rold wrote:
>
>> 3. I use the default configuration of wm8974 registers, I put the
>> volume to 100%, the result on headphone output is noise, only
>> noise....
>> Stopping playback the noise stop so I think that I'm playing a sound
>> but no output!!
>
> This sounds like your clocking configuration is bad and the CODEC isn't
> parsing the data sent by the CPU.
You suggestion is ok, it was a problem with clock (MCLK) not I can do a 
playback without problem.
and now capture a sound...
thank you
Michele

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
