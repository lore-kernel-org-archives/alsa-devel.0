From: "Nick Hogle" <fozzy915@hotmail.com>
Subject: Bug in pcm_plugin.c, function snd_pcm_plug_alloc?
Date: Tue, 16 Sep 2003 02:26:43 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Sea2-F56hIIqgRXrJro00002e39@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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

I believe this is a bug: the loop in plug_alloc doesn't iterate completely 
through the plugin linked list.   The problem with this, is that 
snd_pcm_plugin_alloc won't get called for every plugin in the list, and 
vital components of those plugins won't be initialized.

The solution would be to replace the while (plugin->next/prev) lines with 
while (plugin), to move lines: plugin = plugin->next/prev to the spot just 
after if (err < 0) return err;

I found that the aformentioned changes fixed a problem I was having with 
reading from /dev/dsp.   Unless I set the rate to 48000, then read() would 
always return 0.  This was because when read_transfer iterated through the 
plugins, the "rate conversion" plugin, which had not been initialized, had 
the value 0 in dst_channels[0].frames.  This caused the entire read call to 
return 0.

BTW, I'm using the intel8x0 driver, and the latest 0.9.6 release of 
alsa-drivers.

Anyone else agree that this is a bug?  Or am I missing something, that 
requires that plug_alloc to NOT iterate completely through the list?

Thanks,
-Nick

_________________________________________________________________
Get 10MB of e-mail storage! Sign up for Hotmail Extra Storage.  
http://join.msn.com/?PAGE=features/es



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
