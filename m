From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: USB-Audio.conf comment regarding asound.conf
Date: Mon, 07 Jul 2014 00:31:15 +0300
Message-ID: <53B9C023.3000107@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail.tpnet.fi (webmail.tpnet.fi [62.106.63.33])
 by alsa0.perex.cz (Postfix) with ESMTP id C184726531A
 for <alsa-devel@alsa-project.org>; Sun,  6 Jul 2014 23:31:16 +0200 (CEST)
Received: from mail.onse.fi (host-109-204-178-176.tp-fne.tampereenpuhelin.net
 [109.204.178.176])
 by webmail.tpnet.fi (Postfix) with ESMTP id 388CA20826
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 00:31:16 +0300 (EEST)
Received: from sigma.onse.fi (host-109-204-135-191.tp-fne.tampereenpuhelin.net
 [109.204.135.191])
 by mail.onse.fi (Postfix) with ESMTPSA id 212DB40FA7
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 00:31:16 +0300 (EEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

USB-Audio.conf contains:

> #  DO NO EDIT; this is an internal ALSA file.
> #  If you want to add your own definitions, put them into /etc/asound.conf or
> #  ~/.asoundrc, with "cards." before the "USB-Audio", e.g.:
> #
> #  cards.USB-Audio.pcm.use_dmix."NoiseBlaster 3000" no
> #
> #  If your device requires such a definition to work correctly, please report it
> #  to <alsa-devel@alsa-project.org>.

However, snd_config_hook_load_for_all_cards() will completely skip
loading of /usr/share/alsa/cards/USB-Audio.conf if one has existing
configuration elements in cards.USB-Audio.

I was just hit with this while debugging an issue with a user. Should
users just edit /usr/share/alsa/cards/USB-Audio.conf directly until such
entries are added upstream, or should this be somehow fixed in alsa-lib
to work as instructed?

Related commits:

http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=96da0c842d14b40ce8e37726b259229634b3aa21
http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=133819d420d962b6888c280352a5532da93f1a3a


-- 
Anssi Hannula
