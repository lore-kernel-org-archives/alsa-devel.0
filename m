From: Laurent Georget <lgeorget2@club-internet.fr>
Subject: level plugin not loaded with current cvs
Date: Sat, 25 Jan 2003 12:18:25 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E327281.5070004@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

I have made sometimes ago a level plugin for Alsa called ameter.
(it is there:
http://perso.club-internet.fr/lgeorget/ameter.html
)
It was working fine until I checked out alsa cvs, and installing it
(yesterday).
After recompiling/installing  ameter without getting errors, , I have
now the following message when  using it:

[l@localhost l]$ arecord -D ameter -v sound.wav
ALSA lib dlmisc.c:107:(snd_dlsym_verify) unable to verify version for
symbol _snd_pcm_scope_ameter_open
ALSA lib pcm_meter.c:742:(snd_pcm_meter_add_scope_conf) symbol
_snd_pcm_scope_ameter_open is not defined inside /usr/local/lib/libameter.so
arecord: main:462: audio open error: No such device or address

There is the same message when using the plugin with Glame, and also
with Abramo Bagnara original level plugin.
(I am using Mandrake 9.0)

I installed back 0.9rc6, and it works fine again.

Any idea highly welcomed!

Laurent







-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
