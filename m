From: Torben Schulz <public@letorbi.de>
Subject: [PATCH 0/1] Improved MacBook 3,1 support
Date: Mon, 18 May 2009 12:51:49 +0200
Message-ID: <4A113DC5.5040300@letorbi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lvps87-230-79-166.dedicated.hosteurope.de
	(lvps87-230-79-166.dedicated.hosteurope.de [87.230.79.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 39E23243CE
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 12:52:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-Devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi guys,

this patch improves the support for the MacBook 3,1, which had been handled by the "mbp3" model before. The "mbp3" model is quite inappropriate for the sound-chip of the MacBook 3,1 (RealTek ALC889A). Especially the lack of subwoofer support is one of the biggest disadvantages of this model (See bug 0004086).
In contrast to the other models this model is part of the ALC883 configuration, which reflects the ALC889A sound-chip far better than the ALC882 configuration, which all other Apple models are part of.
I myself own only a MacBook 3,1, but as far as I know it should also work for the MacBook 4,1 - perhaps even for other models. It would be good if someone could check this out...

The new MacBook 3,1 model is called "mb31" and has the following features:

- sound from the third speaker (aka "subwoofer")
- 5.1 surround sound
- speakers and subwoofer are muted when headphones are plugged in.
- 4 channel modes
- 2ch: speakers:front, subwoofer:CLFE, headphones:front, line:input
- 4ch: speakers:front, subwoofer:CLFE, headphones:front, line:CLFE
- 5ch: speakers:front, subwoofer:CLFE, headphones:rear, line:input
- 6ch: speakers:front, subwoofer:off, headphones:rear, line:CLFE

However, there are also two "issues":

Speaker will be unmuted, when channel-mode is changed while headphones are plugged in. But  this can easily be solved, by plugging the headphones out and in again or using the speaker switches in the mixer.

I haven't managed to get "real" surround sound. It seems that the front channel is mapped to all other channels before they get to the mixers (front-left=front-left, front-right=front-right, rear-left=front-left, rear-right=front-right, LFE=front-right, center=front-right). The volume of each channel can be set individually through the mixer. However, this could also be an high configuration issue on my side (please tell me ^^)...

Bai
Torben
