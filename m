From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 27 Jan 2009 20:19:19 +0000
Message-ID: <20090127201919.GC6424@sirena.org.uk>
References: <200901271519.47119.anarsoul@gmail.com>
	<200901271822.32537.anarsoul@gmail.com>
	<20090127200051.GA6424@sirena.org.uk>
	<200901272214.45021.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 597A2243A9
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 21:19:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200901272214.45021.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 27, 2009 at 10:14:36PM +0200, Vasily Khoruzhick wrote:
> On 27 January 2009 22:00:52 Mark Brown wrote:

> > Hrm.  The completion makes this look more like it could use a full blown
> > regulator - it's certainly a pattern that will get reused often enough.

> It's commented out, I don't use completions anymore.

Yes, I assumed that was just temporary while you were working on this
though.
