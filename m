From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: Re: [Rosegarden-devel] Re: Sequencer port type flags
Date: Fri, 09 May 2003 10:54:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EBB7ABE.3000308@all-day-breakfast.com>
References: <Pine.LNX.4.44.0305082159360.1435-100000@pnote.perex-int.cz>
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

Jaroslav Kysela wrote:
> Note that the SYNTH ports should support SNDRV_SEQ_EVENT_SAMPLE* events. 
> It means direct wavetable synthesis not MIDI event communication.

OK, now I'm confused again.  Are you saying that a soft synth that
can only be driven via MIDI should not describe itself as a SYNTH?
If so, how do I know it's a synth?

My interpretation so far has been that most soft synths should set
SYNTH, APPLICATION and possibly SAMPLE if they're sample-based,
whereas a sequencer like Rosegarden should set APPLICATION and
nothing else.  Do I have that wrong?

(And I don't know of any soft synths that are always GM devices,
so I'm doubtful -- as I mentioned in another email -- whether they
should be setting GM or not.)


Chris



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
