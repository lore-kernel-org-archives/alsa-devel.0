From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [alsa-devel] [PATCH 4/4] ARM: mx28evk: add missed clkmux
 select for saif
Date: Wed, 1 Aug 2012 10:47:38 +0800
Message-ID: <20120801024737.GB30492@shlinux2.ap.freescale.net>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-5-git-send-email-b29396@freescale.com>
 <20120721074002.GC923@S2101-09.ap.freescale.net>
 <20120723023632.GA9427@shlinux2.ap.freescale.net>
 <20120728082543.GB2128@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20120728082543.GB2128@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Guo Shawn-R65073 <r65073@freescale.com>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 28, 2012 at 04:25:48PM +0800, Shawn Guo wrote:
> On Mon, Jul 23, 2012 at 10:36:33AM +0800, Dong Aisheng wrote:
> > This patch series was made based on Mark's sound-2.6 tree.
> > Do you want this one go through mxs tree and other three go through Mark's tree?
> 
> Yes.  That's the way to save conflict.
> 
> > I'm thinking maybe it would be better go through one tree(Mark's or Yours) since
> > without this one the saif record still can not work.
> 
> The recording has been broken.  There is no point to force the whole
> series to go via one tree.  When sound and arm-soc get merged on
> linux-next (for testing) and mainline, the recording gets back to work.
> 
Understand.
Will rebase it and resend it for this one.

Regards
Dong Aisheng
