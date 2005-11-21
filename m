From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001583]: pcm_file.c compilation fails during lib make install using gcc 2.95.4
Date: Mon, 21 Nov 2005 08:43:05 +0100
Message-ID: <862779739aff0700063e522c3aa08dbb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5CBD516D
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2005 08:43:06 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been set as DUPLICATE OF issue 0001565.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1583> 
======================================================================
Reported By:                DavidB
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1583
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-20-2005 16:14 CET
Last Modified:              11-21-2005 08:43 CET
======================================================================
Summary:                    pcm_file.c compilation fails during lib make install
using gcc 2.95.4
Description: 
Version 1.0.10 of library obtained on 2005-11-21 ("stable" on that date),
compiled with gcc 2.95.4 (still the recommended compiler for 2.4 kernels;
see Documentation/Changes in the kernel tree), fails as follows during
"make install":

 gcc-2.95 -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g -O2
-c pcm_file.c -Wp,-MD,.deps/pcm_file.TPlo  -fPIC -DPIC -o
.libs/pcm_file.o
pcm_file.c: In function `snd_pcm_file_forward':
pcm_file.c:191: parse error before `n'
make[2]: *** [pcm_file.lo] Error 1

The failure occurs because the relevant line is not valid C; a declaration
is introduced after a non-declaration statement in a block:

	if (err > 0) {
		file->appl_ptr = (file->appl_ptr + err) % file->wbuf_size;
		snd_pcm_uframes_t n = snd_pcm_frames_to_bytes(pcm, err);

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001565 Compilation problem of src/pcm/pcm_file.c
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-20-05 16:14 DavidB         New Issue                                    
11-20-05 16:14 DavidB         File Added: pcm_file.c.diff                    
11-21-05 08:43 Clemens LadischRelationship added       duplicate of 0001565
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
