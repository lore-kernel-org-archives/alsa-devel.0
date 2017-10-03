From: Tim Harvey <tharvey@gateworks.com>
Subject: notifying userspace of hwparams change
Date: Tue, 3 Oct 2017 09:11:50 -0700
Message-ID: <CAJ+vNU1eN2LWJ3Qy35EnUJOyH6gVVQma7caibE40boqT3bfbMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 79F4C2668F0
 for <alsa-devel@alsa-project.org>; Tue,  3 Oct 2017 18:11:52 +0200 (CEST)
Received: by mail-wm0-f47.google.com with SMTP id k4so15889346wmc.1
 for <alsa-devel@alsa-project.org>; Tue, 03 Oct 2017 09:11:52 -0700 (PDT)
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

Greetings,

I've got an HDMI receiver chip I'm working on a driver for which
provides the audio signal from the HDMI source. An HDMI source can be
a variety of sample-rates, channels, widths, and formats. If I
understand correctly I need to register the device as supporting all
the possible rates/channels/formats then constrain these to what is
actually available at the time in the startup callback with
snd_pcm_hw_contstraint_minmax and snd_pcm_hw_constraint_mask.

How do I notify userspace when the chip tells me that the HDMI audio
source rate/channels/format has changed?

I know on the Video side the driver sends a V4L2_EVENT_SOURCE_CHANGE
event to userspace when input format/resolution has changed so that
userspace can stop streaming, call VIDIOC_QUERY_DV_TIMINGS and then
VIDIOC_S_DV_TIMINGS with new timings.

Regards,

Tim
