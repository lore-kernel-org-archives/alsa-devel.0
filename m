From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: emu10k1 latency / capture period
Date: Wed, 16 Jun 2004 21:52:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40D0B2F6.2050400@superbug.demon.co.uk>
References: <1087416890.25102.21.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1087416890.25102.21.camel@debian>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> Hey,
> 
> I am having a problem with the emu10k1 driver where I am unable to set
> the capture period lower than 512.  The result is that the lowest
> achievable input to output latency is in the neighborhood of 40ms.
> 

This is due to a hardware restriction on the card.
The SB Live/Audigy have limits on the capture period sizes, but the 
playback is much more flexible.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
