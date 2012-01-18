From: David Henningsson <david.henningsson@canonical.com>
Subject: Realtek model parser problem with the new jack
	detection
Date: Wed, 18 Jan 2012 17:28:32 +0100
Message-ID: <4F16F330.1020109@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 8D5D32414A
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 17:28:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I'm troubleshooting a problem with the Realtek quirk/model parsers. The 
problem is basically that add_jack_kctls call 
snd_hda_jack_detect_enable, which in turn overwrites the current unsol tag.

E g, first the model parser sets a pin to AC_USRSP_EN | ALC_HP_EVENT, 
then comes snd_hda_jack_detect_enable and does AC_USRSP_EN | jack->tag.

I'm not sure of the best way to resolve this; either keep the current 
tag (and mark all jacks as dirty on an unsol event), or read back the 
current tag and set it as jack->action (and then always use the jack 
table). What do you think?

Example alsa-info for this is in 
http://www.alsa-project.org/db/?f=5cc88967e9da547975924a06c948ece00f1f0263

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
