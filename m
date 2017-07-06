From: Hui Wang <hui.wang@canonical.com>
Subject: A problem about two microphones
Date: Thu, 6 Jul 2017 10:09:07 +0800
Message-ID: <deb2b0a4-3411-2fea-a75a-d6134845ad99@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A397F26698E
 for <alsa-devel@alsa-project.org>; Thu,  6 Jul 2017 04:09:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Recently we met a problem, on a lenovo machine, it has two 
microphones(one is microphone, the other is headset-mic), and both of 
them are located in the front panel.

When the driver assigns names for them (via the function 
hda_get_autocfg_input_label()), they are assigned the same name "Mic" 
since they have the same location. So there are two "Mic", but the 
pulseaudio can't handle two "Mic", in the pulseaudio, it can only handle 
multiple inputs/microphones with different names, like "Mic" and "Front 
Mic". If two microphones have the same name, we can only see one of them 
through pulseaudio.

I don't know how to solve this problem, the simplest way to workaround 
it I can figure out is to change one of the microphone's location, let 
them have differnt location, then they have differnet names.
Pin Default 0x02a19040: [Jack] Mic at Ext Front
Changed to:
Pin Default 0x04a19040: [Jack] Mic at Ext Right

Do you have any ideas to solve this problem?


The alsa-info.txt for this machine is at: http://paste.ubuntu.com/24967758/


Thanks,

Hui.
