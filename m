From: Hans de Goede <hdegoede@redhat.com>
Subject: Cherry Trail + RT5645 devices analog microphone not
	working.
Date: Sun, 24 Dec 2017 11:42:59 +0100
Message-ID: <d42279d7-0350-563f-fca7-27f32cb9e9ee@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 12CC726698E
 for <alsa-devel@alsa-project.org>; Sun, 24 Dec 2017 11:43:01 +0100 (CET)
Received: by mail-wm0-f45.google.com with SMTP id y82so30112472wmg.1
 for <alsa-devel@alsa-project.org>; Sun, 24 Dec 2017 02:43:01 -0800 (PST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Bard,

I've been looking into getting the microphone to work on
some Cherry Trail + RT5645 devices with what appears to
be a simple analog microphone.

You can see the microphone on one of the models I'm trying
to get it to work on soldered onto the right side of the PCB
here: https://i.imgur.com/bJzBQWe.jpg

I'm using this ucm config:

https://fedorapeople.org/~jwrdegoede/chtrt5645/

Which is basically Pierre-Louis Bossart's config from:
https://github.com/plbossart/UCM

Adjusted because the devices all have a mono speaker.

I've been trying to get this to work myself and I can get
some sound while recording by adding:

                 cset "name='RECMIXL BST2 Switch' on"
                 cset "name='RECMIXR BST2 Switch' on"

But then I mainly get noise, I do get some sound from the
microphone if I talk really really loudly, but it is
barely above the noise-floor. I've the feeling that BST2
is only picking up the microphone via cross-talk and
that BST1 indeed is the correct input, but for some reason
I get complete silence when recording when only BST1 is
selected in the RECMIXR, and yes I've checked / set the
"IN1 boost volume".

TL;DR: I'm trying to get an analog mic to work on 3
different models Cherry Trail + RT5645 devices and I've
been unable to get this to work. I've put a registerdump
of the rt5645 with gnome-sound-recorder running here:
https://fedorapeople.org/~jwrdegoede/rt5645-mic-red.dump

Any insights / help with this would be very much
welcome.

Regards,

Hans
