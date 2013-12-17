From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: imx-spdif: Use module_init() to
 handle platform_device_register()
Date: Tue, 17 Dec 2013 11:05:09 +0800
Message-ID: <20131217030507.GA1441@MrMyself>
References: <1387190169-7936-1-git-send-email-Guangyu.Chen@freescale.com>
 <20131216194717.GO3185@sirena.org.uk>
 <20131216211958.GS4360@n2100.arm.linux.org.uk>
 <20131216221710.GH3185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 by alsa0.perex.cz (Postfix) with ESMTP id ECEAE260857
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 04:17:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131216221710.GH3185@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 16, 2013 at 10:17:10PM +0000, Mark Brown wrote:
> On Mon, Dec 16, 2013 at 09:19:58PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Dec 16, 2013 at 07:47:17PM +0000, Mark Brown wrote:
> > > What should work right now is for the module to ensure that the S/PDIF
> > > CODEC drivers are loaded before it is by linking to some symbol from
> > > there.  This is a total hack though.  Nicer would be for the machine
> > > driver to either directly register S/PDIF DAIs (rather than devices that
> > > then register the DAIs) or to create a card subdevice in parallel with
> > > the S/PDIF ones and hook the card registration off that.
> 
> > That creates much more complexity though, and adds yet more possibility
> > for unreliability into this.  "Keep it simple" is well worth following.
> 
> I don't see registering the DAIs directly as adding complexity here;
> it's essentially what the current code is trying to do and doesn't
> change the normal device registration flow at all.  I do agree that the
> card subdevice is more complex, I don't particularly like that idea
> myself. 

Thank you for the detailed advices. I'll first try to register the CODEC
DAI directly.

> > The simple thing here is to declare the codec device in the module init,
> > before registering the card driver, and cleaning it up at the appropriate
> > moment.  That way, the card platform driver gets registered and it can
> 
> It's certainly simple and it's definitely what I'd recommend for non-DT
> systems.  For DT systems it'll cause issues if two drivers both try to
> register the same device on module load and the second one to get loaded
> checks for errors.  Another way is just to do that in the core so we

And this might be another topic that we wouldn't have this problem if we
could use DT nodes for the S/PDIF CODEC driver as well. Since we are now
using DT systems, mixing up a non-DT way might have this kinda unexpected
result, although I admit this should be the responsibility driver owners
and here is mine. But I'm still wondering is there any possibility for us
to find a balanced way to enroll the S/PDIF CODEC driver in DT?

Thank you,
Nicolin Chen
