From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: Standard PCM name?
Date: Fri, 14 Jan 2005 11:30:39 +0000
Message-ID: <20050114113038.GA23735@palantir8>
References: <s5hoefta0qj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hoefta0qj.wl@alsa2.suse.de>
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

On Thu, Jan 13, 2005 at 02:59:32PM +0100, Takashi Iwai wrote:
> Hi,
> 
> on alsa-lib 1.0.8, I redefined the "default" PCM so that the
> card-specific definition can override.  Together with this change,
> I added a feature to pass the card number for this pcm.
> i.e.
> 	aplay -Ddefault:1 foo.wav
> 
> will play with the default PCM definition on the second card.
> 
> I think this stuff itself, the card-specific default PCM definition,
> is nice.  But it (e.g. default:1) won't work always if user overrides
> the default pcm via ~/.asoundrc.

Could you give an example of this, please?

> So, I'd like to propose a new set of PCM definition.
> 
> - "default" doesn't take arguments (e.g. card number) but it defines
>   the system default one.  There is only one "default" for a system.
> 
> - A new PCM, "std", is defined for each card.  User shouldn't override
>   this definition.  When no card-specific definition is provided, it's
>   defined as plughw:$CARD,$DEV.
> 
> - The default "default" is std:0.
> 
> The merit to split "default" and "std" is that std:X should always
> work regardless how default PCM is defined.

How is "std:1" different from "hw:0"?

> Any comments?  Better names?

Maybe a name that is consistent with /dev/snd filenames, like "pcm"?

It is not clear to me how you'd ultimately like to see user configure
their Alsa setup, and as a consequence what device sound applications
should use. From my limited knowledge I think this is your goal:

1) User sets default to "std:X" in .asoundrc. Applications play to "default"
   device.
2) Applications that do not specify a device play to "hw:0". (right?)

After thinking about it, I'm getting pretty confused by it all. The best
approach for applications I think is not to specify a device at all, but
let .asoundrc and something like aconnect decide.

Best regards,
-- 
Martin


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
