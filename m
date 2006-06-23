From: Paul Collins <paul@briny.ondioline.org>
Subject: all-modular snd-aoa
Date: Fri, 23 Jun 2006 19:14:45 +1000
Message-ID: <87hd2cz116.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from jenny.ondioline.org (jenny.ondioline.org [66.220.1.122])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C2FF5142
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jun 2006 11:18:29 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: johannes@sipsolutions.net
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

I get this when building from Linus's current git tree:

    LD      sound/built-in.o
  ld: sound/aoa/built-in.o: No such file: No such file or directory
  make[1]: *** [sound/built-in.o] Error 1
  make: *** [sound] Error 2

Doing "touch sound/aoa/built-in.o" lets the build continue and
complete successfully.

-- 
Paul Collins
Melbourne, Australia

Dag vijandelijk luchtschip de huismeester is dood

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
