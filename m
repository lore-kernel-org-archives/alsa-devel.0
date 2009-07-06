From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: davinci: update after EDMA
 interface changes
Date: Mon, 6 Jul 2009 23:25:12 +0100
Message-ID: <20090706222512.GH25548@sirena.org.uk>
References: <1246917723-27071-1-git-send-email-khilman@deeprootsystems.com>
	<1246917723-27071-2-git-send-email-khilman@deeprootsystems.com>
	<20090706220859.GF25548@sirena.org.uk>
	<87d48dlaju.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 642462454E
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 00:25:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87d48dlaju.fsf@deeprootsystems.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: alsa-devel@alsa-project.org, Sudhakar Rajashekhara <sudhakar.raj@ti.com>, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 06, 2009 at 03:19:01PM -0700, Kevin Hilman wrote:

> So should I queue this up along with my changes, or do you want to
> merge this into asoc?

It needs to go along with your changes at least to preserve bisect (it
should really be in the same commit that changes the API from that point
of view).  But see my reply to Troy's post - he's got some further ASoC
changes which depend on the new API and complicate matters a little.

So long as it all merges down fine for 2.6.32 I'm open to anything which
works well for you guys.
