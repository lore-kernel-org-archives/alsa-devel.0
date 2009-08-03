From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 09/20] OMAP3: McBSP: Lower the maximum
 buffersize for McBSP1, 3, 4, 5
Date: Mon, 3 Aug 2009 11:36:38 +0300
Message-ID: <20090803113638.f82699b2.jhnikula__2129.65152827582$1249288545$gmane$org@gmail.com>
References: <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
	<20090730215721.a899e2f4.jhnikula@gmail.com>
	<20090731075823.GB27083@esdhcp037198.research.nokia.com>
	<20090731202611.c689c31c.jhnikula@gmail.com>
	<20090803081107.GA1333@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090803081107.GA1333@esdhcp037198.research.nokia.com>
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
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 3 Aug 2009 11:11:07 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> > True, but I was wondering can this same problem occur also on McBSP2 if
> > using proper size threshold? Like size near the McBSP2 audio buffer
> > (1024x32) or near the TX buffer (256x32).
> 
> Yes, it can happen with mcbsp2 also if you use all places (1024+256).
> 
So should the patch then take into account McBSP2 also?

-- 
Jarkko
