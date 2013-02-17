From: Tim Hewett <tghewett2@onetel.com>
Subject: Discovery of device characteristics
Date: Sun, 17 Feb 2013 02:39:53 +0000
Message-ID: <B053C7AF-BC91-4B13-B3AE-963AB6CC988C@onetel.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-beusergroup.xen.exoware.net (smtp.beusergroup.co.uk
 [213.229.88.3]) by alsa0.perex.cz (Postfix) with ESMTP id B47AD26166B
 for <alsa-devel@alsa-project.org>; Sun, 17 Feb 2013 03:39:54 +0100 (CET)
Received: from [192.168.1.4] (94-193-221-212.zone7.bethere.co.uk
 [94.193.221.212])
 by smtp-beusergroup.xen.exoware.net (8.14.4/8.14.4) with ESMTP id
 r1H3iO6m007733
 for <alsa-devel@alsa-project.org>; Sun, 17 Feb 2013 03:44:25 GMT
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

I'm writing software looking to discover the available sample rates, channel formats etc. for a device. I have been taking the approach of testing a sample rate from a list of potential rates, then setting the device to that rate to then test the channel formats etc..

The structure is initialised using snd_pcm_hw_params_any() then snd_pcm_hw_params_test_rate() is called for a set of rates followed by snd_pcm_hw_params_set_rate() if the previous call is successful, then snd_pcm_hw_params_test_format() for a set of formats followed by snd_pcm_hw_params_set_format() if that is successful, then snd_pcm_hw_params_test_channels(), the point being to narrow down the characteristics available for given sample rates and channel formats.

For example I have a device which supports up to 8 channels at sample rates of 44.1kHz and 48kHz but only 2 channels at 96kHz.

It works ok usually but keeps failing to detect that the device supports 24-bit channel formats, both for SND_PCM_FORMAT_S24_LE/BE and SND_PCM_FORMAT_S24_3LE/3BE. It detects the 16-bit formats without any problem.

Online source taken from http://download.atmark-techno.com/misc/demos/usb-audio-a500-howto/hw_params.c does detect the 24-bit format but doesn't set the sample rate first - each characteristic is tested in isolation - snd_pcm_hw_params_any() is called before each one.

I am wondering if my way is not the correct way to determine device characteristics.
