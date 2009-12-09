From: Marc Garnier <marc.garnier@heig-vd.ch>
Subject: Re: How to use soc API without codec driver
Date: Wed, 9 Dec 2009 07:39:19 +0100
Message-ID: <4B1F4617.1020307@heig-vd.ch>
References: <4B1E66DD.1000906@heig-vd.ch> <20091208145104.GC9018@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heig-vd.ch (mailcl1.heig-vd.ch [193.134.216.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 05B58244DC
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 07:39:20 +0100 (CET)
In-Reply-To: <20091208145104.GC9018@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

You mean I just have to use snd_soc_register_dai()? Things like 
soc_init_card() and snd_soc_new_pcms() are not mandatory?
So, i think code like this one could be ok :

#define Q2686_RATES (SNDRV_PCM_RATE_8000_192000)

#define Q2686_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
    SNDRV_PCM_FMTBIT_S24_LE)

static struct snd_soc_dai_ops q2686_dai_ops = {
};

struct snd_soc_dai q2686_dai = {
    .name = "Q2686",
    .playback = {
        .stream_name = "Playback",
        .channels_min = 2,
        .channels_max = 2,
        .rates = Q2686_RATES,
        .formats = Q2686_FORMATS,
    },
    .capture = {
        .stream_name = "Capture",
        .channels_min = 2,
        .channels_max = 2,
        .rates = Q2686_RATES,
        .formats = Q2686_FORMATS,},
    .ops = &wm8728_dai_ops,
};
EXPORT_SYMBOL_GPL(q2686_dai);

static int __init q2686_modinit(void)
{
    return snd_soc_register_dai(&q2686_dai);
}
module_init(q2686_modinit);

static void __exit q2686_exit(void)
{
    snd_soc_unregister_dai(&q2686_dai);
}
module_exit(q2686_exit);

MODULE_DESCRIPTION("ASoC Q2686 driver");
MODULE_AUTHOR("Marc Garnier");
MODULE_LICENSE("GPL");

Mark Brown wrote:
> On Tue, Dec 08, 2009 at 03:46:53PM +0100, Marc Garnier wrote:
>
>   
>> I need to receive and transmit PCM data through SSC port of a sam9261 to 
>> a device which doesn't have any kind of I/O controls (neither i2c nor 
>> spi). So, I wonder how to deal with the codec driver side.
>> Someone could explain me what are the minimum requirements to write a 
>> Asoc driver of this kind?
>>     
>
> There's a couple of drivers for such CODECs in the tree already - have a
> look at the wm8727 driver for one example.  You need to register at
> least a DAI with whatever the capabilities of the hardware are and can
> leave all the operations blank.
>   
