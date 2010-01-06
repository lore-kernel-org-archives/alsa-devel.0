From: Anisse Astier <anisse@astier.eu>
Subject: Mic Boost control problem with snd-hda-intel codec
	AL662 rev 1
Date: Wed, 6 Jan 2010 16:43:38 +0100
Message-ID: <20100106164338.2f3764bf@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 211B510382B
	for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2010 16:48:29 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id e12so2960073fga.2
	for <alsa-devel@alsa-project.org>; Wed, 06 Jan 2010 07:48:28 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

The Mic Boost control on a laptop seems to behave incorrectly. The
control has the flag "volume" instead of "cvolume", causing it to appear
in both the "Playback" and "Capture" tabs of alsamixer.
This wouldn't be a problem if it would just work in the Capture tab: it
doesn't.
When I modify it in Capture, it doesn't retain its value: it's gone after
i close alsamixer. But if i modify it in "Playback" it will retain its
value and the value will be mirrored by the Mic Boost in Capture (both
Mic Boost seem to reflect the same control, except one is RO, the other
is RW).

It's a minor a annoyance, but I'd like to fix it and have "Mic Boost"
appear only as a Capture control and retaining its value. Maybe I should
create a new mixer configuration for this hardware in patch_realtek.c, but
I don't know where to start. Bios autoprobing works for everything but
just what I mentioned.


My alsa-info.sh :
http://www.alsa-project.org/db/?f=fc17b509e532fc366eb2d5fe5ec9e6730c96c837

Any ideas? Where should I start?

Regards,

Anisse
