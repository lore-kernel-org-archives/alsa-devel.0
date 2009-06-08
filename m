From: Gernot Kohlhaas <gernot.kohlhaas@googlemail.com>
Subject: SB X-Fi driver fixes (Re: Testers wanted: New SB X-Fi
 driver)
Date: Mon, 08 Jun 2009 20:35:27 +0200
Message-ID: <4A2D59EF.9080708@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f218.google.com (mail-fx0-f218.google.com
	[209.85.220.218])
	by alsa0.perex.cz (Postfix) with ESMTP id C3BBA24554
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 20:35:29 +0200 (CEST)
Received: by fxm18 with SMTP id 18so3368033fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 11:35:29 -0700 (PDT)
References: s5hbpoz3pbj.wl%tiwai@suse.de
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

Okay... Sorry... Forget what I just wrote...
Seems to be my 20 to 51 solution with the mentioned LADSPA Low Pass Filter.
"default" device is just playing fine.

my .asoundrc:
pcm.xfi
{
  type hw
  card 0
  channels 6
}

ctl.xfi
{
  type hw
  card 0
}

pcm.ch51dup {
         slave.pcm "plug:lowpass51"
         slave.channels 6
         type route
         ttable.0.0 1
         ttable.1.1 1
         ttable.0.2 1
         ttable.1.3 1
         ttable.0.4 0.5
         ttable.1.4 0.5
         ttable.0.5 1
         ttable.1.5 1
}

pcm.lowpass51 {
    type ladspa
    slave.pcm default
    path "/usr/lib/ladspa"
    plugins {
        0 {
            id 1098 # Identity (Audio) (1098/identity_audio)
            policy duplicate
            input.bindings.0 "Input";
            output.bindings.0 "Output";
        }

        1 {
            id 1672
            policy none
            input.bindings.5 "Input";
            output.bindings.5 "Output";
            input {
                controls [ 120 2 ]
            }
        }
    }
}
-- 
http://www.gnupp.de/verschluesselung/warum.html
Key ID: 0x4C0B2250
Key: http://home.arcor.de/mr_maniac/ANDERES/public.gpg
