From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] ASoC: davinci: update after EDMA
	interface changes
Date: Mon, 06 Jul 2009 15:35:59 -0700
Message-ID: <87zlbhjv74.fsf@deeprootsystems.com>
References: <1246917723-27071-1-git-send-email-khilman@deeprootsystems.com>
	<1246917723-27071-2-git-send-email-khilman@deeprootsystems.com>
	<20090706220859.GF25548@sirena.org.uk>
	<87d48dlaju.fsf@deeprootsystems.com>
	<20090706222512.GH25548@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f188.google.com (mail-pz0-f188.google.com
	[209.85.222.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F36D24550
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 00:36:02 +0200 (CEST)
Received: by pzk26 with SMTP id 26so1625480pzk.16
	for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2009 15:36:01 -0700 (PDT)
In-Reply-To: <20090706222512.GH25548@sirena.org.uk> (Mark Brown's message of
	"Mon\, 6 Jul 2009 23\:25\:12 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Sudhakar Rajashekhara <sudhakar.raj@ti.com>, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Mon, Jul 06, 2009 at 03:19:01PM -0700, Kevin Hilman wrote:
>
>> So should I queue this up along with my changes, or do you want to
>> merge this into asoc?
>
> It needs to go along with your changes at least to preserve bisect (it
> should really be in the same commit that changes the API from that point
> of view).  

OK, it was originally part of the same patch, but I separated it out
thinking that the sound/* part would go upstream separately.

I'll merge it back into the original commit and update davinci-next.

> But see my reply to Troy's post - he's got some further ASoC
> changes which depend on the new API and complicate matters a little.

OK, will reply there.

Kevin
