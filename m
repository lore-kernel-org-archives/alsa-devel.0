From: Roger Williams <raw@qux.com>
Subject: Re: hdsp multiface pci.
Date: 19 Jan 2003 18:12:39 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3hec4ka3c.fsf@grouper.coelacanth.com>
References: <3E2A952E.6060305@boosthardware.com>
	<1042985569.1663.33.camel@satellite.undata.org>
	<3E2AC45F.3070601@boosthardware.com>
	<1042992464.1649.55.camel@satellite.undata.org>
	<3E2AD34D.6070308@boosthardware.com>
	<1042996837.21521.17.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1042996837.21521.17.camel@satellite.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Is there a single amixer control to reset all of the HDSP mixer
registers?  I recall that there's some mechanism for resetting the
HDSP (other than re-installing the module), but I can't find it now.

For now, I use scripts like this to configure the mixer paths:

#!/bin/bash
# mute all Multiface analogue I/O connections

inputs="0 1 2 3 4 5 6 7 26 27 28 29 30 31 32 33"
analogue_outputs="0 1 2 3 4 5 6 7"
headphone_outputs="26 27"

function disconnect () {
    for output in "$@"; do
	for input in $inputs; do
	    echo -n "."
	    amixer cset numid=5 $input,$output,0 > /dev/null
	done
    done
    echo
}

echo -n "Disconnecting analogue outputs"
disconnect $analogue_outputs
echo -n "Disconnecting headphone outputs"
disconnect $headphone_outputs

-- 
Roger Williams <raw@qux.com>
Qux Tool & Die, Middleborough, Massachusetts
// Omne tulit punctum qui misquit utile dulci //


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
