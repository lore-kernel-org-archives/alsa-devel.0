From: "Fujikawa, Kazutoshi" <fujikawa.k@jp.fujitsu.com>
Subject: Question about Conversion to S24_LE from S24_3LE
Date: Fri, 10 Aug 2012 00:28:50 +0000
Message-ID: <1C2A10B55A8EFD41B703692DB3F435E40C2321BD@G01JPEXMBYT21>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 by alsa0.perex.cz (Postfix) with ESMTP id 6188326642C
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 01:59:11 +0200 (CEST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B6ED23EE0AE
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 09:28:54 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 965AD45DE4E
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 09:28:54 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8192D45DE52
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 09:28:54 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 74EB61DB802C
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 09:28:54 +0900 (JST)
Received: from G01JPEXCHYT22.g01.fujitsu.local
 (G01JPEXCHYT22.g01.fujitsu.local [10.128.193.105])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 242261DB8041
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 09:28:54 +0900 (JST)
Content-Language: ja-JP
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello.

I'd like to play a wav file converted from S24_3LE format to S24_LE by alsa-lib.
(I use aplay command.)

I recognize the following:

<PCM format in wav file>
ex. Valid PCM data is 0x123456.

S24_LE  :  0x12345600(in 4bytes, LSB 0 padding)
S24_3LE :  0x123456  (in 3bytes, No padding)


When the S24_LE format file is played, the ALSA driver receives data format is as follows:

0x12345600 (LSB 0 padding)


However, when the S24_3LE format file which is converted to S24_LE by alsa-lib is played, the ALSA driver receives data formats is as follows:

0x00123456 (MSB 0(or 0xFF) padding)

Why is the how to pad 0 different(LSB/MSB)?


cf.

When "snd_pcm_linear_getput" is called
  'get_idx' is set 16.
  'put_idx' is set 8.

[alsa-lib:pcm_linear.c]

211     void snd_pcm_linear_getput(const snd_pcm_channel_area_t *dst_areas, snd_ pcm_uframes_t dst_offset,
212                                const snd_pcm_channel_area_t *src_areas, snd_ pcm_uframes_t src_offset,
213                                unsigned int channels, snd_pcm_uframes_t fram es,
214                                unsigned int get_idx, unsigned int put_idx)
215     {
216     #define CONV24_LABELS
217     #include "plugin_ops.h"
218     #undef CONV24_LABELS
219             void *get = get32_labels[get_idx];
220             void *put = put32_labels[put_idx];
221             unsigned int channel;
222             u_int32_t sample = 0;
223             for (channel = 0; channel < channels; ++channel) {
224                     const char *src;


When 'get_idx' is 16 and 'put_idx' is 8, it is converted as follows:

0x123456(S24_3LE) -> 0x00123456(MSB 0 padding)


I expect the following:

0x123456(S24_3LE) -> 0x12345600(LSB 0 padding)

(If 'get_idx' is 16 and 'put_idx' is 12, it is converted like this.)


I'm doing something wrong?

--------------------
alsa-lib-1.0.24.1
alsa-utils-1.0.24.2
--------------------

Regards.

Kaz
