From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Hang up at .prepare( )
Date: Tue, 24 Jan 2012 10:55:29 +0000
Message-ID: <20120124105528.GA20519@opensource.wolfsonmicro.com>
References: <CANKRQngqJaAq7ucg3VzCMs+-KFXTSuJG=uq4d0kQ95gEMFfB4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C216424565
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 11:55:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANKRQngqJaAq7ucg3VzCMs+-KFXTSuJG=uq4d0kQ95gEMFfB4w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 24, 2012 at 06:38:45PM +0900, Tomoya MORINAGA wrote:

> I've faced issue when installing these drivers,
> system becomes hang up at async_synchronize_full_domain() of
> dapm_power_widgets()
> in .prepare().

> Do you have any information about this hang up ?

> I show details below.

What efforts have you made to debug this yourself?  Clearly this is not
happening for other people, perhaps it is related to something you have
in your drivers - have you addressed the issues raised with them?
