From: Serhiy Kachanuk <serzholino@gmail.com>
Subject: Problems with soundcard based on Realtek ALC860 audio codec
Date: Tue, 06 Dec 2005 11:11:04 +0200
Message-ID: <439555A8.8070306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-U; format=flowed
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

Hi!

I've got no answer at alsa-users, I'm posting this here:

I have motherboard with Intel 915PL Express Chipset with integrated
builtin audio subsystem based on Realtek ALC860 audio codec.

I use Kubuntu 5.10 Breezy Badger as my operating system and having
problems with this integrated soundcard. Original alsa from distribution
- 1.0.9a was totally unable to find my sound system. I have to disable
hotplug to make system boot. When I upgraded alsa to 1.0.10 and enabling
hotplug, soundcard became  recognized, modules for hda-intel loaded at
boot time, but I still have no sound :(. Kmix shows my soundcard as
Realtek880, but it is 860 and alsamixer and alsactl both printing errors
and not starting/working.

Is my soundcard supported? What do I need to make my sound system work
on Linux?

Thanks.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
