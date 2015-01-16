From: Qais Yousef <qais.yousef@imgtec.com>
Subject: alsa-lib support for compress offload
Date: Fri, 16 Jan 2015 09:52:58 +0000
Message-ID: <54B8DF7A.6000700@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 93878264F45
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 10:52:59 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

As far as I understand I need to use something similar to tinycompress 
to use alsa devices that supports compress offload. When I asked on 
gstreamer list [1] about alsasink support for compress offload they said 
yes. But I can see that gstalsasink.c [2] only uses the standard 
alsa-lib api which AFAICT doesn't support compress offload.

Did I misread the code and alsa-lib actually works with compress 
offload? Gstreamer refers to the feature "passthrough" and associate it 
with SPDIF[3], are they taking advantage of some other alsa feature that 
looks like compress offload?

Thanks,
Qais

[1] 
http://gstreamer-devel.966125.n4.nabble.com/ALSA-Compress-Offload-support-td4670153.html
[2] 
http://cgit.freedesktop.org/gstreamer/gst-plugins-base/tree/ext/alsa/gstalsasink.c#n836
[3] 
http://cgit.freedesktop.org/gstreamer/gst-plugins-base/tree/ext/alsa/gstalsa.c#n437
