From: Joachim Foerster <mls.JOFT@gmx.de>
Subject: How to enforce 32bit access?
Date: Tue, 02 Oct 2007 17:34:07 +0200
Message-ID: <1191339247.30745.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 459EA24349
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Oct 2007 17:34:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lorenz Kolb <lorenz.kolb@lkmail.de>
List-Id: alsa-devel@alsa-project.org

Hi ALSA devs,

(based on a Xilinx ML403, PPC405, OPB bus)
I have a custom sound controller, which allows 32bit write accesses to
its IO memory, only. The controller supports S16_LE, S16_BE, U16_LE,
U16_BE with min. and max. 2 channels (stereo), only! => So a frame has
to be 32bits wide and one frame has to be written at one point of time
(= one 32bit bus access).

Now, playing a 16kHz, S16_LE, Mono .wav-file with aplay invokes the
conversion framework of the alsa-lib. The following line of code (of
pcm_plugin.h) is executed:

conv_xx12_xx12: as_u16(dst) = as_u16c(src);

This is a 16bit access and thus fails with a Bus error/Kernel Oops.

Therefore my question is:

In my driver for the controller, how do I tell ALSA, that it is only
allowed to write in 32bit quantities?
Is this possible at all?
Or do I have to use a special .asoundrc file?

Thanks,
 Joachim

PS: 16bit, signed/unsigned, LE/BE, stereo (!) .wav files can be played
without any problem.
