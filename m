From: maruthi srinivas <maruthi.srinivas.b@gmail.com>
Subject: pulseaudio external mic jack detection - ASoC based
	card
Date: Wed, 8 Jul 2015 16:33:13 +0530
Message-ID: <CANv6ZMYHA7V9Dt0xfxS6jdy5WTbho28p=7p9ZLZNw_tsSQbmfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f50.google.com (mail-qg0-f50.google.com
 [209.85.192.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D8D92605CB
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 13:03:15 +0200 (CEST)
Received: by qget71 with SMTP id t71so97682687qge.2
 for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2015 04:03:13 -0700 (PDT)
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

I have a issue with mic jack status in Ubuntu "sound settings"  UI.  When
external mic is removed, UI still shows Mic.
When compared to HD Azalia driver, UI shouldn't show any external Mic jack
information, if it is removed.

Codec driver I use reports jack status properly and uses
snd_soc_jack_report().
/proc/interrupts, /dev/input/eventX  reflects jack activity. But the same
is not reflected in UI.

I want to know how pulseaudio detect jack status for drivers which follow
ALSA SoC architecture.
Does it read from any event from /dev/input/eventX ?

Please help in understanding.

Regards,
Maruthi
