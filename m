From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Need help on porting ALSA to ARM
	application	baseboard
Date: Wed, 8 Apr 2009 10:55:43 +0100
Message-ID: <20090408095543.GD20122@sirena.org.uk>
References: <bd97640b0904072127g7838b604l30168358c37d43ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E4A0F1037F9
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 11:55:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd97640b0904072127g7838b604l30168358c37d43ca@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Diptopal Basu <diptopal.basu@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 08, 2009 at 09:57:28AM +0530, Diptopal Basu wrote:

>    I am working on ARM 926EJ-S Application baseboard . The board has a
> LM4549 codec connected through an AACI prime cell . I am running Linux
> 2.6.26.5 on this board and the requirement now is to have an ogg vorbis
> player running on the board , I am planning to use ogg123 for the same
> purpose , but it requires ALSA driver on the board . Do you have any
> information as to how to port ALSA on this particular board .

For embedded devices you'd normally want to do your support within the
ASoC framework.  This allows the CPU, machine and codec support to be
provided separately, providing easy code reuse.  There is also support
in the framework for automatic power management of the audio subsystem.

The code is in sound/soc in the kernel tree and there is some
documentation under Documentation/sound/soc.
