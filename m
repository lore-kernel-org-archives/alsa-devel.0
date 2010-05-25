From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Mixer volume/decibel mapping
Date: Tue, 25 May 2010 10:21:58 +0200
Message-ID: <4BFB88A6.8040701@ladisch.de>
References: <201005191834.57919.vand2@gmx.de>	
	<AANLkTimQtKql4p3UEs2Wh_tZ6YhzLGgl1q5G18A1y9Jk@mail.gmail.com>	
	<AANLkTilKqn_X3FUdDmCqy3YKdYeT47oIGGaqUitzruDk@mail.gmail.com>	
	<201005201141.28755.vand2@gmx.de>	
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>	
	<4BF629B3.9020904@ladisch.de>
	<AANLkTikEUdCu4UvSRONmiRXdEWsOo-0882JyvWWuxn4I@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 11B6110384D
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 10:22:17 +0200 (CEST)
In-Reply-To: <AANLkTikEUdCu4UvSRONmiRXdEWsOo-0882JyvWWuxn4I@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> On 21 May 2010 07:35, Clemens Ladisch <clemens@ladisch.de> wrote:
>> James Courtier-Dutton wrote:
>>> For the cards that do have this 32bit linear value, a simple lookup
>>> table is used in the kernel code to convert it to 256 step values.
>>
>> Which driver is this?  It should be changed to use the full range.
> 
> All creative and emu cards with a DSP.
> They use a lookup table in the driver.

Okay, with the latest driver, try:
  modprobe snd-emu10k1 high_res_gpr_volume=1

I did not yet enable this by default because alsactl has a bug when
restoring mixer values saved by the old driver, and alsamixer currently
thinks it is a good idea to let you step through two billion values.


Regards,
Clemens
