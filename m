From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: EMU10K1X and MIDI
Date: Tue, 06 Jul 2004 09:14:51 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0407060907200.7411-100000@studcom.urz.uni-halle.de>
References: <40EA0B37.7040409@nc.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <40EA0B37.7040409@nc.rr.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Francisco Moraes <fmoraes@nc.rr.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Francisco Moraes wrote:
> I added MIDI support for the EMU10K1X driver by slightly adapting the
> code in th emumpu401.c file. Given that I barely changed anything in
> that file, I was thinking about moving all the code into a .h file which
> can be parametrized with some #define's and #ifdef's.

Like opti92x-ad1848/opti92x-cs4231/opti93x, or ens1370/ens1371.
<nitpick>
But these drivers use a .c extension for this file.
</nitpick>

> Then, both the current file, the emu10k1x.c and audigyls.c drivers
> can reuse the same code without having to duplicate it.

Putting the common code into a module and parameterizing it at runtime
would be more, uh, modular, but I guess this probably wouldn't be
worth the effort because it's unlikely that somebody uses several of
these cards at the same time.


Regards,
Clemens




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
