From: <ico@fuse.net>
Subject: hdspmixer issues
Date: Fri, 2 Jul 2004 0:22:59 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040702002259.LHBA27242.smtp3.fuse.net@smtp.fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: ico@fuse.net
List-Id: alsa-devel@alsa-project.org

Hi all!

I've been messing with hdsp (again :-) and found out that my hdspmixer has very oddly behaving sound meters. While the input (2nd row) appears to be more or less ok (the yellow peak things kind of fly all over the place and often drop off below green lines or even completely dissapear), the analog outputs as well as combined monitoring output (front 1/4" phono jack on the multiface) only occassionally spike with a line input (usually only one channel). I am wondering why this is so since the audio is definitely working ok, but the monitoring of the outputs simply isn't working (at least not visually).

I am using Mdk10.0 community with lots of updates.
Alsa 1.0.4rc2 as well as 1.0.5 (libs are from 1.0.4rc2 at this point).

Could this be the version of fltk I am using or something more serious?

I am using 2.6.5 and 2.6.7 kernels.

Any help is greatly appreciated!

Best wishes,

Ico




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
