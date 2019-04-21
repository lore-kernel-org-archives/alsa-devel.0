From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: sun4i-i2s: Wrong quirks for Allwinner A64 ?
Date: Sun, 21 Apr 2019 14:35:09 +0200
Message-ID: <CAJiuCceUaWJ=PMXzjJPz-bMVOJFkfWg0B3T-OwNncu0KSQvnVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marcus Cooper <codekipper@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>, Icenowy Zheng <icenowy@aosc.io>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm looking to port the sun4i-i2s drivers for Allwinner H6, but
regarding the quirks I found strange that H3 and A64 was so different.

I have analyzed the datasheet and using human reading comparison, I
have found only 3 minor differences in the registers.

H3 reference i have used : H3 Datasheet(Revision 1.0)
For A64 : A64 User Manual(Revision 1.1)

H3 is identical to A64 except H3 has new :
LRCKR_OUT bit(16) in PCM_CONTROL_REG
SDI_sync_sel Bit(31) in PCM_FMT0_REG
LRCKR_PERIOD Mask(29:20) in PCM_FMT0_REG

Regarding the quirks struct in the drivers and the commit log
sha1: 66ecce3325383c8304063e7d5a30f4374ef5a33e
ASoC: sun4i-i2s: Add compatibility with A64 codec I2S

    The I2S block used for the audio codec in the A64 differs from other 3
    I2S modules in A64 and isn't compatible with H3. But it is very similar
    to what is found in A10(sun4i). However, its TX FIFO is
    located at a different address.

It said that A64 is really different which I disagree, for me the H3
use the same IP as A64 with a little improvement.
Which seems logical because "The A64 is basically an Allwinner H3 with
the Cortex-A7 cores replaced with Cortex-A53 cores" (source
linux-sunxi.org)

I'm okay to send a patch to fix that but I don't have an H3 nor A64 to
test the modification.

Thanks,
Clement
