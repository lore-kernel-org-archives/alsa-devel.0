From: "Cyril.Coquilleau@UTBM.fr" <Cyril.Coquilleau@utbm.fr>
Subject: capture with non-interleaved mode
Date: Tue, 14 Oct 2003 13:56:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1066132614.3f8be48663f25@webmail.utbm.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
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

Hi. I'm developping a signal processing program which needs to compute data 
from each channel of soundcards separately. 
After searches I found that I must open the soundcard with the 
SND_PCM_ACCESS_RW_NONINTERLEAVED flag but it doesn't works well : for each 
readn operation i get the -32 error code . Meanwhile, I tested capture in 
interleaved mode and it works well.
I had to use hw:x,y for the interleaved capture and plughw:x,y for the non-
interleaved capture, I don't know if non-interleaved capture works with hw:x,y.

Any advice (or piece of source code) ?

Thanks,

Cyril Coquilleau


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
