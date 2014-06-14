From: "Scott D'Vileskis" <sdvileskis@gmail.com>
Subject: Trying to enable digital audio output - Intel HDA -
	AD1983
Date: Fri, 13 Jun 2014 23:20:46 -0400
Message-ID: <CAK_KU4a90_WVjFhbHXfOKN4gZqLyugSER+XPSnYpkdAviA6EhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f45.google.com (mail-qa0-f45.google.com
 [209.85.216.45])
 by alsa0.perex.cz (Postfix) with ESMTP id D102926500C
 for <alsa-devel@alsa-project.org>; Sat, 14 Jun 2014 05:20:47 +0200 (CEST)
Received: by mail-qa0-f45.google.com with SMTP id v10so4665058qac.4
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 20:20:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi--
I have a Lenovo M55 SFF desktop I use for a media center computer
(XBMCbuntu). It has the AD1983 chip on it. From the factory, it had 2
ports in the back (mic + speaker) , and 2 ports in the front (mic +
speaker). It also has an on-board speaker.

It never shipped with a SPDIF output, but I soldered a wire to the
AD1983 and installed an RCA jack on the back of the case. Earlier
versions of XBMC shipped with a different version of alsa, and I was
able to use this custom SPDIF output without issue for the last year
or two, but the current version only enables the 'proper'
inputs/outputs

I have tried editing the module options and specifying several
different models, but the documentation doesn't list any 'model'
options for the AD1983.

I suspect I need to overwrite the pin configs.
cat init_pin_configs:
0x05 0x01014010
0x06 0x0221401f
0x07 0x991301f0
0x08 0x02a19020
0x09 0x0181302e
0x0a 0x414511f0

[ 2421.907510] hda-codec: reconfiguring
[ 2421.980324] autoconfig: line_outs=1 (0x5/0x0/0x0/0x0/0x0) type:line
[ 2421.980328]    speaker_outs=1 (0x7/0x0/0x0/0x0/0x0)
[ 2421.980330]    hp_outs=1 (0x6/0x0/0x0/0x0/0x0)
[ 2421.980332]    mono: mono_out=0x0
[ 2421.980333]    inputs:
[ 2421.980335]      Mic=0x8
[ 2421.980336]      Line=0x9
[ 2421.981858] input: HDA Intel Front Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input34
[ 2421.984829] input: HDA Intel Line Out as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input33
[ 2421.985848] input: HDA Intel Line as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input32


Does anyone have any guidance for how I may re-enable the SPDIF on the
AD1983 when my BIOS disables it by default?

Where else should I look for information on pin configs?

Thanks!
