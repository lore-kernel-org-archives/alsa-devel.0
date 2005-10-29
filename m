From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Linux 2.6.14: Total lockup using aplaymidi
Date: Sat, 29 Oct 2005 18:32:29 -0400
Message-ID: <1130625149.4449.3.camel@mindpipe>
References: <20051029200842.33920.qmail@web52913.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051029200842.33920.qmail@web52913.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-10-29 at 21:08 +0100, Chris Rankin wrote:
> --- Lee Revell <rlrevell@joe-job.com> wrote:
> > OK, great.  This is related to the recent change to make the RTC the
> > default timer for the ALSA sequencer, it's not an emu10k1 driver bug.
> 
> Which means it affects *every* ALSA user, and not just SB-Live! and Audigy owners ... ;-). I guess
> people just aren't using aplaymidi on SMP machines much.

You can blame Linus for this.  By insisting that default system timer
frequency be lowered from 1000HZ to 250HZ, he forced the ALSA developers
to use a different timer source for the sequencer.  There was not a lot
of time to test this before the 2.6.14 release.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
