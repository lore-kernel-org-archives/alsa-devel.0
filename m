From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 6/8] RX-51: Audio: Add usage of regulator
 framework to control VMMC2
Date: Mon, 19 Oct 2009 12:13:00 +0300
Message-ID: <20091019091300.GA17452__38656.4993452795$1255943922$gmane$org@esdhcp037198.research.nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-7-git-send-email-eduardo.valentin@nokia.com>
	<20091008132619.GE29176@rakim.wolfsonmicro.main>
	<20091012090455.GC13234@esdhcp037198.research.nokia.com>
	<20091012092104.GD3308@rakim.wolfsonmicro.main>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20091012092104.GD3308@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Tony Lindgren <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Oct 12, 2009 at 11:21:04AM +0200, Mark Brown wrote:
> On Mon, Oct 12, 2009 at 12:04:55PM +0300, Eduardo Valentin wrote:
> 
> > Right. Should we add 4 instances of drvdd and 2 of iovdd? So, naming those would be like:
> 
> No, if there's multiple pins for the supply then there's no need to
> represent those individually - they're required to be wired together in
> hardware.

Might be a stupid question probably because of my lack of knowledge of regulator framework,
but if the driver code must be written in such a way that it requires all regulators
for its supplies, then what happens with those which are grounded? How do you provide the
regulator_init_data in this case (where the supply is actually grounded) ?

BR,

-- 
Eduardo Valentin
