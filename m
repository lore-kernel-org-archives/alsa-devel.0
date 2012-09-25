From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 06/10] ALSA: Add firmware caching to CA0132
 codec.
Date: Tue, 25 Sep 2012 12:26:35 +0100
Message-ID: <20120925112634.GB32685@sirena.org.uk>
References: <1348198161-9256-1-git-send-email-ian_minett@creativelabs.com>
 <1348198161-9256-7-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1348198161-9256-7-git-send-email-ian_minett@creativelabs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ian Minett <ian_minett@creativelabs.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 20, 2012 at 08:29:17PM -0700, Ian Minett wrote:

> +static int request_firmware_cached(const struct firmware **firmware_p,
> +	const char *name, struct device *device)
> +{
> +	if (*firmware_p)
> +		return 0;  /* already loaded */
> +	return request_firmware(firmware_p, name, device);
> +}

This looks *awfully* like it should be a part of the generic firmware
loading infrastructure rather than driver local (the name of the
function is even likely to collide with something in the core code).

More generally, why is this driver different to other Linux drivers
which don't normally cache the firmware?  There's some uses for this
(see all the hassle with suspend and resume on USB devices...) so it
seems like it'd be useful to have in the framework, possibly as the
default behaviour and probably with a mechanism to discard the firmware.
