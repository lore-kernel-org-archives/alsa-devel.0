From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: timer/sequencer driver issues: pulling my grey
	hair out
Date: Tue, 18 Oct 2005 23:33:52 -0400
Message-ID: <1129692832.8910.51.camel@mindpipe>
References: <20051018210040.GB27858@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051018210040.GB27858@rhlx01.fht-esslingen.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: andi@lisas.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-10-18 at 23:00 +0200, Andreas Mohr wrote:
> - why is the program configuring a dangerously low sticks value of 1?
>   Is it due to a remaining misdeclaration of my timer attributes
> somewhere, or is it because of this program being stupid in its timer
> parameter choice?

Sorry, no idea.  The timer API is the one part of ALSA that is still
quite poorly documented.  Does the timer test utility that comes with
alsa-lib work?

> - it's a very good idea to get rid of the "stupid" *hidden* sticks
> bending in snd_emu10k1_timer_start(), right? Preferrably use an
> intelligent communication instead that makes sure that the program
> uses an sticks value that won't cause IRQ overload?
> 

I just copied this code over from the OSS driver.  I have no reason to
think it's correct.  All the information we have on the emu10k1's
interval timer comes from these comment by some anonymous Creative
engineer in emu10k1.h:

263 #define TIMER                   0x1a            /* Timer terminal count register                */
264                                                 /* NOTE: After the rate is changed, a maximum   */
265                                                 /* of 1024 sample periods should be allowed     */
266                                                 /* before the new rate is guaranteed accurate.  */
267 #define TIMER_RATE_MASK         0x000003ff      /* Timer interrupt rate in sample periods       */
268                                                 /* 0 == 1024 periods, [1..4] are not useful     */

Lee



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
