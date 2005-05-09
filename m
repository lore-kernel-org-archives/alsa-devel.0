From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Plugin loading and unloading
Date: Mon, 9 May 2005 10:10:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0505090950410.1843@pnote.perex-int.cz>
References: <1114266960.10706.30.camel@pegasus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1114266960.10706.30.camel@pegasus>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 23 Apr 2005, Marcel Holtmann wrote:

> Hi guys,
> 
> I am working again on the A2DP Bluetooth plugin and the caching support
> in the latest ALSA library is nice and allows me to keep the underlaying
> link connected while stupid programs like XMMS closes the PCM when they
> switch the tracks.
> 
> The PCM opening part and reusing of the underlaying AVDTP connection is
> easy, but I am a little bit concerned about the plugin unloading time.
> So is it possible to add init() and exit() functions that are called
> when the plugin is loaded and unloaded. Like we have for kernel modules?

Wouldn't be possible to use ((constructor)) and ((destructor)) function 
attributes for this purpose?

> Do the ALSA library has a timer mechanism that we can use inside a
> plugin. Since it is a bad idea to hold the Bluetooth connection open for
> all the time, I like to add a idle timeout. This allows me to put the
> connection into sniff mode to save power or terminate it.

It's not possible to use any time resource using signals, because 
applications might be using the signal for another purpose. It seems
to me that the only possibility is to use fork() and code a little 
watchdog or use threads.

> Also the listing of plugins is still missing. I am fine with a general
> or plugin specific flag to make its PCM visible.

Yes, I was evaluating all possibilities and the result is that we will 
have a cache (configuration file) listing device names with short comments 
which applications should offer to users in their GUI.

In this case, a configuration tool (alsactl as standard ALSA tool or 
perhaps distribution specific) will check the installed and active plugins
and create a list automagically which can be altered with advanced users
later. Of course, the list won't be complete in any way, because 
there are unlimited variations of virtual device names.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
