From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000675]: snd_output_buffer segfault
Date: Wed, 24 Nov 2004 17:35:49 +0100
Message-ID: <a44b3d876d34a9a5b1f687da8397e43b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 33A242E3
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2004 17:35:50 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=675> 
======================================================================
Reported By:                schottstaedt
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - lib
Issue ID:                   675
Category:                   general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-24-2004 15:00 CET
Last Modified:              11-24-2004 17:35 CET
======================================================================
Summary:                    snd_output_buffer segfault
Description: 
In Alsa 1.0.6 (and 1.0.7 I think), snd_output_buffer_puts in
alsa-lib/src/output.c can write to memory it does not own,
causing segfaults in various unrelated later mallocs.  The
offending line is 280:

  result = vsnprintf(buffer->buf + buffer->size, size, format, args);

which should be:

  result = vsnprintf(buffer->buf + buffer->size, result, format, args);

There might not actually be "size" bytes available beyond
buffer->buf+buffer->size --
the preceding snd_output_buffer_need call only guaranteed "result" bytes.

Another similar bug reported by valgrind is in line 303:

	memcpy(buffer->buf + buffer->size, str, size);

where you actually have "err" bytes available, not "size".

And by the way, I really don't like this bug tracking
crap -- you should make it easy to report a bug.

======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 11-24-04 17:35 
----------------------------------------------------------------------
The snd_output_buffer_need() function should have guaranteed that at least
'size' bytes are available.

Now fixed in CVS with the patch below:

--- alsa-lib/src/output.c	20 Jul 2004 15:36:08 -0000	1.21
+++ alsa-lib/src/output.c	24 Nov 2004 16:31:56 -0000	1.22
@@ -258,7 +258,7 @@
 		alloc = 256;
 	else
 		alloc = buffer->alloc;
-	while (alloc < size)
+	while (alloc < buffer->size + size)
 		alloc *= 2;
 	buf = realloc(buffer->buf, alloc);
 	if (!buf)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-04 15:00 schottstaedt   New Issue                                    
11-24-04 17:32 Clemens LadischStatus                   new => assigned     
11-24-04 17:32 Clemens LadischAssigned To               => Clemens Ladisch 
11-24-04 17:35 Clemens LadischStatus                   assigned => resolved
11-24-04 17:35 Clemens LadischResolution               open => fixed       
11-24-04 17:35 Clemens LadischNote Added: 0002572                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
