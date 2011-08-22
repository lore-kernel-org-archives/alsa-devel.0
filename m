From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: about UCM on bluetooth headset
Date: Mon, 22 Aug 2011 21:29:08 +0800
Message-ID: <20110822132908.GB9638@guanqun-laptop.ccr.corp.intel.com>
References: <20110822061911.GA7993@guanqun-laptop.sh.intel.com>
	<4E52336A.6060007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CB6724552
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 15:29:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E52336A.6060007@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 22, 2011 at 06:46:02PM +0800, Liam Girdwood wrote:
> On 22/08/11 07:19, Lu Guanqun wrote:
> > Hi Liam,
> > 
> > In alsa-libs:include/use-case.h, there are below lines:
> > 
> > 	* a conversation etc. The device describes the physical audio capture and playback
> > 	* hardware i.e. headphones, phone handset, bluetooth headset, etc.
> > 
> > I'm not quite clear about how to set a use case for bluetooth headset.
> > According to my understanding, bluetooth doesn't fall into the category
> > of ALSA, therefore there's no such direct devices for it.
> > 
> > Could you shed some lights on this? What's the best practises to use UCM
> > with bluetooth?
> > 
> 
> This is intended for systems where the BT audio is integrated in some
> way with the other audio ICs. It's intended to configure the other
> audio devices to allow use cases involving BT in such systems.

Hi Liam,

Thanks, I got your point. For example, where BT HSP is implemented over
ALSA PCM, it's most probably exposed as an ALSA device, then we can
configure it.

-- 
guanqun
