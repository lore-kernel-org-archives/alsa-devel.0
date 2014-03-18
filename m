From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v5] ASoC: add RT286 CODEC driver
Date: Tue, 18 Mar 2014 12:41:41 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D73A0212@RTITMBSV03.realtek.com.tw>
References: <1394521896-27721-1-git-send-email-bardliao@realtek.com>
 <20140314191244.GZ366@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A175326072A
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 13:41:50 +0100 (CET)
In-Reply-To: <20140314191244.GZ366@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Saturday, March 15, 2014 3:13 AM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Oder Chiou;
> Gustaw Lewandowski
> Subject: Re: [PATCH v5] ASoC: add RT286 CODEC driver
> 
> On Tue, Mar 11, 2014 at 03:11:36PM +0800, bardliao@realtek.com wrote:
> > From: Bard Liao <bardliao@realtek.com>
> >
> > This patch adds the ALC286 codec driver.
> >
> > ALC286 is a dual mode codec, which can run as HD-A or I2S mode.
> > It is controlled by HD-A verb commands via I2C protocol.
> 
> Some or all of this documentation needs to end up in the code, we need to be
> able to understand and maintain the code going forwards and while the
> commit message is going to be kept it's still useful if the code can be followed.
> Right now that's extremely hard.

I will put these description in the code.

> 
> > The following is the I/O difference between ALC286 and general I2S codecs.
> > 1. A HD-A verb command contains three parts, NID, VID, and PID.
> >    And an I2S command contains only two parts: address and data.
> 
> It'd probably help to explain waht these are.

RT286 use verb commands to control the codec.
A verb command contains three parts, NID, VID, and PID.
For example, if I want to unmute headphone, I should set:
VID = 3'h (Set Amplifier Gain)
NID = 22'h (headphone)
PID = b000'h (Set left, right output unmute)

Below is the description in rt286 datasheet.
In SOC mode CODEC can ONLY be access via I2C, and CODEC works as slave mode and slave ID is 38'h. therefore HD-A
verb needs to be translated via I2C protocol, no matter Read or Write HD-A command, 32 bits(8*4) command code must be
issued by I2C master to compose 32 bits HD-A verb, CODEC will decode the verb, if write verb(ex: HD-A verb: 2h) was
decoded, the target NID will be set to target setting, if Read verb(ex: HD-A verb: Ah) was decoded, CODEC will response the
response 32 bits(8*4) response via normal I2C protocol, detail protocol please refer below.

I draw a picture below to show the I2C protocol of rt286.

I2C Write:
|1|     7      | 1 |1|   4   |   4   |1|   4   |  4     |1|  8    |1|    8     |1|1
|S|Device Address|W|A|Reserved|NID[7:4]|A|NID[3:0]|VID[11:8]|A|VID[7:0]|A|Payload[7:0]|A|P

I2C Read:
|1|     7      |1 |1|   4    |   4   |1|   4   |  4    |1|   8   |1|     8    |1|1|
|S|Device Address|W|A|Reserved|NID[7:4]|A|NID[3:0]|VID[11:8]|A|VID[7:0]|A|Payload[7:0]|A|S|->
       8      |1|     8        |1|       8     |1|        8   |1 |     8     |1 |1
->Device Address|R|RD_DATA[31:24]|A|RD_DATA[23:16]|A|RD_DATA[15:8]|A|RD_DATA7:0]|NA|P

> 
> > 2. Not only the register address is written, but the read command also
> >    includes the entire write command.
> > 3. rt286 uses different registers for read and write the same bits.
> > As a result, standard regmap is difficult to be used on ALC286.
> > We don't request a standard I/O by snd_soc_codec_set_cache_io anymore.
> > Now we have ,reg_write and .reg_read functions for ALC286's I/O.
> > And we don't use cache due to item 3 above.
> > Some dummy registers (address <= 0xff) are defined for dapm routing.
> > Thhe dummy registers are cache only.
> 
> Don't use dummy registers, DAPM already has virtual controls of various kinds
> - if you need more let's extend them.  Storing data in virtual registers just
> makes things confusing and fragile.  Some older CODEC drivers did it and
> they're harder to work with now than they should be.

Use SOC_DAPM_SINGLE_VIRT?

> 
> > Due to item 2 above, HD-A verb commands are put into the address part of
> regmap.
> > When we issue HD-A verb write commands, the data part of regmap is zero.
> 
> I'm having a really hard time understanding how this follows.  We do have
> some other devices that do things like have multi-level register addresses with
> registers collected in pages.  By analogy here what I'd expect to see is
> something which combines the various pieces of addressing information into a
> bitfields within a single number that can be used as a register address.
> 
> Or perhaps this just isn't anything like a register map at all?
> Whatever is going on something that ignores the value part of the regmap
> interfaces doesn't seem like it is a very good fit.

I draw a general I2C protocol below.
I2C Write:
S|Device Address|W|A|Register Address|A|Data Byte High|A|Data Byte Low|A|P
I2C Read:
S|Device Address|W|A|Register Address|A|S|Device Address|R|A|Data Byte High|A|Data Byte Low|A|P

Usually, we call the data before " S|Device Address|R|" register address.
But in rt286's i2c read protocol, we have an entire write command before " S|Device Address|R|".

If I combine NID and VID to be used as a register address, and let PID as register value,
it will be very difficult to define(or use) a _update_btis function.
Because I need to put all NID, VID and PID in the register address area when I issue a I2C read command.
So, I put all NID, VID and PID in the register address area no matter read or write command is issued.
As a result, we don't use the register value area when we use regmap_write.
That's why the register value area is always nothing(zero) when we call regmap_write.

> 
> ------Please consider the environment before printing this e-mail.
