From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: underrun problem when short audio play
Date: Tue, 16 Mar 2010 12:06:58 +0000
Message-ID: <20100316120658.GC21604@sirena.org.uk>
References: <17526962.152181268138676329.JavaMail.weblogic@epml01>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BE1FF2434D
	for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2010 13:06:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <17526962.152181268138676329.JavaMail.weblogic@epml01>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ANISH KUMAR <anish.singh@samsung.com>
Cc: maniyar@samsung.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 09, 2010 at 12:44:36PM +0000, ANISH KUMAR wrote:

> When i tried to increase the stop_threshold  but then i got "same audio played again kind of echo" problem.
> I can't try the solution suggested by jaroslav i.e. checking for DRAINING state in lower level driver and stop
> queuing because of some design issue as in my code i don't call drain function as soon as all buffers are written.
> I wait for some time(in miliseconds) and then call drain function.

What is the design issue in your driver?  If you're limited by that the
most obvious solution would seem to be to address that.  If your driver
is not responding promptly to requests to terminate playback then an
underrun doesn't seem surprising.
