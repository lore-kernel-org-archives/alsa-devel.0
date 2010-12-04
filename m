From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: Building alsa-driver-1.0.23 for sis7012
Date: Sat, 4 Dec 2010 02:12:29 -0500
Message-ID: <AANLkTin1-fRcmjjNuNj=xLQO-1HyUgP0ys5617O8rTzF@mail.gmail.com>
References: <4CF9AC6E.5050708@gmail.com>
	<AANLkTik06fg1xcWGOANcQvLEdhyN6Z7H3=bYZRi2=3CT@mail.gmail.com>
	<4CF9BC30.6040100@gmail.com>
	<AANLkTint4iZ7mbobO0-SmaA-0M+KzTseHfcsnyYNJXXJ@mail.gmail.com>
	<4CF9E428.8000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 78860103849
	for <alsa-devel@alsa-project.org>; Sat,  4 Dec 2010 08:12:29 +0100 (CET)
Received: by wyi11 with SMTP id 11so10285608wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2010 23:12:29 -0800 (PST)
In-Reply-To: <4CF9E428.8000602@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: JD <jd1008@gmail.com>
Cc: Alsa Devel List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

No, clearly things are muted (I've noted with arrows):

Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-exclusive penum
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [12.00dB] [off]
  Front Left: Capture [off]  <---
  Front Right: Capture [off]  <---

[...]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 15 [100%] [22.50dB] [off]  <---
  Front Right: Capture 15 [100%] [22.50dB] [off]  <---
