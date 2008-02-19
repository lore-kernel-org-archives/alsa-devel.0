From: "Daniele (Mastro)" <daniele.bilug@gmail.com>
Subject: Re: Notebook Toshiba satellite x200-21g with realtek
 snd-hda-intel audio device still not supported (codec ALC268)
Date: Tue, 19 Feb 2008 16:03:18 +0100
Message-ID: <47BAEFB6.8040209@gmail.com>
References: <47672BCB.9080608@gmail.com>	<476912F3.8090609@gmail.com>	<476A2BCC.4060109@gmail.com>	<s5h1w9h4g5d.wl%tiwai@suse.de>	<47727C6C.6080401@gmail.com>	<1198815321.3732.229.camel@razman.gruemaster.com>	<47B06DEF.4070609@gmail.com>	<s5htzkfv5jp.wl%tiwai@suse.de>	<47B0D319.2000702@gmail.com>	<s5hd4r2v5g1.wl%tiwai@suse.de>	<47B23AB8.6000301@gmail.com>	<47B5D230.4050402@gmail.com>	<47B9C909.9010100@gmail.com>	<s5h3arpujri.wl%tiwai@suse.de>	<47BAE549.2080009@gmail.com>
	<s5hzltxt3oy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B626103933
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 16:03:27 +0100 (CET)
Received: by ik-out-1112.google.com with SMTP id b32so735080ika.0
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 07:03:26 -0800 (PST)
In-Reply-To: <s5hzltxt3oy.wl%tiwai@suse.de>
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

Takashi Iwai ha scritto:
> The fix is basically the widget connection of NID 0x23 (and 0x24).
> This was uninitialized and thus pointed the wrong widget.
> Unfortunately, this connection couldn't be changed because you
> apparently have only one input source.  The patch fixes this issue.

tried the new patch
(i've compiled a today snapshot and then manually downloaded the last 
patch_realtek.c version)

the "front mic" capture now works..
i've 2 control: front mic and mic.. only mic works
but i've a lot of crappy noise...
http://www.mediafire.com/?c1c1jly9n7e

download this little .wav file i recorded with:

arecord -vv -f S16_LE -c1 -r48000 -d 5 test.wav

NOTE: while recording i see the "bar" always at 99%

thanks for your support.. do you have any idea on what's the cause of 
that noise?

-- 
Daniele
