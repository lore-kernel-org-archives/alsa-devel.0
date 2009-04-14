From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Help required. Slax OS, no audio, multiple cards,
	hdmi
Date: Mon, 13 Apr 2009 22:50:18 -0400
Message-ID: <75b66ecd0904131950o1501cab3u2edc325eee2e4274@mail.gmail.com>
References: <49E355A0.1080106@thundermonkey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f207.google.com (mail-gx0-f207.google.com
	[209.85.217.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 14006243A9
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 04:50:19 +0200 (CEST)
Received: by gxk3 with SMTP id 3so4836338gxk.8
	for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2009 19:50:19 -0700 (PDT)
In-Reply-To: <49E355A0.1080106@thundermonkey.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Gauld <james@thundermonkey.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 13, 2009 at 11:09 AM, James Gauld <james@thundermonkey.net> wrote:
> However, running slax (from usb) I cannot get any sound from either
> device, but I'm only interested in the HDMI card (card #1) which
> delivers output to the integrated speakers (as far as I can tell from
> windows).
>
> I've tried from console and various widgets in KDE with no success.

Try installing the proprietary ATI video driver.  Thanks to DRM the
video driver has veto power over whether you can output audio via
HDMI.

Lee
