From: Adam Jiang <jiang.adam@gmail.com>
Subject: How to implement capture_switch control?
Date: Mon, 20 Jun 2011 16:15:38 +0900
Message-ID: <BANLkTikZYqdQJh6T1_XwpcxcTb=m1qOuUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 409101037FF
	for <Alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 09:15:39 +0200 (CEST)
Received: by yxt3 with SMTP id 3so2541582yxt.38
	for <Alsa-devel@alsa-project.org>; Mon, 20 Jun 2011 00:15:38 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello list,

I have a device with wm8903 codec. To support mute/unmute capture
signal, I was trying to enable/disable PGA on this codec from user
space application like

snd_ctl_elem_value_set_boolean("Left Input PGA Switch", 0, 0)

That means the mute/unmute function became platform dependent. I got
the idea to support mute/unmute function with enabling/disabling
capture switch. However, the function

snd_mixer_selem_has_capture_switch()

alwasy return false. I guess something is missing in my driver. Could
you please give some bright how could I use capture switch to
mute/unmute a channel. How could I implement capture_switch control
properly? Thank you!

/Adam
