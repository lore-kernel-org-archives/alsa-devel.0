From: =?GB2312?B?stzE3Luq?= <cosmo.ustc@gmail.com>
Subject: question about aplay fails on arm 64
Date: Wed, 20 Nov 2013 20:36:25 +0800
Message-ID: <CA+ai60gtVtXhZ2m+BuJXV8W9tkd+=9_t8kEsM1-i7E+S_64oZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id ADD982616B4
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 13:36:25 +0100 (CET)
Received: by mail-wg0-f48.google.com with SMTP id n12so9034980wgh.15
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 04:36:25 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de, clemens@ladisch.de, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, James@superbug.co.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello, alsa maintainer:



    Recently, i encounter aplay failed on arm 64 bits core. My test
environment is: Linux kernel use arm 64 bits, and alsa-lib/aplay is 32 bit
version. So the ioctl interface should use snd_pcm_ioctl_compat. but when i
use aplay to playback music, i encounter "aplay" segment fault. Do we need
some special configuration for alsa-lib/aplay to support 64 bit kernel? Any
suggestion will be appreciated. Thanks!



[\u@\h: \W]\#aplay windows.wav

[   85.237519] 823 (aplay) snd_pcm_playback_open+++

[   85.247876] 823 (aplay) snd_pcm_aio_write---

[   85.254708] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.263597] 823 (aplay) ======snd_pcm_ioctl_compat3333

[   85.271850] 823 (aplay) snd_pcm_playback_ioctl1+++

[   85.279019] 823 (aplay) snd_pcm_common_ioctl1+++

[   85.285318] 823 (aplay) snd_pcm_common_ioctl122

[   85.292253] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.300186] 823 (aplay) ======snd_pcm_ioctl_compat3333

[   85.307569] 823 (aplay) snd_pcm_playback_ioctl1+++

[   85.314021] 823 (aplay) snd_pcm_common_ioctl1+++

[   85.320697] 823 (aplay) snd_pcm_common_ioctl111

[   85.328240] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.336255] 823 (aplay) ======snd_pcm_ioctl_compat3333

[   85.343185] 823 (aplay) snd_pcm_playback_ioctl1+++

[   85.350090] 823 (aplay) snd_pcm_common_ioctl1+++

[   85.356800] 823 (aplay) snd_pcm_common_ioctl144

[   85.366441] 823 (aplay) =====snd_pcm_mmap+++

[   85.372840] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.380709] 823 (aplay) ======snd_pcm_ioctl_compat9999

[   85.388074] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat++

[   85.395184] 823 (aplay) state:0x0

[   85.400355] 823 (aplay) hw_ptr:0x0

[   85.405080] 823 (aplay) tstamp:0x0

[   85.410326] 823 (aplay) suspend_stat:0x0

[   85.416216] 823 (aplay) tstamp:0x0

[   85.421039] 823 (aplay) appl_ptr:0x0

[   85.426489] 823 (aplay) avail_min:0x1

[   85.431579] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat--

[   85.443771] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.451883] 823 (aplay) ======snd_pcm_ioctl_compat3333

[   85.459321] 823 (aplay) snd_pcm_playback_ioctl1+++

[   85.466280] 823 (aplay) snd_pcm_common_ioctl1+++

[   85.472539] 823 (aplay) snd_pcm_common_ioctl122

Playing WAVE 'windows.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo

[   85.500612] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.508756] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.519975] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.528101] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.536112] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.543496] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.552271] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.560207] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.594120] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.602221] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.639453] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.647597] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.656416] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.663826] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.693293] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.701231] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.730988] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.739043] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.748850] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.756855] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.765543] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.772949] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.802272] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.810266] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.839909] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.847899] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.857606] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.865619] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.873814] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.881784] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.891149] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.899062] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.911247] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.919318] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.928068] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.935994] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.945446] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.952828] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.962969] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.971003] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.980633] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   85.988651] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   85.997912] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.005880] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.019755] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.027851] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.037648] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.045668] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.055326] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.062700] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.071957] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.079852] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.093442] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.101428] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.110880] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.118767] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.128022] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.136031] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.145312] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.152642] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.166234] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.174252] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.185470] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.192864] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.202191] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.210222] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.219452] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.227353] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.241140] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.249167] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.258633] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.266583] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.275809] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.283209] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.292507] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.300462] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.312362] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.320295] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.329874] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.337825] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.347005] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.354979] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.364272] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.371671] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.386035] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.394010] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.404122] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.411491] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.420685] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.428587] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.437805] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.445723] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.458333] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.466412] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.476696] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.484743] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.494008] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.501393] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.510721] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.518682] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.528949] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.536991] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.546180] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.554122] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.563543] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.570903] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.583664] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.591141] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.600602] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.608548] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.617702] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.625703] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.634924] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.642317] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.653731] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.661075] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.670427] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.678383] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.687594] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.695585] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.709565] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.717652] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.734313] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.741774] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.755420] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.763633] 823 (aplay) ======snd_pcm_ioctl_compat5555

[   86.773070] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.780448] 823 (aplay) ======snd_pcm_ioctl_compat66666

[   86.789495] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.797508] 823 (aplay) ======snd_pcm_ioctl_compat9999

[   86.804939] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat++

[   86.812086] 823 (aplay) state:0x1

[   86.817225] 823 (aplay) hw_ptr:0x0

[   86.821974] 823 (aplay) tstamp:0x0

[   86.827171] 823 (aplay) suspend_stat:0x0

[   86.833049] 823 (aplay) tstamp:0x0

[   86.837795] 823 (aplay) appl_ptr:0x0

[   86.843255] 823 (aplay) avail_min:0x1

[   86.848303] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat--

[   86.857505] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.865637] 823 (aplay) ======snd_pcm_ioctl_compat77777

[   86.874082] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.881454] 823 (aplay) ======snd_pcm_ioctl_compat1010

[   86.889143] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.896981] 823 (aplay) ======snd_pcm_ioctl_compat1010

[   86.904723] 823 (aplay) =====snd_pcm_mmap+++

[   86.910536] 823 (aplay) =====snd_pcm_mmap33

[   86.919994] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.928068] 823 (aplay) ======snd_pcm_ioctl_compat77777

[   86.937550] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   86.945512] 823 (aplay) ======snd_pcm_ioctl_compat9999

[   86.952892] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat++

[   86.959975] 823 (aplay) state:0x1

[   86.965065] 823 (aplay) hw_ptr:0x0

[   86.969876] 823 (aplay) tstamp:0x0

[   86.975111] 823 (aplay) suspend_stat:0x0

[   86.980497] 823 (aplay) tstamp:0x0

[   86.985722] 823 (aplay) appl_ptr:0x0

[   86.990719] 823 (aplay) avail_min:0x300

[   86.996397] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat--

[   87.004605] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   87.012676] 823 (aplay) ======snd_pcm_ioctl_compat3333

[   87.019501] 823 (aplay) snd_pcm_playback_ioctl1+++

[   87.026451] 823 (aplay) snd_pcm_common_ioctl1+++

[   87.033169] 823 (aplay) snd_pcm_common_ioctl11111

[   87.048203] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   87.056227] 823 (aplay) ======snd_pcm_ioctl_compat9999

[   87.063579] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat++

[   87.070579] 823 (aplay) state:0x2

[   87.075679] 823 (aplay) hw_ptr:0x0

[   87.080477] 823 (aplay) tstamp:0x0

[   87.085657] 823 (aplay) suspend_stat:0x0

[   87.091028] 823 (aplay) tstamp:0x0

[   87.096229] 823 (aplay) appl_ptr:0x0

[   87.101165] 823 (aplay) avail_min:0x300

[   87.106813] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat--

[   87.116559] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   87.124489] 823 (aplay) ======snd_pcm_ioctl_compat77777

[   87.134835] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   87.142950] 823 (aplay) ======snd_pcm_ioctl_compat9999

[   87.149868] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat++

[   87.157350] 823 (aplay) state:0x2

[   87.162475] 823 (aplay) hw_ptr:0x0

[   87.167254] 823 (aplay) tstamp:0x0

[   87.172485] 823 (aplay) suspend_stat:0x0

[   87.177886] 823 (aplay) tstamp:0x0

[   87.183131] 823 (aplay) appl_ptr:0x0

[   87.188110] 823 (aplay) avail_min:0x300

[   87.193880] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat--

[   87.202114] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   87.209559] 823 (aplay) ======snd_pcm_ioctl_compat9999

[   87.217028] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat++

[   87.224520] 823 (aplay) state:0x2

[   87.229146] 823 (aplay) hw_ptr:0x0

[   87.234352] 823 (aplay) tstamp:0x0

[   87.239101] 823 (aplay) suspend_stat:0x0

[   87.244924] 823 (aplay) tstamp:0x0

[   87.249708] 823 (aplay) appl_ptr:0x0

[   87.255147] 823 (aplay) avail_min:0x300

[   87.260432] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat--

[   87.268036] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   87.275875] 823 (aplay) ======snd_pcm_ioctl_compat9999

[   87.283164] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat++

[   87.290225] 823 (aplay) state:0x2

[   87.295283] 823 (aplay) hw_ptr:0x0

[   87.300041] 823 (aplay) tstamp:0x0

[   87.305174] 823 (aplay) suspend_stat:0x0

[   87.310583] 823 (aplay) tstamp:0x0

[   87.315771] 823 (aplay) appl_ptr:0x0

[   87.320771] 823 (aplay) avail_min:0x300

[   87.326468] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat--

[   87.335868] 823 (aplay) ======snd_pcm_ioctl_compat++++++++

[   87.343945] 823 (aplay) ======snd_pcm_ioctl_compat9999

[   87.350825] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat++

[   87.358387] 823 (aplay) state:0x2

[   87.363532] 823 (aplay) hw_ptr:0x0

[   87.368252] 823 (aplay) tstamp:0x0

[   87.373510] 823 (aplay) suspend_stat:0x0

[   87.378904] 823 (aplay) tstamp:0x0

[   87.384100] 823 (aplay) appl_ptr:0x0

[   87.389050] 823 (aplay) avail_min:0x300

[   87.394764] 823 (aplay) snd_pcm_ioctl_sync_ptr_compat--

[   87.403146] 823 (aplay) Bad mode in Error handler detected, code
0xbf000000

[   87.412595] 823 (aplay) CPU: 0 PID: 823 Comm: aplay Not tainted 3.10.0+
#35

[   87.421956] 823 (aplay) task: ffffffc019add7c0 ti: ffffffc019a50000
task.ti: ffffffc019a50000

[   87.433106] 823 (aplay) PC is at 0xf72fd970

[   87.438849] 823 (aplay) LR is at 0x0

[   87.443931] 823 (aplay) pc : [<00000000f72fd970>] lr :
[<0000000000000000>] pstate: 80000010

[   87.454906] 823 (aplay) sp : ffffffc019a51ff0

[   87.460837] x29: 0000000000000000 x28: 0000000000000000

[   87.468175] x27: 0000000000000000 x26: 0000000000000000

[   87.475415] x25: 0000000000000000 x24: 0000000000000000

[   87.482645] x23: 0000000000000000 x22: 0000000000000000

[   87.489961] x21: 0000000000000000 x20: 0000000000000000

[   87.497217] x19: 0000000000000000 x18: 0000000000000000

[   87.504365] x17: 0000000000000000 x16: 0000000000000000

[   87.511611] x15: 0000000000000000 x14: 00000000f72fd9ec

[   87.518832] x13: 00000000ffa0ee98 x12: 00000000ffa0ee98

[   87.526061] x11: 00000000ffa0eeec x10: 000000000001e32c

[   87.533332] x9 : 000000000001e31c x8 : 00000000ffa0f168

[   87.540473] x7 : 00000000ffa0f168 x6 : 00000000ffa0f180

[   87.547681] x5 : 00000000f738f000 x4 : 000000000000000f

[   87.554817] x3 : 0000000000000300 x2 : 0000000000000001

[   87.561998] x1 : 0000000000000000 x0 : 0000000000000000

[   87.569196] 823 (aplay)

[   87.573201] 823 (aplay) Bad mode in Synchronous Abort handler detected,
code 0x86000007

[   87.583794] 823 (aplay) CPU: 0 PID: 823 Comm: aplay Not tainted 3.10.0+
#35

[   87.593059] 823 (aplay) task: ffffffc019add7c0 ti: ffffffc019a50000
task.ti: ffffffc019a50000

[   87.603993] 823 (aplay) PC is at 0x0

[   87.608968] 823 (aplay) LR is at 0x0

[   87.614003] 823 (aplay) pc : [<0000000000000000>] lr :
[<0000000000000000>] pstate: 800003c5

[   87.624868] 823 (aplay) sp : ffffffc019a51ed0

[   87.630832] x29: 0000000000000000 x28: 0000000000000000

[   87.638120] x27: 0000000000000000 x26: 0000000000000000

[   87.645395] x25: 0000000000000000 x24: 0000000000000000

[   87.652731] x23: 0000000080000010 x22: 00000000f72fd970

[   87.659999] x21: ffffffc019a51ff0 x20: 0000000000000000

[   87.667198] x19: 0000000000000000 x18: 0000000000000000

[   87.674377] x17: 0000000000000000 x16: 0000000000000000

[   87.681570] x15: 0000000000000002 x14: 0000000000000082

[   87.688706] x13: 0000000000000000 x12: 0000000000001db0

[   87.695986] x11: ffffffc0012376f8 x10: 0000000000000050

[   87.703184] x9 : ffffffc019a51c60 x8 : ffffffc000590228

[   87.710415] x7 : 0000000000000003 x6 : 000000000000027d

[   87.717643] x5 : ffffffc000081380 x4 : 0000000000000000

[   87.724914] x3 : 0000000000000001 x2 : 0000000000000001

[   87.732107] x1 : ffffffc019a51de0 x0 : 0000000000000000

[   87.739282] 823 (aplay)

[   87.743126] 823 (aplay) Internal error: Oops - bad mode: 0 [#1] PREEMPT

[   87.752089] 823 (aplay) CPU: 0 PID: 823 Comm: aplay Not tainted 3.10.0+
#35

[   87.761348] 823 (aplay) task: ffffffc019add7c0 ti: ffffffc019a50000
task.ti: ffffffc019a50000

[   87.772375] 823 (aplay) PC is at 0x0

[   87.777318] 823 (aplay) LR is at 0x0

[   87.782386] 823 (aplay) pc : [<0000000000000000>] lr :
[<0000000000000000>] pstate: 800003c5

[   87.793320] 823 (aplay) sp : ffffffc019a51ed0

[   87.799289] x29: 0000000000000000 x28: 0000000000000000

[   87.806491] x27: 0000000000000000 x26: 0000000000000000

[   87.813665] x25: 0000000000000000 x24: 0000000000000000

[   87.820915] x23: 0000000080000010 x22: 00000000f72fd970

[   87.828152] x21: ffffffc019a51ff0 x20: 0000000000000000

[   87.835382] x19: 0000000000000000 x18: 0000000000000000

[   87.842585] x17: 0000000000000000 x16: 0000000000000000

[   87.849845] x15: 0000000000000002 x14: 0000000000000082

[   87.857020] x13: 0000000000000000 x12: 0000000000001db0

[   87.864266] x11: ffffffc0012376f8 x10: 0000000000000050

[   87.871505] x9 : ffffffc019a51c60 x8 : ffffffc000590228

[   87.878720] x7 : 0000000000000003 x6 : 000000000000027d

[   87.885914] x5 : ffffffc000081380 x4 : 0000000000000000

[   87.893121] x3 : 0000000000000001 x2 : 0000000000000001

[   87.900321] x1 : ffffffc019a51de0 x0 : 0000000000000000

[   87.907443] 823 (aplay)

[   87.911323] 823 (aplay) Process aplay (pid: 823, stack limit =
0xffffffc019a50058)

[   87.921331] 823 (aplay) Stack: (0xffffffc019a51ed0 to 0xffffffc019a52000)

[   87.930547] 823 (aplay) 1ec0:                                     00000000
00000000 00000000 00000000

[   87.942875] 823 (aplay) 1ee0: 00000001 00000000 00000300 00000000
0000000f 00000000 f738f000 00000000

[   87.955305] 823 (aplay) 1f00: ffa0f180 00000000 ffa0f168 00000000
ffa0f168 00000000 0001e31c 00000000

[   87.967718] 823 (aplay) 1f20: 0001e32c 00000000 ffa0eeec 00000000
ffa0ee98 00000000 ffa0ee98 00000000

[   87.979993] 823 (aplay) 1f40: f72fd9ec 00000000 00000000 00000000
00000000 00000000 00000000 00000000

[   87.992343] 823 (aplay) 1f60: 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000

[   88.004660] 823 (aplay) 1f80: 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000

[   88.016989] 823 (aplay) 1fa0: 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000

[   88.029331] 823 (aplay) 1fc0: 00000000 00000000 19a51ff0 ffffffc0
f72fd970 00000000 80000010 00000000

[   88.041739] 823 (aplay) 1fe0: 00000004 00000000 ffffffff ffffffff
00400080 a201ca14 00400020 200130de

[   88.053478] 823 (aplay) Call trace:

[   88.058456] 823 (aplay) Code: bad PC value

[   88.065099] 823 (aplay) ---[ end trace c58f84f42ebfb68b ]---

[   88.091636] 823 (aplay) snd_pcm_release++

[   88.098134] 823 (aplay) snd_pcm_release--

Segmentation fault
[\u@\h: \W]\#


BR
cosmo
