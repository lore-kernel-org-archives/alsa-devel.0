From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] fix for ac97->front speaker routing (was
	Re:	Some Patches for emu10k1)
Date: Mon, 28 Jun 2004 15:50:58 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1088452257.16916.59.camel@mindpipe>
References: <200406280655.i5S6tMZK028081@www6.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200406280655.i5S6tMZK028081@www6.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net, Joachim Falk <joachim.falk@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-06-28 at 02:55, Peter Zubaj wrote:
> Hi,
> 
> >emu10k1.h in the ALSA driver, with some interesting additions.  The
> >following lines are *not* present in the ALSA driver:
> 
> They are in alsa but with diffrent names (most of them).
> Look at A_IOCFG in emu10k1.h
> I prefer alsa names (I am familiar with them).
> 

Yes, agreed, I prefer the prefixing ( FOO_ ) to infixing ( _FOO_ ).

Some of these are named values in the kX driver but magic numbers in the
ALSA driver.

Lee








-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
