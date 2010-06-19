From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH] codecs/tlv320aic23: fix suspend/resume
Date: Sat, 19 Jun 2010 14:07:00 +0200
Message-ID: <4C1CB2E4.8060401@eukrea.com>
References: <1276937814-10510-1-git-send-email-eric@eukrea.com>
	<20100619105929.GB2409@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 29.mail-out.ovh.net (29.mail-out.ovh.net [87.98.216.213])
	by alsa0.perex.cz (Postfix) with SMTP id 2836610381B
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 14:07:04 +0200 (CEST)
In-Reply-To: <20100619105929.GB2409@opensource.wolfsonmicro.com>
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
Cc: anuj.aggarwal@ti.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Le 19/06/2010 12:59, Mark Brown a =E9crit :
> On Sat, Jun 19, 2010 at 10:56:54AM +0200, Eric B=E9nard wrote:
>> The PWR register actually can't be restored at resume because its
>> cached value was set to 0xFFFF when suspending and thus the initial
>> state won't be restored. Thus, sound doesn't work after resume (tested
>> on an i.MX27).
>
> What is the actual problem here?
>
aplay test.wav =3D> sound
echo mem > /sys/power/state =3D> system suspended
press button to wake up =3D> system resumed
aplay test.wav =3D> no sound

at wake up, the codec doesn't produce any sound and checking with a =

scope shows that the I2S interface (codec is master and thus generates =

the signals) is not working (no clock produced by the codec).

>> +	/* backup PWR register */
>> +	tmp =3D tlv320aic23_read_reg_cache(codec, TLV320AIC23_PWR);
>> +	/* turn off the codec */
>>   	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);
>
> On power down we put the CODEC into BIAS_OFF...
>
>> -	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
>> -
>
> ...then we bring the power back up on resume.  If there's a problem here
> it looks like the bias management functions need fixing but without
> knowing what the actual problem with the system is it's not clear what
> this is supposed to fix.
>
my understanding of the actual code is :

- at suspend :
tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);
will set PWR to 0xFFFF (all off) which is the expected behaviour

- at resume :
tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
will set PWR to 0xff7f (all off except DAC) as its value is restored =

from the register cache, which doesn't seems to be the expected =

behaviour unless I'm one more time mistaken.


You will find hereinafter log added to tlv320aic23_write concerning PWR =

register and reg value in tlv320aic23_set_bias_level (patch copy and =

pasted bellow so it may be line wrapped) :

boot :
tlv320aic23_set_bias_level : reg is 7
tlv320aic23_write write 047 to register R6

aplay :
tlv320aic23_set_bias_level : reg is 5f
tlv320aic23_write write 057 to register R6
(so DEVICE + OSC + DAC are on)
tlv320aic23_set_bias_level : reg is 47
tlv320aic23_write write 047 to register R6
(so DEVICE + OSC + OUT + DAC are on)

suspend :
tlv320aic23_set_bias_level : reg is 5f
tlv320aic23_write write ffff to register R6

resume :
tlv320aic23_write write ffff to register R6
tlv320aic23_set_bias_level : reg is ff7f
tlv320aic23_write write ff7f to register R6

aplay (after resume) :
tlv320aic23_set_bias_level : reg is ff7f
tlv320aic23_write write ff7f to register R6
(so DEVICE is on but DAC and OSC are off)
tlv320aic23_set_bias_level : reg is ff67
tlv320aic23_write write ff67 to register R6
(so DEVICE + OUT + DAC are on but OSC is off)

So do unless I'm mistaken the actual handling of PWR register is wrong =

as OSC bit stays OFF even after resume.

Eric

--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -95,6 +95,8 @@ static int tlv320aic23_write(struct snd_soc_codec =

*codec, unsigned int reg,
         data[1] =3D value & 0xff;

         tlv320aic23_write_reg_cache(codec, reg, value);
+printk("%s write %03x to register R%u\n", __func__,
+              value, reg);

         if (codec->hw_write(codec->control_data, data, 2) =3D=3D 2)
                 return 0;
@@ -556,7 +558,7 @@ static int tlv320aic23_set_bias_level(struct =

snd_soc_codec *codec,
                                       enum snd_soc_bias_level level)
  {
         u16 reg =3D tlv320aic23_read_reg_cache(codec, TLV320AIC23_PWR) & =

0xff7f;
-
+printk("%s : reg is %x\n", __FUNCTION__, reg);
         switch (level) {
         case SND_SOC_BIAS_ON:
                 /* vref/mid, osc on, dac unmute */
