From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/5] ALSA: snd-usb: switch over to new
 endpoint streaming logic
Date: Fri, 18 Nov 2011 15:44:31 +0100
Message-ID: <4EC66F4F.7050901@gmail.com>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<1320063030-3502-3-git-send-email-zonque@gmail.com>
	<4EB05D3A.60405@ladisch.de> <s5hfwi64ith.wl%tiwai@suse.de>
	<133664d7ea4.-1333182529382966585.4188469103496375013@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 06828103A4D
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 15:44:36 +0100 (CET)
Received: by bkat8 with SMTP id t8so3466767bka.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 06:44:36 -0800 (PST)
In-Reply-To: <133664d7ea4.-1333182529382966585.4188469103496375013@zoho.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Torsten Schenk <torsten.schenk@zoho.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, gdiffey@gmail.com, linuxaudio@showlabor.de, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Torsten,

On 11/02/2011 11:01 PM, Torsten Schenk wrote:
> I'm following the discussion about Daniel's patch because I'm at a similar point
> with the 6fire driver - separating urb handling from alsa substream handling
> and pcm callbacks. One comment catched my attention:

You might be better off waiting for this series to land. Maybe we can
move the code that emerges here to a library that more drivers can use
eventually (including yours, ua101 and also snd-usb-caiaq).


Daniel
