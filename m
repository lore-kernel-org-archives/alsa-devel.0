From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: ALC268 - Driving mute led with GPIO
Date: Thu, 04 Feb 2010 18:44:48 +0200
Message-ID: <4B6AF980.40207@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 42337103809
	for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2010 17:44:49 +0100 (CET)
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
Cc: "tiwai >> Takashi Iwai" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

We have a laptop here (a local brand) which has a mute button with a LED. Currently the mute button works correctly but the
led is non-functional.

I've played through hda-analyzer and found out that it's enabled when you enable gpio3 and click out_dir. Clicking out_dir
again and again switches it on and off.

There's a mute led stuff in patch_sigmatel, sigmatel_spec has gpio_led and gpio_polarity information but alc_spec doesn't have.

How should we hook/patch that information into the codec?

I'll try to send the alsa-info output tomorrow.

Thanks.
Ozan
