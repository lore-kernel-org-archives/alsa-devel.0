From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: open /dev/snd/seq failed
Date: Sun, 11 Jun 2006 13:11:00 -0400
Message-ID: <1150045861.14253.119.camel@mindpipe>
References: <E1FpPt7-0001Z8-7E@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <E1FpPt7-0001Z8-7E@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: John Rigg <ad@sound-man.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-06-11 at 14:21 +0100, John Rigg wrote:
> snd_ice1712            67360  0 
> snd_ice17xx_ak4xxx      6720  1 snd_ice1712
> snd_ak4xxx_adda         9216  2 snd_ice1712,snd_ice17xx_ak4xxx
> snd_cs8427             12672  1 snd_ice1712
> snd_ac97_codec        103868  1 snd_ice1712
> snd_pcm                96008  2 snd_ice1712,snd_ac97_codec
> snd_timer              27336  1 snd_pcm
> snd_page_alloc         13904  1 snd_pcm
> snd_ac97_bus            4928  1 snd_ac97_codec
> snd_i2c                 8192  2 snd_ice1712,snd_cs8427
> snd_mpu401_uart        10432  1 snd_ice1712
> snd_rawmidi            29664  1 snd_mpu401_uart
> snd_seq_device         11792  1 snd_rawmidi
> joydev                 13120  0 
> evdev                  13952  0 
> shpchp                 47008  0 
> snd                    62304  10 snd_ice1712,snd_ak4xxx_adda,snd_cs8427,snd_ac97_codec,snd_pcm,snd_timer,snd_i2c,snd_mpu401_uart,snd_rawmidi,snd_seq_device

Of course it won't work, snd-seq-midi is not loaded.

Lee
