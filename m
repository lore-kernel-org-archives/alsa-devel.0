From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] Audigy + FX8010 capture (hw:x,2) - again
Date: Wed, 14 Jul 2004 01:45:34 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1089783933.7103.18.camel@mindpipe>
References: <200406280700.i5S70jAQ017077@www4.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200406280700.i5S70jAQ017077@www4.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-06-28 at 03:00, Peter Zubaj wrote:
> Hi,
> 
> This patch fixes capture problems from hw:x,2 on Audigy. It is same as
>  previous, because it can be applied cleanly against CVS (I tested
> version from 23.06.2004) and hope it is still true for current CVS.
> 
> I tested 4 channel recrding and it was OK.
> 
> hw:x,2 records outputs from FX8010 (not FX buses)
> 
> Using "EFX voices mask" you can set channels what you want record.
> 
> use alsactl store to store config
> edit this config (set true for needed channel for "EFX voices mask"
> control) - I recorded channels 8,9,14,15 (front and rear output).
> use alsactl restore to restore config
> 
> Looks like channel count must be power of 2 (1, 2, 4, 8, ...).
> 

8 channel recording seems to work as well.  I get an error with 16.

What happens with the capture buffer interrupts when you double the
number of channels, using the same period size?  The FX capture buffer
does not seem to be per-channel.

Lee



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
