From: Alexandr <spiro@demiart.ru>
Subject: 1.0.11rc1: still problem with alsamixer ?
Date: Sun, 18 Dec 2005 16:30:38 +0200
Message-ID: <43A5728E.8030103@demiart.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

So. I update my alsa-drivers, -lib , -utils to 1.0.11rc1 - right now my
Live 5.1 detect correctly, but problem with alsamixer is stay:

kernel 2.6.14 , when i execute "alsamixer" get a next message:

ALSA lib simple_none.c:1218:(simple_add1) helem (MIXER,'Front Playback 
Volume',0,0,0) appears twice or more

alsamixer: function snd_mixer_load failed: Invalid argument

and alsamixer don't run, same with amixer.

And silence from my rear speakers after update, early i has a copy of
front speakers on it.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
