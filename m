From: Markus Plail <plail@web.de>
Subject: Re: ANNOUNCE: ALSA driver for Compaq iPAQ
Date: Thu, 28 Mar 2002 11:32:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87pu1pvv70.fsf@www.gitteundmarkus.de>
References: <Pine.BSF.4.44.0203281110400.42547-100000@fest.stud.fee.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.BSF.4.44.0203281110400.42547-100000@fest.stud.fee.vutbr.cz> (Kasparek
 Tomas's message of "Thu, 28 Mar 2002 11:14:20 +0100 (CET)")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

* Kasparek Tomas writes:
> Hi all,

> first, partly usable, version of ALSA driver for Compaq iPAQ with
> Philips UDA1341TS sound chip is avaiable in ALSA CVS (alsa-driver/arm,
> alsa-driver/i2c/l3)

May it be that there is the l3.h file missing in CVS? Or that there is
an unneeded include? At least I had to comment the 
#include <linux/l3/l3.h> 
out to make it compile.

Regards
Markus
