From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Maintaining sound card at a specific frequency
Date: Wed, 19 Jan 2005 11:07:03 +0100 (CET)
Message-ID: <XFMail.20050119110703.pochini@shiny.it>
References: <s5hzmz6vdov.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzmz6vdov.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Knecht <markknecht@gmail.com>Mark Knecht <markknecht@gmail.com>, Patrick Shirkey <pshirkey@boosthardware.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 18-Jan-2005 Takashi Iwai wrote:

>> > You can add a control to lock the sample rate (e.g. ICE1712).
>>
>> Yep, I know, but it's not part of the pcm API: applications do not
>> lock the sample rate themselves. The user has to do it manually. This =
is
>> why I choosed an alternate solution. If apps were able to lock the rat=
e it
>> would be very useful. It may need some help from the driver, though.
>
> I think this is above the PCM API since this influences the whole
> system.  It's fine to add a new API call in alsa-lib, just as a
> wrapper to toggle such a  control, though...

My driver workarounds the problem this way:

When opencount=3D=3D1 the app can change the rate freely.
When opencount>1 the app can change the rate only if it
has not been set yet.
pcm_open() always returns the whole frequency range. There
is a rule that does rate_min=3Drate_max=3Dcurrent_rate when
the user cannot change the sample rate.

This solves all common cases:

1- trivial case:
        open, set_rate, play, close

2- single app, two substreams:
        open(1), open(2), set_rate(1), set_rate(2), ...
        open(1), set_rate(1), open(2), set_rate(2), ...

3- two apps:
        A               B
        open
        set_rate(44)
        ...             open
        ...             set_rate(48) -> sets 44
        ...             play
        close           ...
                        set_rate(48) -> sets 48
                        ...

Of course this method doesn't solve completely the problem
Mark is having, because it doesn't warrant that the rate stays
at 48K always.


--
Giuliano.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
