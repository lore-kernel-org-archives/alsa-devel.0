From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/5] conf/ucm: chtrt5645: Various updates
Date: Sat, 28 Apr 2018 21:51:55 +0200
Message-ID: <20180428195200.11722-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F60F266C1C
 for <alsa-devel@alsa-project.org>; Sat, 28 Apr 2018 21:52:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi All,

Here is a series of chtrt5645 UCM updates, the first 2 patches bring in
some fixes for the generic config from: https://github.com/plbossart/UCM

The 3th patch adds some analog mic input fixes, together these 3
patches bring the generic chtrt5645 config in sync with the newer
chtrt5645-mono-speaker-analog-mic config, but then for stereo speakers.

The 4th and the 5th patch add long-name using board/model specific
configs for the Asus T100HA and Lenovo Miix 320, these use a digital
mic connected to the DMIC1 resp. DMIC2. input.

The generic chtrt5645 config has been tested on a Lenovo Miix 310 and a
Kazam Vision tablet, both of which feature stereo speakers and an analog
microphone.

The Asus T100HA and Lenovo Miix 320 configs have been tested on the
resp. models they apply to.

Regards,

Hans
