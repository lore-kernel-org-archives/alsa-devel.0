From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: alsa-utils-0.9.0beta12: Bug in configure
Date: Wed, 3 Apr 2002 11:07:49 -0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204030808.g3388UX16054@Port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8bit
Received: from Port.imtp.ilyichevsk.odessa.ua (167.imtp.Ilyichevsk.Odessa.UA [195.66.192.167] (may be forged))
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA21564
	for <alsa-devel@alsa-project.org>; Wed, 3 Apr 2002 10:11:40 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

configure uses this to test whether there are alsa libs.
But this will fail always since nested functions are not
supported by C:

int main() {
  void main(void) {  // !?
    ...
  }
}

=================================
#line 1168 "configure"
#include "confdefs.h"

#include <alsa/asoundlib.h>

int main() {

void main(void)
{
/* ensure backward compatibility */
#if !defined(SND_LIB_MAJOR) && defined(SOUNDLIB_VERSION_MAJOR)
#define SND_LIB_MAJOR SOUNDLIB_VERSION_MAJOR
#endif
#if !defined(SND_LIB_MINOR) && defined(SOUNDLIB_VERSION_MINOR)
#define SND_LIB_MINOR SOUNDLIB_VERSION_MINOR
#endif
#if !defined(SND_LIB_SUBMINOR) && defined(SOUNDLIB_VERSION_SUBMINOR)
#define SND_LIB_SUBMINOR SOUNDLIB_VERSION_SUBMINOR
#endif

#  if(SND_LIB_MAJOR > $alsa_min_major_version)
  exit(0);
#  else
#    if(SND_LIB_MAJOR < $alsa_min_major_version)
#       error not present
#    endif

#   if(SND_LIB_MINOR > $alsa_min_minor_version)
  exit(0);
#   else
#     if(SND_LIB_MINOR < $alsa_min_minor_version)
#          error not present
#      endif

#      if(SND_LIB_SUBMINOR < $alsa_min_micro_version)
#        error not present
#      endif
#    endif
#  endif
exit(0);
}

; return 0; }
