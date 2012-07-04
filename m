From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: QasTools 0.17.0 released
Date: Wed, 4 Jul 2012 10:44:19 +0800
Message-ID: <CAN8cciaAx6unmfDheYsze7thfkKzyjXN6jhdUfQmBm4Ltvf92g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 3567F244A4
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 04:44:20 +0200 (CEST)
Received: by wibhm6 with SMTP id hm6so3846600wib.2
	for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2012 19:44:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, "Sebastian H." <vand2@gmx.de>
Cc: pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

> QasTools version 0.17.0 is available.

> QasTools is a collection of dektop applications for ALSA.

> Changes:

>  * all: setting names for state save/restore changed/regrouped
>  * all: smart main window sizeHint() to get a useable window
>        size after leaving fullscreen
>  * all: new common info dialog - uses QListView page
>        selection intead of tabs
> * shared: device selection style tweaks: selected item
>           now emphasized by a thin frame
> * shared: device selection style tweaks: Rounded selection area
> * shared: use QSplitter instead of QDockwidget for device selection
>           view. It couldn't be detached anyway and size restoring
>          works more reliable.
> * qasconfig: settings directory changed to shared ~/.config/qastools/
>              (was ~/.config/qasconfig/)
> * qasconfig: new basic command line options (--version, --help, etc.)
> * qashctl: new basic command line options (--version, --help, etc.)
> * qasmixer: new application icon

qasmixer only show a mono Master and Capture volume controls/switch of
"pulse" when user selected 4.0 / 5.1/ 7.1 analog output and stereo
input in sound setting of ubuntu 12.04 , amixer and alsamixer show the
volume control with correct channels

apt-cache policy qasmixer
qasmixer:
  Installed: 0.17.1-1
  Candidate: 0.17.1-1


amixer -Dpulse
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right - Rear Left - Rear Right
  Limits: Playback 0 - 65536
  Mono:
  Front Left: Playback 45314 [69%] [on]
  Front Right: Playback 45314 [69%] [on]
  Rear Left: Playback 45314 [69%] [on]
  Rear Right: Playback 45314 [69%] [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 65536
  Front Left: Capture 65535 [100%] [off]
  Front Right: Capture 65535 [100%] [off]
