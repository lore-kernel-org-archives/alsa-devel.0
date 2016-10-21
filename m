From: Tim Harvey <tharvey@gateworks.com>
Subject: how to disable dynamic control of mic bias?
Date: Fri, 21 Oct 2016 08:42:30 -0700
Message-ID: <CAJ+vNU1Us7rYdHN0rVL=VA6iDkzGQHgPtxCqP7iWUc=4YP9RHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f52.google.com (mail-it0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C4F32671D3
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2016 17:42:32 +0200 (CEST)
Received: by mail-it0-f52.google.com with SMTP id 66so165077859itl.1
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2016 08:42:32 -0700 (PDT)
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

I have a board design with a TLV320AIC3x codec + TS3A227E headset
detect chip and am using the tlv320aic3x and ts3a227e drivers in
mainline Linux. The TS3A227E serves a couple of purposes including
support for multiple headset pinout standards and sensing buttons on
the mic (ie see Android wired headset spec:
https://source.android.com/devices/accessories/headset/specification.html).

In order for the button detect to work mic bias from the codec needs
to be enabled (at init time and regardless of playing or recording
audio). What is the correct way to do this in either device-tree if
using something like simple-audio-card or in a machine driver?

I have not had success by setting the codec drivers 'idle_bias_off =
false' - while this does keep mic bias on at init and after audio
playback it kills it after record due to the 'Mic Bias' dapm widget in
the case of the tlv320aic3x.c driver. I'm thinking I need to instead
remove the routing or disable the 'Mic Bias' but I'm not clear how to
do this?

Regards,

Tim
