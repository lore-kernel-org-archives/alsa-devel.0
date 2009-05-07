From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Master vs. Front/Rear/LFE/... elements
Date: Thu, 7 May 2009 14:10:41 +0100
Message-ID: <20090507131040.GI27897@sirena.org.uk>
References: <20090506175824.GA30355@tango.0pointer.de>
	<s5hbpq5s3fx.wl%tiwai@suse.de>
	<20090507100915.GB27897@sirena.org.uk>
	<s5h1vr1434g.wl%tiwai@suse.de>
	<20090507125654.GB3968@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 03CEC247D3
	for <alsa-devel@alsa-project.org>;
	Thu,  7 May 2009 15:10:42 +0200 (CEST)
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>) id 1M23N3-0002We-Lv
	for alsa-devel@alsa-project.org; Thu, 07 May 2009 14:10:41 +0100
Content-Disposition: inline
In-Reply-To: <20090507125654.GB3968@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 07, 2009 at 02:56:54PM +0200, Lennart Poettering wrote:

> From the PA perspective I actually don't really need the full routing
> of the sound card exposed. I always want to focus on actual end-user
> use cases instead of exposing the full mixer capabilities. All I need
> to know is which elements are in the pipeline from my PCM streams to a
> specific output, resp. from a specific input to my PCM stream and a
> more high-level idea what those elements actually mean. i.e. all I
> need would be an API like this:

To a good approximation that is a fairly simple query on the full
routing information (modulo any bypass paths, I guess).  I'm not sure
the drivers would be able to answer your question without also being
able to answer any other routing question.
