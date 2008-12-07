From: Daniel Mack <daniel@caiaq.org>
Subject: ASoC: hook for codec control updates and clock controls
Date: Sun, 7 Dec 2008 18:38:25 +0100
Message-ID: <20081207173825.GB26551@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DB96C1037E3
	for <alsa-devel@alsa-project.org>; Sun,  7 Dec 2008 18:38:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 0E6117F402D
	for <alsa-devel@alsa-project.org>; Sun,  7 Dec 2008 18:38:28 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id edlcT8W65JNU for <alsa-devel@alsa-project.org>;
	Sun,  7 Dec 2008 18:38:25 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Codecs like the tlv320aic3x family have soft volume controls to smoothly
drive up and down mixer elements in order to prevent clicks and pops. In
fact, most of the controls on this chip are implemented as such. For the
mixers to work, however, the I2S input clock is needed which is 
currently only true when the DAC/ACD elements are active but not when
the chip is just operating as an analog mixer.

To allow this functionality, the I2S clock must be present for a short
period after each volume control update to the codec and disabled again
after some milliseconds. It should, however, not be enabled if it's
already running and of course, it must not be disabled if the ADC/DAC
is still running.

Adding a hook to struct snd_soc_codec which is called from
snd_soc_update_bits() isn't a big deal, but the problem is the
abstraction layers in this case - for good reasons, the cpu_dai is not
accessible from the codec dai. Or did I miss a link?

Is there a sane way to address this problem?

Thanks and best regards,
Daniel
