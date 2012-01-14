From: Kusanagi Kouichi <slash@ac.auone-net.jp>
Subject: Re: [PATCH] alsamixer: Confirm that a drastic volume
 change is intentional.
Date: Sat, 14 Jan 2012 21:35:36 +0900
Message-ID: <20120114123537.C3EAC6FC03D@msa105.auone-net.jp>
References: <20120113111449.EDBE06FC039@msa105.auone-net.jp>
	<4F102407.60708@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from msa105.auone-net.jp (msa105.auone-net.jp [61.117.18.165])
	by alsa0.perex.cz (Postfix) with ESMTP id 65216245ED
	for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2012 13:35:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F102407.60708@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2012-01-13 13:31:03 +0100, Clemens Ladisch wrote:
> Kusanagi Kouichi wrote:
> > Home key has been disabled because it might at least surprise a user
> > unless volume is already nearly full. Not only home but 9, 8 and so
> > on might also surprise a user.
> 
> The surprise is not so much the amount of the resulting volume but the
> meaning of the key; the user might have assumed that Home jumps to the
> first control.  If the volume is too loud after pressing 9, it's easy
> to press another smaller digit, but it would be more difficult to
> remember a volume change key if the jump to 100% happens in a situation
> where a volume change wasn't expected at all.
> 
> (And this would be a good reason to disable the End key, too.)
> 
> > So instead of disableing key, show confirmation dialog for drastic
> > volume change.
> 
> A confirmation dialog is annoying to users who know what they're doing,
> and still confusing to anybody else.
> 
> Instead of having commands that require confirmation, I think it's
> better to have only commands whose meaning is obvious.
> 
> In this case, the jump-to-100% command doesn't seem to be very
> worthwhile because you could just as well press PageUp a few times.
> Is there a reason that you need this command, other than for symmetry
> with the End command?
> 
> 
> Regards,
> Clemens

The reason for this patch is that there is #if 0-ed code. I thought
home key is supposed to set volume to 100%. But that's not true.
Please ignore this patch.
