From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Dubious assertion in alsa-lib
Date: Sun, 21 Nov 2010 14:39:56 +0500
Message-ID: <icapdc$38e$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AE5F244AC
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 10:40:08 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PK6P1-0006Op-Iw
	for alsa-devel@alsa-project.org; Sun, 21 Nov 2010 10:40:07 +0100
Received: from 188.16.198.194 ([188.16.198.194])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 10:40:07 +0100
Received: from patrakov by 188.16.198.194 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 10:40:07 +0100
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

Hello.

In alsa-lib-1.0.23/src/pcm/pcm_plug.c, there are two assertions of the form:

assert(snd_pcm_format_linear(slv->format));

in snd_pcm_plug_change_rate() and snd_pcm_plug_change_channels() 
functions, respectively. While in snd_pcm_plug_change_rate() this looks 
reasonable, it is IMHO invalid in snd_pcm_plug_change_channels(). I say 
this because this can be triggered with the following .asoundrc:

pcm.jackplug {
	type plug
	slave.pcm {
		type jack
		playback_ports {
			0 system:playback_1
			1 system:playback_2
		}
		capture_ports {
			0 system:capture_1
			1 system:capture_2
		}
		client_name "alsa"
	}
}

and the following command:

aplay -r 44100 -c 1 -f FLOAT_LE -D jackplug /dev/zero

JACK is configured to accept stereo audio, with 44100 Hz sampling rate, 
so only the number of channels has to be changed by the plug here.

I.e., rerouting channels by copying samples makes perfect sense not only 
for linear formats, but also for floating-point ones.

-- 
Alexander E. Patrakov
