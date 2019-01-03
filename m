From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 00/10] ASoC: bytcht-es8316 fixes and
	improvements
Date: Thu,  3 Jan 2019 14:45:25 +0100
Message-ID: <20190103134535.13861-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EBD2267BBA
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 14:45:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, linux@endlessm.com, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Hi All,

Here is a patch series which makes all the sound out and inputs on the
1 BYT + ES8316 and 2 CHT + ES8316 devices which I have fully work.

As usual this was an interesting journey, with things like needing a GPIO
to enable the speaker and the mono speaker on this devices being connected
between the left and right outputs of the HP amplifier of the ES8316.

Daniel and other Endless people I believe that Endless has at least one
CHT devices with an ES8316, it could be good if someone from Endless can
test your device with this series, combined with the ALSA ucm patches which
I will also Cc you on.

Note that I've chosen to make the mono speaker setup the defaults since
because of its differential setup it does not work very well when setup
for stereo speakers. So you may need to pass a quirk parameter and submit
a DMI based quirk upstream to get stereo instead of mono on your device
(you will get audio on both speakers, but it will be a mono mix output
on both speakers).

Regards,

Hans
