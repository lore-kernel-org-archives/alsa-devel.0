From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: nm256: register strangeness related to lockups
Date: Sun, 26 Mar 2006 21:26:31 -0500
Message-ID: <1143426392.1792.167.camel@mindpipe>
References: <20060326182607.GB11408@hermes.uziel.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060326182607.GB11408@hermes.uziel.local>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-03-26 at 20:26 +0200, Christian Trefzer wrote:
> Hi folks,
> 
> in the process of analyzing the frequent crashes during the snd-nm256
> module insertion I stumbled across the following register values
> (reading 32bit words at a time in a loop with pcitweak):

Just to make sure, you are testing with 1.0.11-rc4 or CVS?  The nm256
lockup problems were thought to be fixed.  Or is this a different bug?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
