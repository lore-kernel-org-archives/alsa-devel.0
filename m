From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: BT878 support.
Date: Thu, 13 May 2004 16:13:08 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405131601480.29494-100000@studcom.urz.uni-halle.de>
References: <40A26B76.4000200@fabricadeideias.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <40A26B76.4000200@fabricadeideias.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rodrigo Severo <rodrigo.lists@fabricadeideias.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Rodrigo Severo wrote:
> With the Askey Magic I got only silence but with the Prolink PlayTV Pro
> revision 9D I got bad sound with btaudio. By bad I mean a slightly high
> pitch soundI got the sound of the TV with a slightly higher pitch than
> usual and with more than usual noise during silence. The sound was bad
> but at least I got something.
>
> Do you think there is any chance for these boards to work with btaudio
> and/or snd-bt87x?

The driver supports the functionality that is implemented by the BT878
chip.  If a card has some extra hardware for amplifying/routing/etc.
that needs to be configured, the driver doesn't know about this.

It would be possible to add this hardware-specific support if there
would be some documentation about it.

> BTW, is there some kind of list with boards that work with btaudio
> and/or snd-bt87x?

My Hauppauge WinTV works.  It seems most other cards have added
features that must be configured explicitly.


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
