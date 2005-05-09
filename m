From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Q: Is there a testsuite?
Date: Mon, 9 May 2005 11:30:34 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505091042490.20877-100000@studcom.urz.uni-halle.de>
References: <200505071231.26517.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200505071231.26517.p_christ@hol.gr>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "P. Christeas" <p_christ@hol.gr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

P. Christeas wrote:
> I was wondering if there is some ALSA testsuite,

There are some programe in alsa-lib/test/, but those are for testing
the ALSA library.

> that will detect if -my- soundcard covers all the ALSA
> functionality it exports with some X kernel.

Sound card capabilities are too different to be able to create a test
suite that fits all.

You could create a script specific to your sound card that calls
aplay/arecord/amidi/aplaymidi/amixer/etc.


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
