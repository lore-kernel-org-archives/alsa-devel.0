From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] [ALSA] Allow setting codec register with
	sys filesystem
Date: Mon, 6 Oct 2008 10:58:57 +0100
Message-ID: <20081006095856.GA14087@sirena.org.uk>
References: <1223164449-4133-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1223164449-4133-1-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 04, 2008 at 04:54:09PM -0700, Troy Kisky wrote:
> i.e. echo 6 59 >/sys/devices/platform/soc-audio.0/codec_reg
> will set register 0x06 to a value of 0x59

> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

I'd probably take a patch to do this in debugfs but I don't think it is
appropriate to do this in sysfs.  Writing to the registers outside the
control of the drivers can seriously interfere with their operation and
confuse user space - it's something you can get away with if you know
what you're doing but it's not something that should be available as a
standard, advertised interface.  There's also the possibility of the
driver trampling over any settings made with this interface which
wouldn't be helpful either.
