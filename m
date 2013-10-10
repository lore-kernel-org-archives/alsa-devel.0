From: Jason Steigler <drsteigler@gmail.com>
Subject: ALSA: HDA Control and node attachment
Date: Thu, 10 Oct 2013 15:31:30 -0400
Message-ID: <CAPOintU8g1xyQrRBnmnXGon+3ern7=PpbYe=5JQy08L0JDef0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f195.google.com (mail-wi0-f195.google.com
 [209.85.212.195])
 by alsa0.perex.cz (Postfix) with ESMTP id D13AA26172D
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 21:31:30 +0200 (CEST)
Received: by mail-wi0-f195.google.com with SMTP id hq15so572900wib.10
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 12:31:30 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Hello,

I was wondering if it's possible from user-space to change which node a
control is attached to.  In older ALSA (1.0.23), I had used the
'3stack-6ch-dig' model to get 6 channel audio for an "Realtek ALC662 rev 1"
codec.  I had configured the front panel mic (node 0x19) to be an output
using hda-verb that could be controlled by the Center and LFE mixer
controls.  The board also has jacks on the back and one of those would
match the audio coming out the front.  When I change the volume or mute the
controls, they both were affected (which I expected/wanted).

With newer ALSA (1.0.24 with debian Wheezy's stock kernel), the model
'3stack-6ch-dig' doesn't exist, but the codec can be configured to 6
channels.  I have made the same adjustments with hda-verb to make the node
an output.  The volume control works for the 'front' and 'rear' jacks, but
only muting works on the 'rear' jack.  I noticed that the control nodes for
Center and LFE are not the same between the 2 setups.  In the older
version, they were tied to node 0x0e (Audio Mixer), and with the newer
version node 0x18 (which looks like the 'Rear Mic' jack).

I am not knowledgeable of the details of the HDA codec (yet), and am mostly
curious if they can be changed in user-space or if I'll have to start
learning the HDA codec code and try to find a way to move the controls
around.  I tried using hda-jack-retask and could assign the mic nodes as
outputs, but wasn't sure if it would allow me to move controls on the HDA
graph.

Thanks in advance!
Jason
