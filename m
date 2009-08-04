From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: change set_tdm_slot api to allow
 slot_width override.
Date: Tue, 4 Aug 2009 21:55:45 +0100
Message-ID: <20090804205545.GB29518@sirena.org.uk>
References: <1245113071.24109.559.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DA312444A
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 22:55:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1245113071.24109.559.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 15, 2009 at 09:44:31PM -0300, Daniel Ribeiro wrote:
> Extend set_tdm_slot to allow the user to arbitrarily set the frame width
> and active TX/RX slots.

> Updates magician.c and wm9081.c for the new set_tdm_slot(). wm9081.c
> still doesn't handle the slot_width override.

> While being there, correct an incorrect use of SlotsPerFrm(7) use in
> bitmask on pxa-ssp.c (SSCR0_SlotsPerFrm(x) is (((x) - 1) << 24)) ).

> (this series is meant for Mark's for-2.6.32 branch)

> Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

So.  These have been sitting for quite some time now.  Unfortunately I
went on holiday immediately after it was last submitted my Zylonite
system has been bricked for pretty much all of the time since then so
I've been remiss in following up.  Sorry about that, my bad.

My inclination here is to apply these changes - they look like a clear
win for pretty much every machine except Daniel Mack's out of tree
system which needs the 64 bit TDM slots.  It's a shame to break that but
there seems to be such a clear advantage from the changes, especially
the new set_tdm_slot() API, that it seems like a win overall.  I've got
a feeling that the fix for that system may have to be allowing the
machine driver to rewrite the hw_params for the CPU driver to lie about
the data format.

I'll try to do that this week.
