From: dustin@seznam.cz
Subject: Re: Functioning support for Prodigy 192
Date: Mon, 23 Apr 2007 14:01:27 +0200 (CEST)
Message-ID: <9327.23864-16621-2011795002-1177329687@seznam.cz>
References: <feca60390704230458h43404a8ao75c1261974d1962a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxh.seznam.cz (mxln.seznam.cz [212.80.76.44])
	by alsa0.perex.cz (Postfix) with SMTP id 78D5524854
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2007 14:01:29 +0200 (CEST)
In-Reply-To: <feca60390704230458h43404a8ao75c1261974d1962a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?us-ascii?Q?Takashi=20Iwai?= <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello, 

Back here again :)

While comparing media reading precision of various CD players I hit the following issues:

1. De-emphasis filter in AK4114 is turned on, distorting incoming data. A patch to disable:

diff -r aed6a15c9398 pci/ice1712/prodigy192.c
--- a/pci/ice1712/prodigy192.c  Mon Apr 23 11:54:41 2007 +0200
+++ b/pci/ice1712/prodigy192.c  Mon Apr 23 12:47:01 2007 +0200
@@ -714,7 +714,7 @@ static int prodigy192_ak4114_init(struct
 {
        static const unsigned char ak4114_init_vals[] = {
                AK4114_RST | AK4114_PWN | AK4114_OCKS0 | AK4114_OCKS1,
-               AK4114_DIF_I24I2S, /* ice1724 expects I2S and provides clock */
+               AK4114_DIF_I24I2S | AK4114_DEM0 , /* ice1724 expects I2S and provides clock, DEM0 disables deemphasis filter */
                AK4114_TX1E,
                AK4114_EFH_1024 | AK4114_DIT, /* default input RX0 */
                0,


2. All data recorded when master clock was provided by  AK4114 (Multi Track Internal Clock= IEC958 Input) had double the sampling rate. For each input sample there were two identical output samples in the file.

Here is where the FPGA on MIODIO gets introduced. Both MCKO1 and MCKO2 of ak4114 are fed to FPGA, which outputs master clock to SPMCLKIN of ice1724. Unfortunately my oscilloscope has just died, so experimentally I found out that only a combination of OCKS0=1, OCKS1 = 1 (128fs, 64fs output) and ice1724- VT1724_MT_I2S_MCLK_128X=0 (256fs input) yields correct sampling rate. In order for this to work the FPGA must double the MCK01 rate (I cannot check the frequency now).

It may actually make sense as it is probably the only way to support input sampling frequencies all the way up to 192kHz (128fs is max ak4114 can output at 192kHz) without having to switch the VT1724_MT_I2S_MCLK_128X bit in ice1724. In consumer mode the chips have no information about the sampling frequency (ak4114 does no detection) and the driver would not know when to set the bit.

The problem is that due to switching sequence of Multi Track Internal Clock enum the VT1724_MT_I2S_MCLK_128X stays set (from the previous 192kHz option). I think it should not be set for ice1724 slave mode at all, here is the patch which fixes the sampling rate.

Thanks,

Pavel.

diff -r aed6a15c9398 pci/ice1712/ice1724.c
--- a/pci/ice1712/ice1724.c     Mon Apr 23 11:54:41 2007 +0200
+++ b/pci/ice1712/ice1724.c     Mon Apr 23 13:57:19 2007 +0200
@@ -1666,7 +1666,11 @@ static int snd_vt1724_pro_internal_clock
        spin_lock_irq(&ice->reg_lock);
        oval = inb(ICEMT1724(ice, RATE));
        if (ucontrol->value.enumerated.item[0] == spdif) {
+               unsigned char i2s_oval;
                outb(oval | VT1724_SPDIF_MASTER, ICEMT1724(ice, RATE));
+               /* setting 256fs */
+               i2s_oval =  inb(ICEMT1724(ice, I2S_FORMAT));
+               outb( i2s_oval & ~VT1724_MT_I2S_MCLK_128X, ICEMT1724(ice, I2S_FORMAT));
        } else {
                rate = rates[ucontrol->value.integer.value[0] % 15];
                if (rate <= get_max_rate(ice)) {
