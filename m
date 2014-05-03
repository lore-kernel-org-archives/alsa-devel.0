From: Delcypher <delcypher@gmail.com>
Subject: Regression Intel Corporation Haswell-ULT HD Audio
	Controller
Date: Sat, 3 May 2014 12:57:55 +0100
Message-ID: <CANNJ_zh6HXT-pdkOV9XpDor3J1aFVbi3zbHLyDnpgisu7DdMdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f180.google.com (mail-vc0-f180.google.com
 [209.85.220.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B5332608ED
 for <alsa-devel@alsa-project.org>; Sat,  3 May 2014 13:57:56 +0200 (CEST)
Received: by mail-vc0-f180.google.com with SMTP id hq16so6401388vcb.25
 for <alsa-devel@alsa-project.org>; Sat, 03 May 2014 04:57:55 -0700 (PDT)
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

Hi,

I was told to report my bug here because the ALSA bug tracker is no
longer active.

I'm having an issue with " Intel Corporation Haswell-ULT HD Audio
Controller" card which is inside the Dell XPS13 9333 developer edition
[1].

I've tried two different distributions

* Arch Linux (kernel 3.14)
Output of alsa-utlils-alsa-info.sh [2]

* Ubuntu 14.04 LTS (kernel 3.13)
Output of alsa-utlils-alsa-info.sh [3]

The card behaves correctly under Ubuntu but under Arch Linux I've
observed the following issues.

- The microphone does not work correctly. In alsamixer I select
"Internal Mic" as my capture device but when I do

$ arecord -d 5 test.wav
$ aplay test.wav

test.wav contains silence.

I've also tried enabling/disabling "CAPTURE" on the Capture channel at
the same time - I don't really understand why this channel is here
(seems a little bizarre) but enabling/disabling "CAPTURE" on this
channel doesn't seem to make any difference anyway. Under Ubuntu the
"arecord... aplay" command works correctly.

- There probably isn't a way to reproduce this but when I first
installed Arch Linux the sound card was put in a state where the
headphone jack would not work at all. Sound would continue playing out
of the speakers when the headphone jack was inserted and no sound
would come out of the headphones. I did notice that if the headphone
jack was only partially inserted I would get some sound sent to one of
the headphones.

My intuition is that the card is probably being incorrectly
initialised because if you take a look at the output of
alsa-utils-alsa-info.sh and diff them. Two very big differences I
noticed were that

- The card name (from lscpi) is "Intel Corporation Haswell-ULT HD
Audio Controller" under Ubuntu but under Arch Linux it is "Intel
Corporation Device 0a0c"
- The card codec is "Realtek ALC668" under Ubuntu but is "Realtek
ALC3661" under Arch Linux.

One interesting I did notice is that under Arch Linux it is possible
to use the microphone from the Audacity program by selecting "HDA
Intel PCH: ALC3661Analog (hw0:0) Internal mic:0" as the input (this is
not the default). Unfortunately I know of no way to make other
applications use this.

Any thoughts on how to fix this?

[1] http://www.dell.com/uk/business/p/xps-13-linux/pd
[2] https://gist.github.com/delcypher/11367224
[3] https://gist.github.com/delcypher/11367302

Thanks,
Dan.
