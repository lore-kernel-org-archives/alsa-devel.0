From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: a bug? (was: hw/plughw strange behaviour)
Date: Wed, 16 Jun 2004 18:49:32 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406161812270.15126-100000@studcom.urz.uni-halle.de>
References: <200406141227.47412.cpitaar@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200406141227.47412.cpitaar@yahoo.com.ar>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlos Pita <cpitaar@yahoo.com.ar>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Carlos Pita wrote:
> Anyway, the problem remains.

It works on my hardware, if I use an AC'97 codec (AD1985) or a YMF754
card:

Settings params for 'hw:0,0', dir is pointer = 1...
Buffer time doesn't match (requested 200000us, get 199999us)
Period time doesn't match (requested 100000us, get 99999us)

Dump of hwparams
----------------
RATE: (44100 44101)
PERIOD_TIME: (99999 100000)
PERIOD_SIZE: 4410
PERIODS: 2
BUFFER_TIME: (199999 200000)
BUFFER_SIZE: 8820

Dump of device setup
--------------------
rate         : 44100
buffer_size  : 8820
period_size  : 4410
period_time  : 99999

Settings params for 'plughw:0,0', dir is pointer = 1...
Buffer time doesn't match (requested 200000us, get 199999us)
Period time doesn't match (requested 100000us, get 66666us)

Dump of hwparams
----------------
RATE: (44100 44101)
PERIOD_TIME: (66666 66667)
PERIOD_SIZE: 2940
PERIODS: 3
BUFFER_TIME: (199999 200000)
BUFFER_SIZE: 8820

Dump of device setup
--------------------
rate         : 44100
buffer_size  : 8820
period_size  : 2940
period_time  : 66666



With an UA-1A (which supports 44.1 kHz only), using "hw:0,0" forces
the sample rate to be exactly 44100.  Using "plug:" fails:

Settings params for 'plug:ua1a', dir is pointer = 1...
Buffer time doesn't match (requested 200000us, get 199999us)
Period time doesn't match (requested 100000us, get 99977us)

Dump of hwparams
----------------
RATE: (44100 44101)
PERIOD_TIME: (99977 99978)
PERIOD_SIZE: 4409
PERIODS: (2 3)
BUFFER_TIME: (199999 200000)
BUFFER_SIZE: 8820
Unable to set hw params for playback: Invalid argument


It may be possible that the plug plugin tries to force that hardware
to use a non-integer sample rate.  Looks like a bug in the constraint
(matching) code.


And why are you trying to use dir=1 anyway?  Having a non-integer
sample rate doesn't make much sense to me.  :-)


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
