From: "Arcady Genkin" <agenkin@thpoon.com>
Subject: alsa-tools-0.9.7 compilation failure in hdsploader with headers
 from 2.4
Date: 2 Oct 2003 19:52:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <uobrszp585.fsf@bashful.cdf.toronto.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

The code for hdsploader from the 0.9.7 does not compile.  The problem
is on line 81 in hdsploader.c:

    firmware.firmware_data = (unsigned long *) fw;

This produces the following (fatal) error message:

  hdsploader.c: In function `upload_firmware':
  hdsploader.c:81: incompatible types in assignment

This line has changed from 0.9.6, where the words from "fw" were
assigned to firmware.firmware_data iteratively.

I have also noticed that this compiles fine with the Linux headers
from 2.6.0-test6, but breaks with the linux headers from 24.  Having
looked in include/sound/hdsp.h, the declaration of hdsp_firmware_t has
changed:

,----[ Linux headers from 2.4.18 ]
| typedef struct _snd_hdsp_firmware hdsp_firmware_t;
| 
| struct _snd_hdsp_firmware {
|         unsigned long firmware_data[24413];
| };
`----

,----[ Linux headers from 2.6.0-test6 ]
| typedef struct _snd_hdsp_firmware hdsp_firmware_t;
| 
| struct _snd_hdsp_firmware {
|         unsigned long *firmware_data;   /* 24413 long words */
| };
`----

Could somebody please have a look at these?
-- 
Arcady Genkin

guilt is the cause of more disauders
than history's most obscene marorders (E.E. Cummings)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
