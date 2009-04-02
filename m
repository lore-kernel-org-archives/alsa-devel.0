From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: problem with speaker-test
Date: Thu, 2 Apr 2009 13:15:36 +0100
Message-ID: <20090402121536.GC4527@sirena.org.uk>
References: <49D1D250.7060500@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D186103848
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 14:15:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49D1D250.7060500@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 31, 2009 at 10:20:32AM +0200, Sedji Gaouaou wrote:

> I am trying to use speaker-test on my sam9g20 board, with the Wolfson  
> wm8731, but I can't have any tone...
> Instead it returns this error:
> # speaker-test -c 2 -t1

Hrm, interesting.  This command works fine for me out of the box on my
sam9g20 board with Linus' current mainline (v2.6.29-7100-g833bb30).

> speaker-test 1.0.14

I am using ALSA 1.0.18, does that help?  I'm not aware of any fixes,
though.
