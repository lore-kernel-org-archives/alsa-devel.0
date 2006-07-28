From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Question about kernel timers
Date: Fri, 28 Jul 2006 11:14:50 -0400
Message-ID: <1154099690.2927.133.camel@mindpipe>
References: <1153864917.25859.238.camel@mindpipe>
	<44C9C403.8040301@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44C9C403.8040301@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-07-28 at 09:00 +0100, James Courtier-Dutton wrote:
> What is the purpose of these event timers?
> I can't think of any sound card that needs this sort of stuff.
> Can you use polling instead?
> 

It's a driver for a MIDI device that has to snoop the MIDI stream for
note-on/note-off and perform several operations on some custom hardware
- one immediately, and two more many milliseconds later.

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
