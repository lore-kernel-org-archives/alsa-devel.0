From: Hans de Goede <hdegoede@redhat.com>
Subject: pulseaudio fails to start with kernel 4.11,
 caused by new snd_hdmi_lpe_audio module)
Date: Mon, 20 Mar 2017 12:42:58 +0100
Message-ID: <2549c113-f06b-f22e-d36e-f59fc2969bcb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id C1EB8266D9D
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 12:43:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Lately I've been working on fixing various issues people
are having with baytrail / cherrytrail devices. One thing
I noticed when moving my testing / development to 4.11 is
that pulseaudio does not work (it aborts while starting)
this seemed to be caused by the new snd_hdmi_lpe_audio
module. If I blacklist that all is fine. Any idea what
is causing this ?

Regards,

Hans
