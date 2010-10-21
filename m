From: Jiri Slaby <jirislaby@gmail.com>
Subject: HDA: no sound [was: mmotm 2010-10-20-15-01 uploaded]
Date: Thu, 21 Oct 2010 09:41:08 +0200
Message-ID: <4CBFEE94.7020103@gmail.com>
References: <201010202233.o9KMXNoL008303@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BBF4610380E
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 09:41:15 +0200 (CEST)
Received: by fxm14 with SMTP id 14so3590239fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2010 00:41:15 -0700 (PDT)
In-Reply-To: <201010202233.o9KMXNoL008303@imap1.linux-foundation.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, mm-commits@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On 10/21/2010 12:01 AM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2010-10-20-15-01 has been uploaded to

Hi, I've lost sound with my intel hda (sigmatel) in this release
(regression against mmotm 2010-10-13-17-13).

All outputs were silented at level 0 after reboot, but even after
setting them non-zero in alsamixer -D hw, no sound can be heard by:
mplayer -ao alsa:device=hw /usr/share/sounds/alsa/Front_Center.wav

I don't knwo if it's related, but aplay complains like (even if I pass
-c 2):
aplay -D hw /usr/share/sounds/alsa/Front_Center.wav
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
aplay: set_params:1065: Channels count non available


alsa-info:
http://www.alsa-project.org/db/?f=a7a09703bcc8c43386c87a984e513ce35fc91ca4

regards,
-- 
js
