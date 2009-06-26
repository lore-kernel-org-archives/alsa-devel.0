From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: RFC: ASoC driver for S3C24XX Simtec boards
Date: Fri, 26 Jun 2009 10:38:23 +0100
Message-ID: <20090626093822.GA5415@sirena.org.uk>
References: <20090624111155.GA390@fluff.org.uk>
	<20090625112658.GG17812@sirena.org.uk>
	<20090626084625.GB29142@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A5F9247DB
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Jun 2009 11:38:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090626084625.GB29142@trinity.fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-alsa@fluff.org>
Cc: Ben Dooks <ben@simtec.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 26, 2009 at 09:46:26AM +0100, Ben Dooks wrote:
> On Thu, Jun 25, 2009 at 12:26:59PM +0100, Mark Brown wrote:

> > If you need to give manual control of this to user space use a
> > DAPM_SOC_PIN_SWITCH widget.  Normally there's no need to do this since

...

> > This looks like a SND_SOC_DAPM_SPK(); using that will help with
> > sequencing.

> thanks, changed. still no output in the alsactl control dump though.

Like I say, you need to use a pin switch if you want to add manual
control.

> I'll have to add it in the resume path as well.

So on probe and resume, then?
