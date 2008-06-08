From: "Christian Morales Vega" <cmorve69@yahoo.es>
Subject: Wrong period size interval with hda-intel makes
	snd_pcm_set_params() fail
Date: Sun, 8 Jun 2008 10:18:19 +0200
Message-ID: <8235e6f40806080118t7d981350ta9240fb22f371e60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.236])
	by alsa0.perex.cz (Postfix) with ESMTP id EE6EE10381C
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Jun 2008 10:18:20 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id h30so1141991wxd.23
	for <alsa-devel@alsa-project.org>; Sun, 08 Jun 2008 01:18:19 -0700 (PDT)
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

I looked deeper into the problem and looks like a hda-intel problem.

This code fails with "ALSA lib pcm.c:7193:(snd_pcm_set_params) Unable
to get period size for PLAYBACK: Invalid argument"

#include <alsa/asoundlib.h>

int main(){
   snd_pcm_t *handle;
   if(snd_pcm_open(&handle, "default:1", SND_PCM_STREAM_PLAYBACK, 0) < 0) {
     exit(1);
   }

   if(snd_pcm_set_params(handle, SND_PCM_FORMAT_S16_LE,
SND_PCM_ACCESS_RW_INTERLEAVED, 2, 24000, 1, 100000) < 0) {
     exit(2);
   }
}


The "Invalid argument" comes from pcm_params.c:145. The test
"!snd_interval_single(i)" fails since the interval for
SND_PCM_HW_PARAM_PERIOD_SIZE ends being min=511 and max=513.
I understand that this interval is set at the driver, correct? I don't
know where exactly, so some help in finding it or a patch would be
welcome.


I'm using alsa-driver-kmp-default-1.0.16.20080608,
libasound2-1.0.16.hg20080510 and
alsa-1.0.16.hg20080510 RPM packages from multimedia:audio openSUSE
Build Service repository (from Takashi Iwai) and an AD1988 (hda-intel)
codec. A XUbuntu user also has the same problem with an hda-intel
codec (that I suppose uses stable 1.0.16).
With a SB Live! in the same computer there are no problems.
