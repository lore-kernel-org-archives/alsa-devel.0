From: Robert Siemer <Robert.Siemer@gmx.de>
Subject: miroSOUND development [was: Avance ALS-007]
Date: Mon, 08 Jul 2002 15:11:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020708151101X.siemer@panorama.hadiko.de>
References: <20020707131119.GA535@localhost>
	<s5h7kk6v75k.wl@alsa2.suse.de>
	<20020708120245.GB487@localhost>
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020708120245.GB487@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: martin-langer@gmx.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

From: Martin Langer <martin-langer@gmx.de>

> I still have another (I think unsupported) card a "miroSOUND
> PCM12";-)
> ... but that job looks a little bit to hard for me at the moment 
> (strange ACI mixer ...).

I rewrote the OSS aci driver for 2.4 some time ago and am still
willing to write ALSA support for that cards. That's currently on
hold, also because of the "unperfect" code base in ALSA. I'll restart
my work in some weeks/month.

The last thing I did for the miroSOUND cards is this description of
the PCM20 card and their corresponding (in theory) drivers:

http://backsla.sh/~siemer/miro/
(unfinished but useful?)

and the mentioned "driver" for the eeprom (which is currently not on
my server)...

My goal is to support multiple cards and for that the PCM20 in ISA-pnp
mode.

Further:
You could use the OSS aci.c driver to drive the ACI (hehe :-). It's
independent from any other sound components and is just giving
(OSS-like) access to the mixer (for cards < PCM20; a little more
advanced for PCM20).


Bye,
	Robert


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Oh, it's good to be a geek.
http://thinkgeek.com/sf
