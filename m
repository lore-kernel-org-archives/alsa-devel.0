From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] [ALSA] Allow setting codec register with
	sys filesystem
Date: Mon, 6 Oct 2008 11:12:42 +0100
Message-ID: <20081006101242.GC14087@sirena.org.uk>
References: <1223164449-4133-1-git-send-email-troy.kisky@boundarydevices.com>
	<20081006095856.GA14087@sirena.org.uk>
	<s5h1vyughvv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <s5h1vyughvv.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 06, 2008 at 12:03:32PM +0200, Takashi Iwai wrote:

> OTOH, symmetrical read/write operations also good.
> Will be the sysfs register show op moved to debugfs, too?

I'd rather that were available all the time since it's so useful.

Adding a read interface in debugfs would certainly be sensible, though -
I have in the past considered adding a much more detailed readback
interface to debugfs which would not only dump the registers but also
provide some decode information (eg, reporting the mapping to controls
for the standard ASoC widgets).  Not something I have the time to do in
the immediate future, though.
