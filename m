From: Jeffrey Baker <jwbaker@acm.org>
Subject: Re: intel8x0, ad198x, no sound
Date: Sun, 18 May 2003 14:17:25 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030518211725.GC3375@noodles>
References: <20030518194617.GA3302@noodles> <20030518202706.GA3466@noodles>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20030518202706.GA3466@noodles>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, May 18, 2003 at 01:27:06PM -0700, Jeffrey Baker wrote:
> On Sun, May 18, 2003 at 12:46:17PM -0700, Jeffrey Baker wrote:
> > This is related to the mail last week regarding the Asus P4PE with
> > ad1980 sound chip.  I got an Asus P4P800 with the ad1985.  The
> > intel8x0 driver works but there are problems with the sound routing.
> > There is no sound at all coming from the main (line out) output.
> > If I plug headphones into the line in jack, there is sound but it
> > appears to be some kind of surround output, because it lacks all low
> > frequencies entirely.  No sound comes from the microphone jack.
> > 
> > I think the problem may be related to the "intelligent" jack sensing
> > built into this hardware.  It is supposed to be able to detect when
> > you've got your headphones plugged into the wrong jack and reroute
> > the audio.  Either that, or the chip is stuck in some surround mode
> > that isn't quite working.
> 
> Hi.  It helps to read the datasheet.  Although this isn't stated in
> the motherboard's documentation, the headphone amplifier is, in
> fact, connected to the line-in jack.  There is a register (0x76)
> which controls the input for the headphone amp.  It can be either 0
> for the surround DAC or 1 for the mixer.  By default it is 0.  This
> explains why I am hearing high-passed surround audio from the
> headphones.
> 
> I glanced at intel8x0.c, but it wasn't immediately obvious how to
> set registers on the codec.

Ah OK.  I added this patch to ac97_codec.c:

--- ac97_codec.c        2003-04-11 00:45:23.000000000 -0700
+++ /root/ac97_codec.c  2003-05-18 14:12:27.000000000 -0700
@@ -104,6 +104,7 @@
 { 0x41445363, 0xffffffff, "AD1886A",           patch_ad1881,   NULL },
 { 0x41445370, 0xffffffff, "AD1980",            patch_ad1980,   NULL },
 { 0x41445372, 0xffffffff, "AD1981A",           patch_ad1881,   NULL },
+{ 0x41445375, 0xffffffff, "AD1985",            patch_ad1980,   NULL },
 { 0x414c4300, 0xfffffff0, "RL5306",            NULL,           NULL },
 { 0x414c4310, 0xfffffff0, "RL5382",            NULL,           NULL },
 { 0x414c4320, 0xfffffff0, "RL5383",            NULL,           NULL },


This makes proper headphone-power audio emerge from the line-out
jack.  But, the main level is controlled by the "Surround" slider in
the mixer, which isn't exposed to the OSS mixer interface.  

It seems like mixer routing for this codec is a little screwed up.
If the SURR_OUT and LINE_OUT are going to be swapped once in
software (reg 0x76 <- 0x420), and then the motherboard vendor is
swapping them again in hardware (by wiring the SURR_OUT/HP_OUT pin
to the line out and the LINE_OUT to the LINE_IN), it's all very
confusing.

What needs to happen to make the mixer sliders correspond to their
actual effects?

-jwb


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
