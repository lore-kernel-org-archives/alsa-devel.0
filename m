From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: CVS commit [0.99.11] ALSA playback latency patch
Date: Thu, 18 Nov 2004 14:36:00 +0100
Message-ID: <20041118143600.59ca28b1@mango.fruits.de>
References: <878y8zvjbs.fsf@sulphur.joq.us>
	<874qjnvj3v.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <874qjnvj3v.fsf@sulphur.joq.us>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jack O'Quin <joq@io.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 17 Nov 2004 23:09:24 -0600
"Jack O'Quin" <joq@io.com> wrote:

> 
> I should have made it clear that this is a JACK update, not ALSA.  :-)

Frankly i must say, that i do not quite understand what this patch changes.

from jackd 0.99:

        -p, --period    Frames per period (default: 1024)
        -n, --nperiods  Number of periods in hardware buffer (default: 2)

--nperiods never set the buffer size. This was always done by --period. Care
to elaborate? I have the feeling i must be blindstruck. Also i think the
0.99 behaviour is perfectly allright.

flo


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
