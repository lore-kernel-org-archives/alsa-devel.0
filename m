From: Jochen Henneberg <jh@henneberg-systemdesign.com>
Subject: bug: reconfig broken on kernel 4.5
Date: Mon, 09 May 2016 10:22:49 +0200
Message-ID: <1462782169.3239.12.camel@maxwell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by alsa0.perex.cz (Postfix) with ESMTP id F039026067D
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 10:22:58 +0200 (CEST)
Received: from [192.168.0.101] ([109.47.2.184]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0MJkO4-1b0mve1eA0-0017Sr for
 <alsa-devel@alsa-project.org>; Mon, 09 May 2016 10:22:58 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

it looks as if 'reconfig' feature is broken since the sysfs attributes
have been moved to device attributes. In hda_sysfs.c:reconfig_codec()
the device is cleared with snd_hda_codec_reset() which calls
snd_hdac_device_unregister() which removes the sysfs entries (including
the currently in-use 'reconfig'), the re-registration fails afterwards
in snd_hda_codec_build_controls().
I am not sure when things got broken, but snd_hda_codec_reset()
called from reconfig_codec() unregisters the device and removes the
sysfs entries where in the past it only stripped all configurations
(pcms, controls ...) from the device.

Regards,
Jochen
