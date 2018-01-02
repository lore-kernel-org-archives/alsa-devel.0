From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/6] ASoC: rt5645: Analog microphone fixes
Date: Tue,  2 Jan 2018 19:53:08 +0100
Message-ID: <20180102185314.17189-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CA872674CE
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 19:53:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi All,

Here is a patch-series primarily fixing analog microphone inputs on
Cherry Trail devices with a rt5645 codec.

The first 2 patches are from Bard Liao, he has already submitted the
first one himself a couple of days ago. I've included this because
his second patch depends on it and he has not yet submitted that one
himself I believe. My version of his 2nd patch fixes 2 compiler warnings
by removing 2 unused variable declarations.

Patches 3-5 makes some changes to platform data necessary to make
everything work correctly on my cht + rt5645 devices. The 6th patch
adds an "Int Analog Mic" DAPM widget which is used by updated ucm files
for these devices to get the micbias supplies enabled without which
the micrphones on these devices will not work.

Regards,

Hans
