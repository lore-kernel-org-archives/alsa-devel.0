From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 03/12] ASoC: kirkwood: Remove unused drivers
Date: Tue, 29 Jul 2014 22:48:53 +0200
Message-ID: <20140729204853.GC17763@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
 <1405028192-9623-4-git-send-email-andrew@lunn.ch>
 <20140729193509.GK17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140729193509.GK17528@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 29, 2014 at 08:35:09PM +0100, Mark Brown wrote:
> On Thu, Jul 10, 2014 at 11:36:23PM +0200, Andrew Lunn wrote:
> > Both kirkwood-openrd and kirkwood-t5325 drivers have been replaced
> > with DT based simple-card equivelents. So remove these drivers.
> 
> Applied.  Please send patches against current code, I needed to hand
> apply this.

Hi Mark

By current do you mean asoc-next? That would not be very easy, since
i'm patching a large number of subsystems here. I don't think the
gpio, or the libata, or the led maintainer would be too happy if i
based the patches on asoc-next! So i picked a plain -rcX kernel,
something neutral to everybody.

	  Andrew
