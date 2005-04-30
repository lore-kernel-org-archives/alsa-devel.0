From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Plugin loading and unloading
Date: Sat, 30 Apr 2005 13:35:26 +0200
Message-ID: <1114860926.8836.139.camel@pegasus>
References: <1114266960.10706.30.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi again,

> I am working again on the A2DP Bluetooth plugin and the caching support
> in the latest ALSA library is nice and allows me to keep the underlaying
> link connected while stupid programs like XMMS closes the PCM when they
> switch the tracks.
> 
> The PCM opening part and reusing of the underlaying AVDTP connection is
> easy, but I am a little bit concerned about the plugin unloading time.
> So is it possible to add init() and exit() functions that are called
> when the plugin is loaded and unloaded. Like we have for kernel modules?

is it possible to get comments on this?

> Do the ALSA library has a timer mechanism that we can use inside a
> plugin. Since it is a bad idea to hold the Bluetooth connection open for
> all the time, I like to add a idle timeout. This allows me to put the
> connection into sniff mode to save power or terminate it.

I really need to use a timer inside my ALSA plugin. How do it do it?

> Also the listing of plugins is still missing. I am fine with a general
> or plugin specific flag to make its PCM visible.

Looks like the 1.0.9-rc3 is coming and this won't be part of it :(

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
