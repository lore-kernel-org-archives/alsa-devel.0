From: Simon Ho <simon.ho.cnxt@gmail.com>
Subject: Re: [PATCH v4 2/2] ASoC: Add support for Conexant
 CX2092X DSP
Date: Thu, 6 Apr 2017 09:32:36 +0800
Message-ID: <20170406013236.GA3818@GMAIL.COM>
References: <cover.1491387037.git.simon.ho@conexant.com>
 <9c6e21ff6c43779601014b8a7f5bb108b5a88e99.1491387037.git.simon.ho@conexant.com>
 <20170405151704.GA3412@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 410E1266C0C
 for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2017 03:32:42 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id g2so4751304pge.2
 for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2017 18:32:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170405151704.GA3412@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Simon Ho <simon.ho@conexant.com>, tiwai@suse.com, lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 05, 2017 at 04:17:04PM +0100, Charles Keepax wrote:
> On Wed, Apr 05, 2017 at 06:27:13PM +0800, simon.ho.cnxt@gmail.com wrote:
> > From: Simon Ho <simon.ho@conexant.com>
> > 
> > Initial commit of Conexant CX20921/CX20924 I2S Audio DSP driver
> > 
> > The CX2092X devices are designed for virtual assisant application need to
> > be always open, listening for users to summon it. There is no any power
> > saving mode support on this device. The processed voice data will be sent
> > to automatic speech recognition (ASR) application for further processing.
> > 
> > Signed-off-by: Simon Ho <simon.ho@conexant.com>
> > ---
> 
> Just a couple of very minor points.
> 

Thank you for your useful comments, I will fix them.

> > +static int cx2092x_sendcmd(struct snd_soc_codec *codec,
> > +			   struct cx2092x_cmd *cmd)
> > +{
> > +	struct cx2092x_priv *cx2092x = snd_soc_codec_get_drvdata(codec);
> > +	int ret = 0;
> > +	int num_32b_words = cmd->num_32b_words;
> > +	unsigned long time_out;
> > +	u32 *i2c_data = (u32 *)cmd;
> > +	int size = num_32b_words + 2;
> > +
> > +	/* calculate how many WORD that will be wrote to device*/
> > +	cmd->num_32b_words = cmd->command_id & CX2092X_CMD_GET(0) ?
> > +			     CX2092X_CMD_SIZE : num_32b_words;
> > +
> > +	/* write all command data except fo frist 4 bytes*/
> > +	ret = regmap_bulk_write(cx2092x->regmap, 4, &i2c_data[1], size - 1);
> > +	if (ret < 0) {
> > +		dev_err(cx2092x->dev, "Failed to write command data\n");
> > +		goto LEAVE;
> 
> All caps for a label is a bit unusual probably would be more
> normal kernel style to make this lower case.
> 
> > +	}
> > +
> > +	/* write first 4 bytes command data*/
> > +	ret = regmap_bulk_write(cx2092x->regmap, 0, i2c_data, 1);
> > +	if (ret < 0) {
> > +		dev_err(cx2092x->dev, "Failed to write command\n");
> > +		goto LEAVE;
> > +	}
> > +
> > +	/* continuously read the first bytes data from device until
> > +	 * either timeout or the flag 'reply' is set.
> > +	 */
> > +	time_out = msecs_to_jiffies(2000);
> > +	time_out += jiffies;
> > +	do {
> > +		regmap_bulk_read(cx2092x->regmap, 0, &i2c_data[0], 1);
> > +		if (cmd->reply == 1)
> > +			break;
> > +		mdelay(10);
> 
> Do you really want to use mdelay's, they are busy wait loops
> so thrash the processor, a usleep_range or an msleep might be a
> more friendly.
> 
> Thanks,
> Charles
