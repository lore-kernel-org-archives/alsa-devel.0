From: Matthias Diehl <matthias-diehl@web.de>
Subject: x-fi drivers and ati hdmi sound
Date: Thu, 11 Jun 2009 19:42:24 +0200
Message-ID: <214091744@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate04.web.de (fmmailgate04.web.de [217.72.192.242])
	by alsa0.perex.cz (Postfix) with ESMTP id C5D0A10386F
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 19:42:26 +0200 (CEST)
Received: from web.de
	by fmmailgate04.web.de (Postfix) with SMTP id 1FE896158B56
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 19:42:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hey Takashi,

i'm really looking forward to you newest x-fi "hack".
i loaded the file >> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/sna=
pshot/alsa-driver-unstable-snapshot.tar.gz << and tried to install it but i=
 think there are problems with my graphics adapter (ati radeon hd 4870) whi=
ch has a hdmi-soundchip onboard (hda intel).

i dont know how to deactivate the hdmi-soundchip on my graphics adapter.  =


lspci | grep audio shows me when installing your driver next to the hdmi dr=
iver:
01:00.1 Audio device: ATI Technologies Inc HD48x0 audio
05:00.0 Multimedia audio controller: Creative Labs SB X-Fi

but there's no device to select in the audio options.

do you have any idea or help for me?

kind regards from germany,

matthias
____________________________________________________________
Text: GRATIS f=FCr alle WEB.DE-Nutzer: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://movieflat.web.de
