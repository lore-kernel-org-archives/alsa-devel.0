From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] alsamixer: Confirm that a drastic volume
 change is intentional.
Date: Fri, 13 Jan 2012 13:31:03 +0100
Message-ID: <4F102407.60708@ladisch.de>
References: <20120113111449.EDBE06FC039@msa105.auone-net.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 666E62454D
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 13:29:41 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 901E8233F1
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 07:29:36 -0500 (EST)
In-Reply-To: <20120113111449.EDBE06FC039@msa105.auone-net.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kusanagi Kouichi <slash@ac.auone-net.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Kusanagi Kouichi wrote:
> Home key has been disabled because it might at least surprise a user
> unless volume is already nearly full. Not only home but 9, 8 and so
> on might also surprise a user.

The surprise is not so much the amount of the resulting volume but the
meaning of the key; the user might have assumed that Home jumps to the
first control.  If the volume is too loud after pressing 9, it's easy
to press another smaller digit, but it would be more difficult to
remember a volume change key if the jump to 100% happens in a situation
where a volume change wasn't expected at all.

(And this would be a good reason to disable the End key, too.)

> So instead of disableing key, show confirmation dialog for drastic
> volume change.

A confirmation dialog is annoying to users who know what they're doing,
and still confusing to anybody else.

Instead of having commands that require confirmation, I think it's
better to have only commands whose meaning is obvious.

In this case, the jump-to-100% command doesn't seem to be very
worthwhile because you could just as well press PageUp a few times.
Is there a reason that you need this command, other than for symmetry
with the End command?


Regards,
Clemens
