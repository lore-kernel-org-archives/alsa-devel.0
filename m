From: Cheng Sun <chengsun9@gmail.com>
Subject: 1.1.3 bug report: dmix reports inconsistent status
Date: Wed, 24 May 2017 20:18:08 +0100
Message-ID: <CAG6t6sM4kmWuU8_Qx6btw0En5WCcM5WpYEpNG2EiO=wdd6MPLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id C92E8266B88
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 21:18:29 +0200 (CEST)
Received: by mail-io0-f174.google.com with SMTP id k91so123976915ioi.1
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 12:18:29 -0700 (PDT)
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

Hi all,

The following commit (released in v1.1.3) introduced an issue where
dmix reports its state differently when snd_pcm_state is queried,
compared to snd_pcm_status.

    38a2d2eda880fda9ed5a4a219db498d9c0856d71

(I suspect faf53c197cabeb1eb0fd1f66cd001d1469ebac09 affects dshare
similarly, but this is not tested)

The sample program attached at the bottom of this email demonstrates
this behaviour by printing the following on underrun:

try 1: status_state=3, state=4
try 2: status_state=3, state=4
ALSA lib pcm.c:8306:(snd_pcm_recover) underrun occurred

Cheers,
Cheng


---

#include <assert.h>
#include <alsa/asoundlib.h>
#include <stdint.h>
#define FRAMES 100
int32_t buffer[FRAMES][2];
int main(int argc, char *argv[]) {
    const char *pcmname = argc == 2 ? argv[1] : "default";
    snd_pcm_t *pcm;
    assert( snd_pcm_open(&pcm, pcmname, SND_PCM_STREAM_PLAYBACK, 0) == 0 );
    assert( snd_pcm_set_params(pcm, SND_PCM_FORMAT_S32_LE,
SND_PCM_ACCESS_RW_INTERLEAVED, 2, 48000, 1, 250) == 0 );
    for (;;) {
        snd_pcm_sframes_t written = snd_pcm_writei(pcm, buffer, FRAMES);
        if (written <= 0) {
            snd_pcm_status_t *status;
            snd_pcm_status_alloca(&status);
            assert( snd_pcm_status(pcm, status) == 0 );

            int status_state, state;

            status_state = snd_pcm_status_get_state(status);
            state = snd_pcm_state(pcm);
            printf("try 1: status_state=%d, state=%d\n", status_state, state);

            status_state = snd_pcm_status_get_state(status);
            state = snd_pcm_state(pcm);
            printf("try 2: status_state=%d, state=%d\n", status_state, state);

            assert( snd_pcm_recover(pcm,written,0) == 0 );
        }
    }
}
