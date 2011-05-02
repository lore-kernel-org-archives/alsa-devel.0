From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 08/10] ALSA: hda - Add support for Line-Out
 automute to Realtek auto-parser
Date: Mon, 2 May 2011 13:55:55 +0800
Message-ID: <BANLkTikHTAMmogmhjOJoO2-6aAb4MTgiGA@mail.gmail.com>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
	<1304097516-7258-9-git-send-email-tiwai@suse.de>
	<4DBBB1CA.8020508@canonical.com> <s5hliysavi0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DED81037E3
	for <alsa-devel@alsa-project.org>;
	Mon,  2 May 2011 07:55:57 +0200 (CEST)
Received: by fxm5 with SMTP id 5so4033178fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 01 May 2011 22:55:56 -0700 (PDT)
In-Reply-To: <s5hliysavi0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/30 Takashi Iwai <tiwai@suse.de>

> A
> I guess this should cover most of use-cases, and flexible enough for
> covering both old and new behavior.
>
>
>
But it still not easy to implement multi streaming playback using Front
Panel HP for those 8 or channels codec for the desktop

This would require switch "Independent HP" switch ON will need to turn off
"Auto mute" control and make this control  write protect and inactive
