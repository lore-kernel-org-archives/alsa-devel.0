From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 1/3] Define "sysdefault" PCM and control
Date: Mon, 12 Sep 2011 09:27:19 +0800
Message-ID: <CAN8cciamqNcQD_i+tD2T5yGAs0TJUeEHAdkuEA=n2kNNiYOK4A@mail.gmail.com>
References: <s5hk4b5w7aq.wl%tiwai@suse.de>
	<s5hipqpw798.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 32E8C103820
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 03:27:20 +0200 (CEST)
Received: by fxe22 with SMTP id 22so2039598fxe.38
	for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2011 18:27:20 -0700 (PDT)
In-Reply-To: <s5hipqpw798.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/7/26 Takashi Iwai <tiwai@suse.de>:
> When "default" PCM and control definitions are overwritten by others
> like PulseAudio setup, the original system-default defition is lost.
> This is a problem when PA is temporarily (or intentionally) disabled
> and user wants to use the default dmix.

how can the system upgrade Pulseaudio package without stopping PA server ?

is there any official way for user to temporiarily or intentionally
disabled pulseaudio without uninstal pulseaudio or alsa-pulse plugin ?

override alsa-pulse plugin seem only affect those alsa application
only, it seem that those application which use pulse api can still
autospawn PA server
