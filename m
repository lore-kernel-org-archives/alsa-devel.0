From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000646]: emu10k1: sound chopped when passthru enabled
Date: Tue, 16 Nov 2004 21:09:02 +0100
Message-ID: <df3918dc2eab110de3cbfa57fc73c19b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CFA17268
	for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2004 21:09:02 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=646> 
======================================================================
Reported By:                flink
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   646
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-12-2004 17:02 CET
Last Modified:              11-16-2004 21:09 CET
======================================================================
Summary:                    emu10k1: sound chopped when passthru enabled
Description: 
When I play a DVD with AC3 passthru enabled, the signal is correctly send
to my AC3 decoder but this signal is chopped. I've a little led on my
decoder to show if dolby digital is enabled or not and this led blinks
instead of remaining enabled. So the sound is also chopped and a DVD can't
be 
watched this way.
======================================================================

----------------------------------------------------------------------
 rlrevell - 11-16-04 00:24 
----------------------------------------------------------------------
Well, the in-kernel ALSA version lags behind the current ALSA usually by a
month or two.  Can you verify that the problem still exists with ALSA CVS?
 If so, please close this bug and open a new one under alsa driver -> PCI
- emu10k1.

----------------------------------------------------------------------
 visit0r - 11-16-04 21:09 
----------------------------------------------------------------------
I would verify it, only if I could get it compiled. 
Both 1.0.7 and CVS compilation fail with following:

[...]
 CC [M]  /usr/src/alsa-cvs/alsa-driver/kbuild/../drivers/serialmidi.o
/usr/src/alsa-cvs/alsa-driver/drivers/serialmidi.c: In function
`tx_loop':
/usr/src/alsa-cvs/alsa-driver/drivers/serialmidi.c:327: warning: passing
arg 3 of pointer to function makes integer from pointer without a cast
/usr/src/alsa-cvs/alsa-driver/drivers/serialmidi.c:327: error: too many
arguments to function
make[4]: ***
[/usr/src/alsa-cvs/alsa-driver/kbuild/../drivers/serialmidi.o] Error 1
make[3]: *** [/usr/src/alsa-cvs/alsa-driver/kbuild/../drivers] Error 2
make[2]: *** [_module_/usr/src/alsa-cvs/alsa-driver/kbuild] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.10-rc2'
make: *** [compile] Error 2

I tried it with both gcc 3.2.3 (Debian), 3.3.5 (Debian 1:3.3.5-2) and
3.4.2 (Debian 3.4.2-3). Looks more like Linux version incompatibility?
Am I doing something wrong?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-04 17:02 flink          New Issue                                    
11-13-04 22:18 rlrevell       Note Added: 0002403                          
11-13-04 22:31 rlrevell       File Added: patch                            
11-13-04 22:33 rlrevell       Note Added: 0002404                          
11-16-04 00:13 visit0r        Note Added: 0002421                          
11-16-04 00:24 rlrevell       Note Added: 0002422                          
11-16-04 21:09 visit0r        Note Added: 0002430                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
