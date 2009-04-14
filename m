From: Florian Faber <faber@faberman.de>
Subject: [PATCH 2/2] hdspm: modified include file
Date: Tue, 14 Apr 2009 17:48:53 +0200
Message-ID: <1239724133.18545.8.camel@x200.watzmann.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AA3F243D1
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 17:49:05 +0200 (CEST)
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

Ckeaned up meter structure and modified the PEAK_RMS ioctl to reflect
the modifications.

diff a/sound/include/sound/hdspm.h b/sound/include/sound/hdspm.h

28,36d27
< /* peam rms level structure like we get from hardware 
<   
<    maybe in future we can memory map it so I just copy it
<    to user on ioctl call now an dont change anything
<    rms are made out of low and high values
<    where (long) ????_rms = (????_rms_l >> 8) + ((????_rms_h &
0xFFFFFF00)<<24)
<    (i asume so from the code)
< */
< 
37a29,35
>         uint32_t input_peaks[64];
>         uint32_t playback_peaks[64];
>         uint32_t output_peaks[64];
>   
>         uint64_t input_rms[64];
>         uint64_t playback_rms[64];
>         uint64_t output_rms[64];
39,56c37,38
< 	unsigned int level_offset[1024];
< 
< 	unsigned int input_peak[64];
< 	unsigned int playback_peak[64];
< 	unsigned int output_peak[64];
< 	unsigned int xxx_peak[64];	/* not used */
< 
< 	unsigned int reserved[256];	/* not used */
< 
< 	unsigned int input_rms_l[64];
< 	unsigned int playback_rms_l[64];
< 	unsigned int output_rms_l[64];
< 	unsigned int xxx_rms_l[64];	/* not used */
< 
< 	unsigned int input_rms_h[64];
< 	unsigned int playback_rms_h[64];
< 	unsigned int output_rms_h[64];
< 	unsigned int xxx_rms_h[64];	/* not used */
---
>         enum {ss, ds, qs} speed;
>         int status2;
59,61d40
< struct hdspm_peak_rms_ioctl {
< 	struct hdspm_peak_rms *peak;
< };
63d41
< /* use indirect access due to the limit of ioctl bit size */
65c43
< 	_IOR('H', 0x40, struct hdspm_peak_rms_ioctl)
---
> 	_IOR('H', 0x40, struct hdspm_peak_rms)

Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net
