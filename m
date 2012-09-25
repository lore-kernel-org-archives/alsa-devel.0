From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_seq_parse_address accesses uninitialised data
Date: Tue, 25 Sep 2012 12:51:23 +0200
Message-ID: <50618CAB.1050607@ladisch.de>
References: <alpine.DEB.2.00.1209231903310.21223@anubis.informatik.uni-halle.de>
 <s5hsja7onmn.wl%tiwai@suse.de>
 <alpine.DEB.2.00.1209241614170.2471@anubis.informatik.uni-halle.de>
 <s5hk3vj8luz.wl%tiwai@suse.de>
 <alpine.DEB.2.00.1209241919140.6917@anubis.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6C105260744
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 12:51:26 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.00.1209241919140.6917@anubis.informatik.uni-halle.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Henning Thielemann <alsa@henning-thielemann.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Henning Thielemann wrote:
> I also asked in the valgrind mailing list and got this answer:
>    http://sourceforge.net/mailarchive/forum.php?thread_name=506089CA.5030309%40bitwagon.com&forum_name=valgrind-users
>
> Of course, I can suppress the message for me, but I expect that more
> people will stumble on it. Thus I'd prefer a resolution of the problem
> in ALSA.

If we worked around this bug in valgrind, then it would not be
possible to detect an actual uninitialized-use bug on this variable
with a (correctly-working) memory checker.


Regards,
Clemens
