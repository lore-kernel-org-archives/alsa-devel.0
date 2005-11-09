From: Benjamin Pracht <bigben+alsa@videolan.org>
Subject: snd_pcm_hw_params fails with snd_intel8x0 on fl32, 96kHz streams
Date: Wed, 09 Nov 2005 08:42:45 +0100
Message-ID: <1131522165.4273.0.camel@endymion.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, 

I'd like to report an issue I have with alsa (1.0.9 and 1.0.10rc2,
kernel 2.6.13 and 2.6.14)

It seems you cannot play fl32, 96kHz streams on a device using the
snd_intel8x0 driver module (tested on a nforce2 as well as other intel
chipsets). s16l or rates until 95999 Hz work well. Other drivers
(snd_emu10k1 and snd_powermac) seem to work well. Software resampling is
enabled on the devices (snd_pcm_hw_params_set_rate_resample).

The error occurs on snd_pcm_hw_params (alsa doesn't complain on
snd_pcm_hw_params_set_rate_near or snd_pcm_hw_params_set_format). The
error code is -22 (invalid argument).

Any help or remark on this is much welcomed ;)

Thanks in advance, 

-- 
BigBen




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
