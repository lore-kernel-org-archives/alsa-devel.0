From: "Frank W. Miller" <fwmiller@cornfed.com>
Subject: snd_pcm_open fails
Date: Mon, 31 May 2004 17:22:59 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40BBA233.4000504@cornfed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
List-Id: alsa-devel@alsa-project.org


Hi,

I've got my header file installed now.  I had to install two rpms

alsa-lib-1.0.4-12.rhfc1.at.i386.rpm
alsa-lib-devel-1.0.4-12.rhfc1.at.i386.rpm

on my default Fedora Core 1 install.  I restarted and my cdplayer is 
still working so thats good.  I can also do my compiles with 
<alsa/asoundlib.h> being found and -lasound being linked, so thats good 
too.  Trouble is, now when I try to open the pcm devices with something 
like:

snd_pcm_open(..., "default", ...);

I'm getting a No such file or directory error.  Same thing for "plughw" 
and "plughw:0,0".  Anyone seen this before?

Thanks,
FM





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
