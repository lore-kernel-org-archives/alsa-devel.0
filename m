From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: New laptop question
Date: Thu, 09 Mar 2006 09:40:28 +0100
Message-ID: <20060309084028.GB1314@turing.informatik.uni-halle.de>
References: <1141857436.9200.4.camel@soncomputer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1141857436.9200.4.camel@soncomputer>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Louis E Garcia II <louisg00@bellsouth.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Louis E Garcia II wrote:
> Looking at the HP Compaq nx9420, looks interesting. New hardware and
> linux can be hit or miss but I think all this hardware is supported.
> What I'm concerned about is audio, have no clue if ALSA supports it.

The HDA controller is supported.  The website doesn't tell which HDA
codec is used, but it seems to be from Analog Devices so it should be
supported, too.  There have been a few recent changes in the AD-related
part of the driver, so you might want to use the latest ALSA version.


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
