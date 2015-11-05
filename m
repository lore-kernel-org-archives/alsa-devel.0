From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Thu, 5 Nov 2015 17:39:43 +0800
Message-ID: <CAN8cciap4zwL8Y+gyiJLkTC_2P5ewknKfWzbMSj2cmTvjAAukw@mail.gmail.com>
References: <96A12704CE18D347B625EE2D4A099D1974C250@SHSMSX103.ccr.corp.intel.com>
 <s5htwpuj6f5.wl-tiwai@suse.de>
 <CAN8cciYqLBH=kXvPjrGTgGPg9p7euU5w9z=UYdvKk4Vnxf-YFw@mail.gmail.com>
 <96A12704CE18D347B625EE2D4A099D1975281F@SHSMSX103.ccr.corp.intel.com>
 <56288783.1080503@canonical.com>
 <96A12704CE18D347B625EE2D4A099D19753A2D@SHSMSX103.ccr.corp.intel.com>
 <56288FF7.9030400@canonical.com>
 <96A12704CE18D347B625EE2D4A099D19753A91@SHSMSX103.ccr.corp.intel.com>
 <5628A3EB.8050306@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F84B862A5B@shsmsx102.ccr.corp.intel.com>
 <562A1237.2090909@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F84B8632DF@shsmsx102.ccr.corp.intel.com>
 <96A12704CE18D347B625EE2D4A099D19755BE7@SHSMSX103.ccr.corp.intel.com>
 <s5hvb9or3zj.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D197574CE@SHSMSX103.ccr.corp.intel.com>
 <563716D7.3000502@canonical.com>
 <96A12704CE18D347B625EE2D4A099D19765611@SHSMSX103.ccr.corp.intel.com>
 <563B1C37.4010400@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f195.google.com (mail-ob0-f195.google.com
 [209.85.214.195])
 by alsa0.perex.cz (Postfix) with ESMTP id E9E00260508
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 10:39:44 +0100 (CET)
Received: by obcyn7 with SMTP id yn7so1031268obc.0
 for <alsa-devel@alsa-project.org>; Thu, 05 Nov 2015 01:39:43 -0800 (PST)
In-Reply-To: <563B1C37.4010400@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "Yang, Libin" <libin.yang@intel.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "airlied@linux.ie" <airlied@linux.ie>, "Nikula, Jani" <jani.nikula@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "tanuk@iki.fi" <tanuk@iki.fi>, "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

>
> So I'm asking my question again. What would happen (on Intel hardware),
if you stream audio to a converter node on the audio codec, and there is no
pin node connected to that converter node?

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=d1f15e06b2af57228d11e33e06a172ff58f5bc1c

For alt analog playback device , it return EBUSY when DAC of HP is not
available (independent switch is OFF)

BTW, as pulseaudio does not support multi streaming (e.g. playing different
audio stream to HP and rear panel of desktop)

How can pulseaudio support displayport multi streaming ?
