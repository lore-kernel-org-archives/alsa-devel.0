From: Kevin Cernekee <cernekee@chromium.org>
Subject: Re: [PATCH V4 3/5] ASoC: tas571x: Add DT binding document
Date: Tue, 5 May 2015 15:56:09 -0700
Message-ID: <CAJzqFtaRd7GN6af=7jZSh01mL04XBFYE5cGfHY9V=p7uKFwf_A@mail.gmail.com>
References: <1430864057-3848-1-git-send-email-cernekee@chromium.org>
 <1430864057-3848-4-git-send-email-cernekee@chromium.org> <20150505223230.GL15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150505223230.GL15510@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 5, 2015 at 3:32 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 05, 2015 at 03:14:15PM -0700, Kevin Cernekee wrote:
>> Document the bindings for the soon-to-be-added tas571x driver.
>
> If this is different to the already applied patches send incremental
> updates.  If this is the same as the version of the driver that is
> already applied please don't resend already applied patches.

OK - I sent an incremental update for the one thing that changed in
the tas571x driver from V3 to V4.

Note that the regcache changes were intentionally ordered before the
tas571x commits, because the regcache changes are needed for the new
driver to work correctly.  In the for-next branch I see the tas571x
commits, but not the regcache changes.
