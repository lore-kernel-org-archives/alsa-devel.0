From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH v2 0/4] Mark mpc5200 i2s driver BROKEN
Date: Mon, 27 Apr 2009 20:50:06 +0100
Message-ID: <20090427195005.GA14626@sirena.org.uk>
References: <20090427164108.18211.44680.stgit@terra>
	<fa686aa40904270953p6e82bea8t6aa8fec2885b94b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CC0251037EE
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 21:50:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fa686aa40904270953p6e82bea8t6aa8fec2885b94b5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2009 at 10:53:34AM -0600, Grant Likely wrote:

> BTW, you could have added my acked-by lines to the patches which I

I've added your ack to the BROKEN patch, which I have applied for merge
into 2.6.30.  I'll leave the other two patches for now in case there is
some reason for exporting the DAI operations, in which case the split
might need to be done differently.

> acked on the linuxppc-dev list.  Also, for the next version (if there
> is one), please post to both the alsa and linuxppc lists.
some 

Please also CC me; in general you should CC maintainers for patches
which you are submitting.
