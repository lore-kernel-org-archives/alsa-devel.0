From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Do I have to use plugin?
Date: Wed, 5 Jan 2011 18:47:43 +0000
Message-ID: <20110105184743.GA17184@sirena.org.uk>
References: <AANLkTimBooxhWj7AYRSjS7zkMRd28y2wWGeWfaPmhs8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 528D1244F8
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 19:47:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTimBooxhWj7AYRSjS7zkMRd28y2wWGeWfaPmhs8a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 05, 2011 at 10:43:23AM -0800, Radivoje Jovanovic wrote:

> noticed that when I play a song that has weird rate that is not specified in
> the constraint list aplay would come back saying that it cannot set hardware
> parameters. If I play the same song using the virtual device through "plug"

If your hardware is capable of supporting other rates then why not just
it declare that support?
