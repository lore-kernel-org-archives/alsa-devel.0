From: Paul Vojta <vojta@Math.Berkeley.EDU>
Subject: Re: another device for opl3sa2
Date: Sun, 8 Jul 2007 01:02:24 -0700
Message-ID: <20070708080224.GA14178@math.berkeley.edu>
References: <20070703002739.GA27389@math.berkeley.edu>
	<s5hfy45ajk1.wl%tiwai@suse.de>
	<20070704022423.GA2012@math.berkeley.edu>
	<s5h4pkka6tq.wl%tiwai@suse.de>
	<20070705080302.GA6818@math.berkeley.edu>
	<s5hk5te6hku.wl%tiwai@suse.de>
	<20070706074136.GA4460@math.berkeley.edu>
	<s5hy7ht50ir.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.math.berkeley.edu (mail.Math.Berkeley.EDU [169.229.58.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FA0A243E0
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Jul 2007 10:02:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy7ht50ir.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 06, 2007 at 11:45:00AM +0200, Takashi Iwai wrote:
> 0x0b = CS4231_TEST_INIT, and 0x20 = CS4231_CALIB_IN_PROGRESS.
> At least, mce_down() should show messages if the calibration gets
> timeout.  Did you see any related messages?  Or didn't you build with
> --with-debug=full?

I didn't build with --debug=full.  I've been using ALSA as supplied with
linux kernel 2.6.21.1, and built without CONFIG_SND_DEBUG or
CONFIG_SND_DEBUG_DETECT

I have now switched to 2.6.21.6, and turned on both of CONFIG_SND_DEBUG*.
I also uncommented the printk() calls in mce_down(), and moved the first
one down below the definition of the variable 'timeout'.

Here are the kernel messages I got:

Device opl3sa2:

Initialization

ALSA sound/isa/cs423x/cs4231_lib.c:1015: cs4231: port = 0x534, id = 0xa
(1) timeout = 12
(1) timeout = 95
(1) timeout = 31
(1) timeout = 73
(1) timeout = 80
(1) timeout = 72
(1) timeout = 92


Ran aplay first time (no sound)

ALSA sound/isa/cs423x/cs4231_lib.c:331: mce_down [0x0] - auto calibration time out (0)
(1) timeout = 72

Ran aplay second time

(1) timeout = 72


Device cs4232:

Initialization

ALSA sound/isa/cs423x/cs4231_lib.c:1015: cs4231: port = 0x534, id = 0xa
ALSA sound/isa/cs423x/cs4231_lib.c:1021: CS4231: VERSION (I25) = 0x80
(1) timeout = 23
(1) timeout = 95
(1) timeout = 11
(1) timeout = 73
(1) timeout = 80
(1) timeout = 72
(2) timeout = 495, jiffies = -64562
(3) jiffies = -64558
(4) jiffies = -64558
ALSA sound/isa/cs423x/cs4231_lib.c:383: mce_down - exit = 0xb
(1) timeout = 92


Ran aplay first time

ALSA sound/isa/cs423x/cs4231_lib.c:331: mce_down [0x0] - auto calibration time out (0)
(1) timeout = 72
(2) timeout = 500, jiffies = -45004
(3) jiffies = -45000
(4) jiffies = -45000
ALSA sound/isa/cs423x/cs4231_lib.c:383: mce_down - exit = 0xb


Ran aplay second time

(1) timeout = 72


--Paul Vojta, vojta@math.berkeley.edu
