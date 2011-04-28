From: "Sebastian H." <vand2@gmx.de>
Subject: Decibel range / value from  snd_hctl_elem_t
Date: Thu, 28 Apr 2011 20:47:05 +0200
Message-ID: <4DB9B629.8090700@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id A21D4103818
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 20:47:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello list

I'm stuck with the hctl interface.
What is the best way to get
1. the decibel range from a snd_hctl_elem_t
2. the decibel value from a snd_hctl_elem_t

In the "Simple Mixer Interface" there are
snd_mixer_selem_get_playback_dB,
snd_mixer_selem_get_capture_dB,
snd_mixer_selem_get_playback_dB_range and
snd_mixer_selem_get_capture_dB_range

But I can't find anything like that in the
"High level Control Interface".


Possibly related: What does TLV stand for?
http://de.wikipedia.org/wiki/Type-Length-Value ?


Sebastian H.
