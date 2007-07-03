From: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
Subject: namehint problem...
Date: Tue, 03 Jul 2007 13:39:21 -0300
Message-ID: <468A7BB9.1040703@tse.gov.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dexter.tse.gov.br (dexter.tse.gov.br [200.252.157.99])
	by alsa0.perex.cz (Postfix) with ESMTP id DB3FF1037F5
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 18:40:27 +0200 (CEST)
Received: from dexter.tse.gov.br (localhost.tse.gov.br [127.0.0.1])
	by nod32.tse.gov.br (Postfix) with ESMTP id 53DD4FCB43
	for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2007 13:40:25 -0300 (BRT)
Received: from webmail.tse.gov.br (webmail.tse.gov.br [10.28.1.25])
	by dexter.tse.gov.br (Postfix) with ESMTP id 51737FCB3F
	for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2007 13:40:25 -0300 (BRT)
Received: from webmail.tse.gov.br (localhost.localdomain [127.0.0.1])
	by nod32.tse.gov.br (Postfix) with ESMTP id 3B7F314C116
	for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2007 13:40:25 -0300 (BRT)
Received: from [10.28.219.33] (unknown [10.28.219.33])
	by webmail.tse.gov.br (Postfix) with ESMTP id 395EC14C115
	for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2007 13:40:25 -0300 (BRT)
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

Compiling alsa-lib-1.0.14rc4 with the above options:

./configure --disable-aload --disable-alisp --disable-instr 
--disable-seq  --disable-hwdep  --disable-rawmidi  --with-debug=no 
--with-pcm-plugins=hw --with-ctl-plugins=hw


After the build of asound and a linking against a simple program:

#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>

main (int argc, char *argv[])
{
    int i;
    int err;
    short buf[128];
    snd_pcm_t *playback_handle;
    snd_pcm_hw_params_t *hw_params;

    if ((err = snd_pcm_open (&playback_handle, argv[1], 
SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
        fprintf (stderr, "cannot open audio device %s (%s)\n",
                 argv[1],
                 snd_strerror (err));
        exit (1);
    }
    snd_pcm_close (playback_handle);
    exit (0);
}



gcc -o teste teste.c -I./include src/.libs/libasound.so.2.0.0  -ldl
src/.libs/libasound.so.2.0.0: undefined reference to 
`snd_hwdep_info_get_name'
src/.libs/libasound.so.2.0.0: undefined reference to 
`snd_rawmidi_info_get_name'
src/.libs/libasound.so.2.0.0: undefined reference to 
`snd_rawmidi_info_sizeof'
src/.libs/libasound.so.2.0.0: undefined reference to 
`snd_rawmidi_info_set_device'
src/.libs/libasound.so.2.0.0: undefined reference to 
`snd_hwdep_info_set_device'
src/.libs/libasound.so.2.0.0: undefined reference to `snd_hwdep_info_sizeof'
src/.libs/libasound.so.2.0.0: undefined reference to 
`snd_rawmidi_info_set_stream'
collect2: ld returned 1 exit status



After some verification discoverd that the problem is on 
src/control/namehint.c that references this functions but the configure 
removed
rawmidi and hwdep. How can we resolve this problem?

Fausto Carvalho Marques Silva
