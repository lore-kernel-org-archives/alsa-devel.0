From: Thomas Charbonnel <thomas@undata.org>
Subject: hdsp driver status
Date: 14 Apr 2003 11:55:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1050314137.1382.23.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

To summarize the current problems with the driver :

* there is a locking issue which has been found and solved (thanks again
to Joshua N Pritikin). This was the cause of the freezes Mark and others
have been experiencing. I need to clean the code up before submitting a
patch (hopefully today).

* there is a problem with rev11 firmwares yet to be identified (the
simplest reason could be that the firmware files are wrong)

* the way the matrix mixer is handled for hdsp9652 cards seems wrong.
This could explain the absence of sound output Mark and others are
reporting.

Thomas




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
