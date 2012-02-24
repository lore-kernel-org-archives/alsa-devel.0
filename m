From: Paul Fertser <fercerpav@gmail.com>
Subject: Re: [PATCH] Add default config for tegra-alc5632
	(as	found on paz00)
Date: Fri, 24 Feb 2012 12:43:47 +0400
Message-ID: <20120224084346.GI22762@home.lan>
References: <1328561498-19337-1-git-send-email-fercerpav@gmail.com>
	<4F30BC18.3040102@nvidia.com>
	<CALq1K=+brR4OgPzfANKTFDoD-8Pbm0WjwXH+ZzShHvkGg6ntwA@mail.gmail.com>
	<20120207125404.GD11313@home.lan>
	<20120207131339.GK3332@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20120207131339.GK3332@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patch@alsa-project.org" <patch@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Marc Dietrich <marvin24@gmx.de>, Oliver Grawert <ogra@ubuntu.com>, Leon Romanovsky <leon@leon.nu>, Andrey Danin <danindrey@mail.ru>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Feb 07, 2012 at 01:13:39PM +0000, Mark Brown wrote:
> On Tue, Feb 07, 2012 at 04:54:04PM +0400, Paul Fertser wrote:
> > Mark, do you have some idea how to solve the issue at hand (having
> > dmix on this netbook by default) better? Is quantity of maximum
> > simultaneous playback/record PCM streams already queryable by the
> > userspace? Somehow it happened that adding per-device config file was
> > ok during all these years, is there a better way now?
> 
> For almost all devices there's one stream supported in each direction,
> if we were assuming any default that'd be it.

Takashi, can you please provide some feedback on this thread?

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
