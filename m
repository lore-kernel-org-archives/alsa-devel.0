From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC problem
Date: Thu, 15 May 2008 10:42:08 +0100
Message-ID: <20080515094207.GA13576@sirena.org.uk>
References: <ddeffb610805142102q5f19d120qd7e73c9babb838d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F2DF024754
	for <alsa-devel@alsa-project.org>;
	Thu, 15 May 2008 11:42:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ddeffb610805142102q5f19d120qd7e73c9babb838d4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Lu <alanlu001@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 15, 2008 at 12:02:46PM +0800, Alan Lu wrote:

>  I traced the soc_core.c and it never reaches soc_probe() routine.
>  That's why "No soundcards found."

>  Could you give me some light ?

Your machine driver (or some other part of the system initialisation)
should be registering a platform device with the name "soc-audio" and
device data pointing to a struct snd_soc_device containing machine init
functions.
