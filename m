From: Michele Da Rold <michele.darold@ecsproject.com>
Subject: Re: wm8974 and sam9g45 atmel
Date: Fri, 17 Jun 2011 17:03:01 +0200
Message-ID: <4DFB6CA5.9010202@ecsproject.com>
References: <4DF0E2B4.7040401@ecsproject.com>	<20110610103118.GA26441@sirena.org.uk>
	<4DFB1CEA.2060308@ecsproject.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cp-out8.libero.it (cp-out8.libero.it [212.52.84.108])
	by alsa0.perex.cz (Postfix) with ESMTP id 7192D24501
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 17:03:12 +0200 (CEST)
In-Reply-To: <4DFB1CEA.2060308@ecsproject.com>
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

Il 17/06/2011 11:22, Michele Da Rold ha scritto:
> Il 10/06/2011 12:31, Mark Brown ha scritto:
>> On Thu, Jun 09, 2011 at 05:11:48PM +0200, Michele Da Rold wrote:
>>> Hello everybody, I'm starting a new development with a Atmel SAM9G45 and
>>> a WM8974.
>>
>> Please always CC maintainers on mails - traffic on the mailing list is
>> easily lost.
>>
>>> I'm using kernel 2.6.33.2
>>
>> This kernel is *very* old - I would strongly recommend updating to a
>> more current kernel if you're looking for support.
>>
> Updated to 2.6.39.1!
>>> Putting some dedug messagge the driver not call the function
>>> "set_bias_level", and call the mute function with mute=0.
>>> Testing the MCLK signal I not see any clock on pin because I never call
>>> clk_enable!!
>>
>> Have you routed audio from the DAI to an output using the ALSA controls?
>> If you haven't connected an output path up then the kernel won't power
>> anything on.
>>
> Now I have configured wm8974 like slave, the ssc generate BCLK e FRAME
> signal and MCLK but I haven't output (I'm doing a playback)
> I'm new to alsa development so I haven't understand how to route audio
> to DAI from output, could you help me?
>
UPDATE!!!!!!!
Using amixer I have put to on the numid=61,iface=MIXER,name='Speaker 
Mixer PCM Playback Switch' ON
numid=46,iface=MIXER,name='Speaker Playback Volume' 63 (max value)

and then the playback start but at speaker output I have only noise no 
sound!!

I have another question:
it's better to use wm8974 like master? because I have see that the atmel 
ssc is not so good generating clocks....

Thank you

Michele


> Best regards
>
> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
