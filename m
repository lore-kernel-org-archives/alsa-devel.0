From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Audigy2 mixer not working
Date: Tue, 11 Mar 2003 09:26:14 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303110926.14478.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi, am I being stupid, or do the mixer controls not work under the Audigy2.

If I run alsamixer, I can adjust sliders.... but it has no effect on the 
output. I can run other programs (e.g. xmms) simultaneously, and see the 
silder changing in alsamixer, but again, it has no effect on the output.

I _can_ hear sound, its just that I cannot change volume settings in software.

Interestingly, I can send output to the correct speakers using "aplay -D 
rear", "aplay -D front" etc...

Can anyone give me any pointers as to how to fix this.. I'm not up (yet) on 
ALSA's architecture. I _did_ see some files that looked something like mixer 
definitions in /usr/share/alsa... 

-- 
adq


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
