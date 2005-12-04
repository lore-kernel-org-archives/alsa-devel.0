From: Tomas Carnecky <tom@dbservice.com>
Subject: internal structures and 32/64bit compatibility
Date: Sun, 04 Dec 2005 00:25:11 +0000
Message-ID: <43923767.2090704@dbservice.com>
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

I'm running gentoo on amd64 with the compat libs installes 
(emul-linux-x86-soundlibs). I'm seeing some strange things that make me 
think that either the internal structures have changed during the last 
few versions or that they aren't 32/64bit compatible.

I have a 64bit mplayer and 32bit wine which I use to play World of 
Warcraft. When I start mplayer to play a sound file, it works fine, I 
even can start a second mplayer and I can hear both sounds. Now when I 
start wine, I get this:
ALSA lib pcm_dmix.c:788:(snd_pcm_dmix_open) unable to create IPC shm 
instance

The other way around, when I start wine first, the in-game sound works 
fine. When I start mplayer later I get this:
mplayer: pcm_params.c:187: snd_pcm_hw_param_get_min: Assertion 
`!snd_interval_empty(i)' failed.

Looks like they (the 32 and 64bit libraries) don't understand each 
other. As I can't compile the 32bit libs on my own, they are precompiled 
by the gentoo staff, I don't know which version they are, but the 64bit 
alsa-lib has version 1.0.10.

Can someone explain whet is going on here?

I've tried to compile my own 32bit alsa-oss to test why teamspeak fails, 
but libtool keeps using absolute paths (/usr/lib/libasound.so) but the 
32bit libs are located in /usr/lib32, and I have no clue how to convince 
libtool to use "-lasound" instead of the absolete path. And I guess 
alsa-lib will be equally hard to compile for 32bit so I didn't even try it.

How can I compile alsa-lib for 32bit ?

thanks
tom


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
