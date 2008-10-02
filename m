From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: How to start with a driver for custom hardware?
Date: Thu, 2 Oct 2008 10:16:31 +0100
Message-ID: <20081002091621.GA2848@sirena.org.uk>
References: <20081001155221.GA15760@sirena.org.uk>
	<20081002110233.v5wregwzs4k4w48g@correo.alumnos.unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AB781244C7
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Oct 2008 11:28:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081002110233.v5wregwzs4k4w48g@correo.alumnos.unican.es>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier.martinc@alumnos.unican.es
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 02, 2008 at 11:02:33AM +0200, javier.martinc@alumnos.unican.es wrote:

> What example or documentation could I check to see how the hardware 
> dependent
> code is integrated into the platform driver?

All of the subdirectories of sound/soc contain platform and machine
drivers which you can use as references for writing new ones.  Normally
it's the files with the directory name in them which provide the
platform support.
