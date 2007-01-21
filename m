From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: Need help: My .asoundrc no longer works.
Date: Sun, 21 Jan 2007 20:02:37 +0000
Message-ID: <20070121200237.GA2893@localhost.localdomain>
References: <loom.20070120T001557-202@post.gmane.org>
	<20070120140107.GC3067@localhost.localdomain>
	<75b66ecd0701200846q5499ccb0o5ba10c6a301d7b73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <75b66ecd0701200846q5499ccb0o5ba10c6a301d7b73@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 20, 2007 at 11:46:22AM -0500, Lee Revell wrote:
> On 1/20/07, John Rigg wrote:
> >You shouldn't need the plug converter if you specify the slaves channels
> >correctly. The ice1712 has 12 inputs and 10 outputs (regardless of how
> >many physical inputs/outputs your card has) and this needs to be
> >set explicitly in .asoundrc using separate playback and capture device
> >definitions. See here for explanation:
> 
> How could the above .asoundrc work given that the ICE1712 and EMU10K1
> devices are not synced at the hardware level?

Good question. I'm not familiar with the SBLive!, but I 
assumed (perhaps wrongly) that it had at least an S/PDIF output that
could be linked to the Delta's S/PDIF input.

jackd can actually run for a surprising length of time with unsynced
cards without alsa_pcm xrun messages (unlike jackdmp which produces a
slew of read errors), but I wouldn't expect to get a usable recording.

John

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
