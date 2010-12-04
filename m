From: JD <jd1008@gmail.com>
Subject: Re: Building alsa-driver-1.0.23 for sis7012
Date: Sat, 04 Dec 2010 09:58:41 -0800
Message-ID: <4CFA8151.1080206@gmail.com>
References: <4CF9AC6E.5050708@gmail.com>	<AANLkTik06fg1xcWGOANcQvLEdhyN6Z7H3=bYZRi2=3CT@mail.gmail.com>	<4CF9BC30.6040100@gmail.com>	<AANLkTint4iZ7mbobO0-SmaA-0M+KzTseHfcsnyYNJXXJ@mail.gmail.com>	<4CF9E428.8000602@gmail.com>
	<AANLkTin1-fRcmjjNuNj=xLQO-1HyUgP0ys5617O8rTzF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1956524489
	for <alsa-devel@alsa-project.org>; Sat,  4 Dec 2010 18:58:47 +0100 (CET)
Received: by ywg8 with SMTP id 8so2625502ywg.38
	for <alsa-devel@alsa-project.org>; Sat, 04 Dec 2010 09:58:44 -0800 (PST)
In-Reply-To: <AANLkTin1-fRcmjjNuNj=xLQO-1HyUgP0ys5617O8rTzF@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: Alsa Devel List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 12/03/2010 11:12 PM, Daniel Chen wrote:
> No, clearly things are muted (I've noted with arrows):
>
> Simple mixer control 'Mic',0
>    Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
> cswitch-exclusive penum
>    Capture exclusive group: 0
>    Playback channels: Mono
>    Capture channels: Front Left - Front Right
>    Limits: Playback 0 - 31
>    Mono: Playback 31 [100%] [12.00dB] [off]
>    Front Left: Capture [off]<---
>    Front Right: Capture [off]<---
>
> [...]
> Simple mixer control 'Capture',0
>    Capabilities: cvolume cswitch cswitch-joined penum
>    Capture channels: Front Left - Front Right
>    Limits: Capture 0 - 15
>    Front Left: Capture 15 [100%] [22.50dB] [off]<---
>    Front Right: Capture 15 [100%] [22.50dB] [off]<---
>
OK, then I have no idea how to turn them on.
The only mixer I have is
/usr/bin/gst-mixer
the title of which says:
Volume control: SIS si7012 (Alsa mixer)

I check every available tab or button for ways to turn
on the captures. I do not see any way to turn them on or off.
