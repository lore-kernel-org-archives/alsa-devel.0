From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Support for platform bus
Date: Thu, 01 Sep 2005 00:42:36 +0100
Message-ID: <1125531756.3348.11.camel@mayday.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

I am attempting to write an ALSA driver for the sound card on the
Dreamcast.

I have this in the code:

	snd_card_set_dev(dreamcastcard, &platform_bus);

No errors are reported but the card doesn't show up in sysfs as a device
registered to the platform bus - is this because I need to do more to
force the device to appear there? (it doesn't appear under any bus but
it does show up as a module in sysfs):

sh-3.00# cd module
sh-3.00# ls -l
drwxr-xr-x    3 root     root            0 Aug 31 18:23 lockd
drwxr-xr-x    3 root     root            0 Aug 31 18:23 psmouse
drwxr-xr-x    3 root     root            0 Aug 31 18:26 snd
drwxr-xr-x    2 root     root            0 Aug 31 18:26 snd_card_aica
drwxr-xr-x    2 root     root            0 Aug 31 18:26 soundcore
sh-3.00# ls -l snd_card_aica/
-r--r--r--    1 root     root         4096 Aug 31 18:29 refcnt


Please cc me into any replies as I am not (yet - mailman seems slow)
subscribed to the list.

Thanks

Adrian



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
