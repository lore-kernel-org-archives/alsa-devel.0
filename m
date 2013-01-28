From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: soc-compress: Add support for not
 memory mapped DSPs
Date: Mon, 28 Jan 2013 01:34:49 -0800
Message-ID: <20130128093449.GO26562@intel.com>
References: <1359104400-18527-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130128040416.GJ26562@intel.com>
 <20130128045609.GA5683@opensource.wolfsonmicro.com>
 <20130128060914.GM26562@intel.com>
 <20130128064440.GB5683@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id EC0782650F2
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 10:59:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130128064440.GB5683@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, vinod.koul@linux.jf.intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 28, 2013 at 02:44:42PM +0800, Mark Brown wrote:
> > > We'd need to take a copy of it in case we have a system with a mix of
> > > both styles.
Yes that would be the right thing to do..

> > For the same device?
> 
> No, not for the same device - just in the system.  compr->ops has been
> set to point to soc_compr_ops which is a static shared by all drivers in
> the system (unless I've misread what you wrote above).
No you read it right. We need to change a little and yes take a copy of it.
That way you can modify the copy locally for your device rather that updating
the system while avoiding two defines :)

--
~Vinod
