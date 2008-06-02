From: "Christian Morales Vega" <cmorve69@yahoo.es>
Subject: snd_pcm_set_params() bug?
Date: Mon, 2 Jun 2008 18:30:54 +0200
Message-ID: <8235e6f40806020930t42e9b62brff93c5e23b59eac5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by alsa0.perex.cz (Postfix) with ESMTP id E748A103876
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jun 2008 18:30:55 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id h30so792482wxd.23
	for <alsa-devel@alsa-project.org>; Mon, 02 Jun 2008 09:30:54 -0700 (PDT)
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

This code:

#include <alsa/asoundlib.h>

int main(){
    snd_pcm_t *handle;
    if(snd_pcm_open(&handle, "default:1", SND_PCM_STREAM_PLAYBACK, 0) < 0) {
      exit(1);
    }

    if(snd_pcm_set_params(handle, SND_PCM_FORMAT_S16_LE,
SND_PCM_ACCESS_RW_INTERLEAVED,
       2, 24000, 1, 100000) < 0) {
      exit(2);
    }
}

fails with error "ALSA lib pcm.c:7193:(snd_pcm_set_params) Unable to
get period size for PLAYBACK: Invalid argument"
Disable resampling and you get "ALSA lib
pcm.c:7142:(snd_pcm_set_params) Rate doesn't match (requested 24000Hz,
get 0Hz)" (normal, I suppose). With other samplerates works fine.

I'm using alsa-driver-kmp-default-1.0.16.20080602 and
alsa-1.0.16.hg20080510 RPM packages from multimedia:audio openSUSE
Build Service repository (from Takashi Iwai) and an AD1988 (hda-intel)
codec. A XUbuntu user also has the same problem with an hda-intel
codec (that I suppose uses stable 1.0.16).
With a SB Live! in the same computer there are no problems.


This was discovered with bsnes ( http://byuu.cinnamonpirate.com/bsnes/
- http://board.zsnes.com/phpBB2/viewtopic.php?t=11584 ) that can use
openal, libao or alsa directly. The problem just happens when using
24KHz with alsa. So I suppose the problem is in the
snd_pcm_set_params() itself, since openal and libao have not the
problem but they set parameters "manually", not with
snd_pcm_set_params().
