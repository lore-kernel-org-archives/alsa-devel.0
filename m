From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: [PATCH] revo51: add headphone output
Date: Thu, 21 Aug 2008 12:09:19 +0200
Message-ID: <48AD3ECF.9000209@insite.cz>
References: <20080821042842.GA7789@orion>	<48AD15CD.8090601@insite.cz>
	<s5hbpzmbusq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id BCC802448D
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Aug 2008 12:09:26 +0200 (CEST)
In-Reply-To: <s5hbpzmbusq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Alexander Beregalov <a.beregalov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 21 Aug 2008 09:14:21 +0200,
> Pavel Hofman wrote:
>> Alexander Beregalov wrote:
>>>  It is ALSA bug #1754.
>>>  D6 bit in 02 register is PW4.
>>>
>>> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
>>> ---
>>>
>>>  sound/i2c/other/ak4xxx-adda.c |    4 ++--
>>>  sound/pci/ice1712/revo.c      |    5 +++--
>>>  2 files changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/sound/i2c/other/ak4xxx-adda.c b/sound/i2c/other/ak4xxx-adda.c
>>> index 288926d..4c94458 100644
>>> --- a/sound/i2c/other/ak4xxx-adda.c
>>> +++ b/sound/i2c/other/ak4xxx-adda.c
>>> @@ -233,8 +233,8 @@ void snd_akm4xxx_init(struct snd_akm4xxx *ak)
>>>  		0x01, 0x02, /* 1: reset and soft-mute */
>>>  		0x00, 0x06, /* 0: mode3(i2s), disable auto-clock detect,
>>>  			     * disable DZF, sharp roll-off, RSTN#=0 */
>>> -		0x02, 0x0e, /* 2: DA's power up, normal speed, RSTN#=0 */
>>> -		// 0x02, 0x2e, /* quad speed */
>>> +		0x02, 0x4e, /* 2: DA's power up, normal speed, RSTN#=0 */
>>> +		// 0x02, 0x6e, /* quad speed */
>> Fantastic, I guess this could help to fix the problem with 
>> non-functioning monitoring in ESI Juli@ too. I did not notice the fourth 
>> DAC was powered down. Thanks a lot!
> 
> Maybe we need a change like in revo.c for Juli@, too?
> 
> 
> Takashi

>From what I understand, the changes in revo.c:

@@ -216,6 +216,7 @@ static const struct snd_akm4xxx_dac_channel 
revo51_dac[] = {
  	AK_DAC("PCM Center Playback Volume", 1),
  	AK_DAC("PCM LFE Playback Volume", 1),
  	AK_DAC("PCM Rear Playback Volume", 2),
+	AK_DAC("PCM Headphone Volume", 2),
  };

Already in juli.c, monitors volume.

  static struct snd_akm4xxx akm_revo51 __devinitdata = {
  	.type = SND_AK4358,
-	.num_dacs = 6,
+	.num_dacs = 8,
  	.ops = {

Important, already in juli.c



@@ -508,7 +509,7 @@ static int __devinit revo_init(struct snd_ice1712 *ice)
  		ice->gpio.i2s_mclk_changed = revo_i2s_mclk_changed;
  		break;
  	case VT1724_SUBDEVICE_REVOLUTION51:
-		ice->num_total_dacs = 6;
+		ice->num_total_dacs = 8;
  		ice->num_total_adcs = 2;
  		break;

Enables additional snd_vt1724_mixer_pro_analog_route controls for the 
new channels, we do not need them in Juli monitoring (ice1724 does not 
process these channels, their i2s lines go straight from adc/spdif 
receiver to the DAC chip via the Xilinx FPGA array.

I do not have the card available anymore, perhaps anyone could please check?

Thanks,

Pavel.
