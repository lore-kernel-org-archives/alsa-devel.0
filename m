From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH - try2] ASoC: TPA6130A2 amplifier driver
Date: Fri, 09 Oct 2009 16:10:31 +0300
Message-ID: <1255093831.30157.207.camel@eenurkka-desktop>
References: <1255092941-17586-1-git-send-email-peter.ujfalusi@nokia.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 76D2A103A10
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 15:12:54 +0200 (CEST)
In-Reply-To: <1255092941-17586-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-10-09 at 14:55 +0200, Ujfalusi Peter (Nokia-D/Tampere)
wrote:
> +static int tpa6130a2_i2c_write(int reg, u8 value)
> +{
> +       struct tpa6130a2_data *data;
> +       int val = 0;
> +
> +       BUG_ON(tpa6130a2_client == NULL);
> +       data = i2c_get_clientdata(tpa6130a2_client);
> +
> +       if (data->power_state) {
> +               val = i2c_smbus_write_byte_data(tpa6130a2_client, reg, value);
> +               if (val < 0)
> +                       dev_err(&tpa6130a2_client->dev, "Write failed\n");
> +       }
> +
> +       /* Either powered on or off, we save the context */
> +       data->regs[reg] = value;
> +
> +       return val;
> +}
> +

<snip>

> +static void tpa6130a2_channel_enable(u8 channel, int enable)
> +{
> +       struct  tpa6130a2_data *data;
> +       u8      val;
> +
> +       BUG_ON(tpa6130a2_client == NULL);
> +       data = i2c_get_clientdata(tpa6130a2_client);
> +
mutex_lock()
> +       if (enable) {
> +               /* Enable channel */
> +               /* Enable amplifier */
> +               val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
> +               val |= channel;
> +               tpa6130a2_i2c_write(TPA6130A2_REG_CONTROL, val);
During the tpa6130a2_i2c_write, you read the data->power_state, that
may change it's state meanwhile (preempted). Thus, I suggest you using
the mutex to cover all i2c writes. (and all tpa read <-> write cycles,
so that things are consistent?) 

A call to tpa6130a2_power() -> preemted over somewhere here, you may
have i2c accesses to a chip that's not powered up?

> +
> +               /* Unmute channel */
> +               val = tpa6130a2_read(TPA6130A2_REG_VOL_MUTE);
> +               val &= ~channel;
> +               tpa6130a2_i2c_write(TPA6130A2_REG_VOL_MUTE, val);
> +       } else {
> +               /* Disable channel */
> +               /* Mute channel */
> +               val = tpa6130a2_read(TPA6130A2_REG_VOL_MUTE);
> +               val |= channel;
> +               tpa6130a2_i2c_write(TPA6130A2_REG_VOL_MUTE, val);
> +
> +               /* Disable amplifier */
> +               val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
> +               val &= ~channel;
> +               tpa6130a2_i2c_write(TPA6130A2_REG_CONTROL, val);
> +       }
mutex_unlock() ?
> +}
> +
