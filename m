From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: Re: [Rosegarden-devel] Re: Sequencer port type flags
Date: Fri, 09 May 2003 11:11:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EBB7EEF.5060908@all-day-breakfast.com>
References: <Pine.LNX.4.44.0305082159360.1435-100000@pnote.perex-int.cz> <3EBB7ABE.3000308@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: rosegarden-devel <rosegarden-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Chris Cannam wrote:
> Are you saying that a soft synth that
> can only be driven via MIDI should not describe itself as a SYNTH?
> If so, how do I know it's a synth?

I suppose (replying to myself) that it's all about what these flags
are intended to be used for.  I had assumed they were basically
informational flags for identifying classes of device, and as I've
only had to deal with MIDI clients (and then only very naively),
I've only really thought about clients that are already assumed to
understand MIDI.

I suppose the alternative is that these flags are necessary to
distinguish between different modes of communication -- different
sorts of events that a particular client understands.  So once
I've found out that a device is a MIDI device, how I find out that
it's then a synth is entirely my problem -- the API doesn't care,
because MIDI is all the same to it anyway.

If that's so, then these flags are of no use to Rosegarden.


Chris



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
