From: Lars Hamren <hamren@sdu.se>
Subject: BUG REPORT: Missing #include statements
Date: Thu, 20 Mar 2003 17:51:55 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <15993.61867.885572.729660@maxi.int.sdu.se>
Reply-To: hamren@sdu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Several C source files does not explicitly include the headers files
they need; instead they rely on asoundlib.h to include them. Here is a
list of missing includes:

    alsa-tools-0.9.0rc7/ac3dec/output.c:               # include <assert.=
h>
    alsa-tools-0.9.0rc7/ac3dec/output.c:               # include <alloca.=
h>
    alsa-tools-0.9.0rc7/ac3dec/output.c:               # include <string.=
h>
    alsa-tools-0.9.0rc7/ac3dec/output.c:               # include <unistd.=
h>

    alsa-tools-0.9.0rc7/envy24control/driverevents.c:  # include <assert.=
h>

    alsa-tools-0.9.0rc7/envy24control/envy24control.c: # include <assert.=
h>

    alsa-tools-0.9.0rc7/envy24control/hardware.c:      # include <assert.=
h>

    alsa-tools-0.9.0rc7/envy24control/mixer.c:         # include <assert.=
h>

    alsa-tools-0.9.0rc7/envy24control/patchbay.c:      # include <assert.=
h>

    alsa-tools-0.9.0rc7/envy24control/volume.c:        # include <assert.=
h>

    alsa-tools-0.9.0rc7/sb16_csp/cspctl.c:             # include <fcntl.h=
>
    alsa-tools-0.9.0rc7/sb16_csp/cspctl.c:             # include <unistd.=
h>
    alsa-tools-0.9.0rc7/sb16_csp/cspctl.c:             # include <assert.=
h>
    alsa-tools-0.9.0rc7/sb16_csp/cspctl.c:             # include <string.=
h>
    alsa-tools-0.9.0rc7/sb16_csp/cspctl.c:             # include <errno.h=
>

    alsa-tools-0.9.0rc7/seq/sbiload/sbiload.c:         # include <assert.=
h>
    alsa-tools-0.9.0rc7/seq/sbiload/sbiload.c:         # include <unistd.=
h>
    alsa-tools-0.9.0rc7/seq/sbiload/sbiload.c:         # include <fcntl.h=
>
    alsa-utils-0.9.0rc7/seq/aseqnet/aseqnet.c:         # include <assert.=
h>
    alsa-utils-0.9.0rc7/seq/aseqnet/aseqnet.c:         # include <errno.h=
>

This is not a problem for users of the standard asoundlib.h, but=20
a problem when developing an alternative header file for a new
language binding.

As I do not have CVS access, I cannot update the source.

Regards
/Lars
-------------------------------------------------------------------
Lars Hamr=E9n              Tel...: +46(46)189090
Svensk Datorutveckling   e-post: hamren@sdu.se
Vadm=F6llan 211            WWW...: www.sdu.se
S-225 94 Lund
Sweden


-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.  
Does your code think in ink? You could win a Tablet PC. 
Get a free Tablet PC hat just for playing. What are you waiting for? 
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
