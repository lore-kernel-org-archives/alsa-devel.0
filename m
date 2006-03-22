From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: ac3 in/out
Date: Wed, 22 Mar 2006 00:20:49 +0000
Message-ID: <44209861.8090005@superbug.co.uk>
References: <1142936836.4759.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1142936836.4759.3.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Johannes Berg wrote:
> Hi,
> 
> From what I've seen about ac3 in and also out, the support in alsa for
> that is more of a hack, and the data that is passed down the pcm
> interface actually contains the channel status bits for some drivers...
> Working on the new Apple stuff this isn't possible -- only some channel
> status bits can be set by the software, some are fixed. And they aren't
> interleaved in the stream, but set externally.
> 
> So the question is -- are there any plans to abstract some digital out
> API within alsa? Otherwise the userspace will need to handle all kinds
> of different devices differently since the data on the stream is
> essentially the same as the data the chipset needs.
> 
> johannes

What is the problem?
Application like xine and mplayer don't seem to have any problems with
AC3 out.

James



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
