From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Bogus .ID macro in amidi.1,amixer.1,aplay.1,arecord.1
Date: Fri, 09 Jul 2004 09:14:17 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0407090910060.15453-100000@studcom.urz.uni-halle.de>
References: <200407081600.i68G06v7018790@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200407081600.i68G06v7018790@snark.thyrsus.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: Paul Winkler <zarmzarm@erols.com>, Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Eric S. Raymond wrote:
> The manual pages amidi.1, amixer.1, aplay.1, and arecord.1 contain a
> bogus macro .ID; I don't know what you thought you were doing with it,

Looks as if it might have been intended to reset the indent back to 0.

> but it will not produce the results you intend.

Fixed now, thanks!


Clemens




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
