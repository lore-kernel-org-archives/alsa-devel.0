From: Rolf Anderegg <rolf.anderegg@weiss.ch>
Subject: firewire-kernel-streaming branch into main kernel tree?
Date: Tue, 19 Mar 2013 13:25:36 +0100
Message-ID: <51485940.9070908@weiss.ch>
Reply-To: rolf.anderegg@weiss.ch
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zhbdzmsp-mail13.bluewin.ch (zhbdzmsp-mail13.bluewin.ch
 [195.186.99.121])
 by alsa0.perex.cz (Postfix) with ESMTP id 00C2D265D77
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 13:25:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Brian Karr <briank@tctechnologies.tc>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hello Clemens,

it's been a long time since I last inquired about the snd_dice module
provided by your firewire-kernel-streaming branch
(http://git.alsa-project.org/?p=alsa-kprivate.git;a=shortlog;h=refs/heads/firewire-kernel-streaming),
which is a good sign I guess. In the meantime we have been making heavy
use of the snd_dice module for over a year with all of our Weiss DICE
based products (obviously playback only), and it has proven to be
extremely stable (currently 3.4.18-rt29, patched with
firewire-kernel-streaming).
Therefore I have been meaning to ask you for some time now whether you
have any interest in merging this firewire-kernel-streaming branch into
the main kernel tree (at least as an experimental option, mind you), or
are there any major objections?
Given that you don't have unlimited time at hand to further develop the
snd_dice module, let alone provide capture support in the near future,
AND the fact that DICE is likely to see its EOL soon (and replaced by a
sophisticated successor by TCAT), I realize that this is probably not a
high priority. However from our perspective it would be sad to see these
ALSA Firewire proceedings be lost and not be appreciated by a larger
audience. With respect to this:
 * what would be the customary approach to requesting such a merge?
 * what are your reservations, resp. are there any existing shortcomings
that you are yet unhappy with?
 * have you received any other (negative/positive) feedback from
snd_dice users? I know of the Vortexbox community, which has been
offering an optional patch to support Firewire plackback devices; as far
as I know, they're happy with it.
 * if you need any backing or assistance, we'd be happy to help out

Keen to hear your feedback on this suggestion.
Best regards,

Rolf Anderegg

(Weiss Engineering Ltd.)
