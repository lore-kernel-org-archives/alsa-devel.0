From: Mario Loritz <loritz@fh-furtwangen.de>
Subject: alsa-driver-1.0.6a unresolved symbol
Date: Sat, 9 Oct 2004 11:13:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410091113.32047.loritz@fh-furtwangen.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello everyone,

On my system, alsa-driver-1.0.6a and alsa-lib-1.0.6 compile and
install fine, but when the soung server is restarted (by rcalsasound restart)
the new compiled driver cant be loaded. 

Error message:

Shutting down sound driver: done
Starting sound driver: snd-intel8x0 /lib/modules/2.4.21-243-athlon/kernel/
sound/acore/snd.o: unresolved symbol snd_compat_strlcpy_Rb4409a1e
/lib/modules/2.4.21-243-athlon/kernel/sound/acore/snd.o: insmod /lib/
modules/2.4.21-243-athlon/kernel/sound/acore/snd.o failed
/lib/modules/2.4.21-243-athlon/kernel/sound/acore/snd.o: insmod snd-intel8x0 
failed
done

I think I've seen this error before in an earlier version of alsa.
There, it could be fixed...

Greetings, 
Mario Loritz

System Information:
SuSE-Linux 9.0 kernel 2.4.21-243-athlon
Realtek ALC850
Athlon64, nforce3 250Gb Chipset



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
