From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: via82xx & acpi -> freeze bug
Date: Fri, 19 Nov 2004 21:14:11 -0500
Message-ID: <1100916852.26068.5.camel@krustophenia.net>
References: <20041120015224.GA1795@prog3>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041120015224.GA1795@prog3>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pavel Kysilka <goldenfish@bsys.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-11-20 at 02:52 +0100, Pavel Kysilka wrote:
> 	Hi all,
> 

I assume you mean 2.6.10-rc2...

It sounds like the via82xx suspend/resume support may not be
implemented.  You should file a bug report:

https://bugtrack.alsa-project.org/

Unfortunately the bug tracker is down right now...

> and i have 1 question: how about support emu10k1 chips and acpi ? is
> this support planned ?

I assume you are talking about suspend/resume support for the emu10k1
driver.  I might implement this.  However it is not very high priority.
See the emu10k1 /proc thread from yesterday for an explanation of what
needs to be done.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
