From: "Steven King" <steven.king.80@gmail.com>
Subject: Intel HDA Driver - Bug
Date: Thu, 26 Jul 2007 16:32:00 +0100
Message-ID: <af8dbbad0707260832t6d6d2182kbac2a6ff2ad8a88a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 10CE924407
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jul 2007 17:32:02 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so396249wri
	for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2007 08:32:02 -0700 (PDT)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Hi,

I have been trying to get the sound on my Dell Inspiron 1720 laptop
running under Debian Etch (STAC 9205). Originally, I could only get
sound through the main speakers, there was no headphone sound or mic.

I downloaded the latest alsa-drivers package (1.0.14), compiled it and
installed it. I received the following messages (and the device would
not register itself):

hda_intel: azx_get_response timeout, switching to polling mode...
hda_intel: azx_get_response timeout, switching to single_cmd mode...

I started digging into the driver code and found an issue with one of
the routines going outside an array.

The offending code is (all in patch_sigmatel):
static void stac92xx_set_config_regs(struct hda_codec *codec)
{
// ...
for (i = 0; i < spec->num_pins; i++) {
// ...
}

And in:
static int patch_stac9205(struct hda_codec *codec)
{
// ..
spec->num_pins = 14 ; //ERROR
// ..
}

However, there are only 12 pins with 12 corresponding NIDs and default
configuration so in stac92xx_set_config_regs it accesses
spec->pin_configs[i] and spec->pin_nids[i] outside of bounds.

Fix: Add a define (STAC_9205_MAX_PINS = 12) and use for array defines
and num_pins.

The driver loads now, but I still only have sound out the main
speaker. If I get rid of the configuration sent to the chipset
altogether. I get sound through Headphone and Speakers (with detect
working on HP), but still no MIC.

How can I add support for my Dell as I don't know the configuration to
use or am I missing something here?

Thanks,

Steve
