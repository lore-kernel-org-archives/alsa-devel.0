From: Greg KH <gregkh@suse.de>
Subject: Re: [alsa-devel] [PATCH] aoa: remove driver_data direct access of
	struct device
Date: Mon, 11 May 2009 23:57:43 -0700
Message-ID: <20090512065743.GA25267@suse.de>
References: <4A08828B.7090106@gmail.com> <s5hws8mu8my.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
Content-Disposition: inline
In-Reply-To: <s5hws8mu8my.wl%tiwai@suse.de>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net, Roel Kluin <roel.kluin@gmail.com>, alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 12, 2009 at 08:40:05AM +0200, Takashi Iwai wrote:
> At Mon, 11 May 2009 21:54:51 +0200,
> Roel Kluin wrote:
> > 
> > To avoid direct access to the driver_data pointer in struct device, the
> > functions dev_get_drvdata() and dev_set_drvdata() should be used.
> > 
> > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> 
> The same fix has been already in Greg's tree (and thus in linux-next).
> 
> Greg, is it OK that I take over your patch to sound git tree?

Yes, please do, no objection from me at all.

thanks,

greg k-h
