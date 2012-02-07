From: Paul Fertser <fercerpav@gmail.com>
Subject: Re: [PATCH] Add default config for tegra-alc5632
	(as	found on paz00)
Date: Tue, 7 Feb 2012 16:54:04 +0400
Message-ID: <20120207125404.GD11313@home.lan>
References: <1328561498-19337-1-git-send-email-fercerpav@gmail.com>
	<4F30BC18.3040102@nvidia.com>
	<CALq1K=+brR4OgPzfANKTFDoD-8Pbm0WjwXH+ZzShHvkGg6ntwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CALq1K=+brR4OgPzfANKTFDoD-8Pbm0WjwXH+ZzShHvkGg6ntwA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patch@alsa-project.org" <patch@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Marc Dietrich <marvin24@gmx.de>, Oliver Grawert <ogra@ubuntu.com>, Andrey Danin <danindrey@mail.ru>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 07, 2012 at 08:57:59AM +0200, Leon Romanovsky wrote:
> On Tue, Feb 7, 2012 at 07:52, Stephen Warren <swarren@nvidia.com> wrote:
> > On 02/06/2012 12:51 PM, Paul Fertser wrote:
> >> This makes paz00 (aka Toshiba ac100, a popular arm-based netbook) use
> >> dmix/dsnoop by default since it doesn't support hw mixing.
> >
> > This patch appears to match on card name being "tegra-alc5632", but the
> > device tree code that just got checked in will name the card "Compal
> > PAZ00" I believe. (and I believe this driver only supports DT not board
> > files) Am I missing something?
> Stephen, Mark,
> I want to raise our old question: "How do we need to call this card ?
> Do we need to call it tegra-alc5632, as was in pre-DT era ? Or do we
> need to call it "Compal PAZ00" as we introduced in DT patches ?".
> 
> The both names are applicable because "Compal PAZ00" is the name of
> notebook (hardware board) and tegra-alc5632 is the name of chips were
> used.

Since alsa-lib config file describes how to best deal with the
combination of chips rather than a particular notebook name
(especially given same device can have different names from different
vendors and at the same time some vendors are ill-minded enough to
call different devices with the same name) it would seem more logical
to stick to the chips' names.

Mark, do you have some idea how to solve the issue at hand (having
dmix on this netbook by default) better? Is quantity of maximum
simultaneous playback/record PCM streams already queryable by the
userspace? Somehow it happened that adding per-device config file was
ok during all these years, is there a better way now?

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
