From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-compress: Add support for
	not	memory mapped DSPs
Date: Mon, 28 Jan 2013 10:49:10 +0000
Message-ID: <20130128104910.GB14418@opensource.wolfsonmicro.com>
References: <1359104400-18527-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130128040416.GJ26562@intel.com>
 <20130128045609.GA5683@opensource.wolfsonmicro.com>
 <20130128060914.GM26562@intel.com>
 <20130128064440.GB5683@opensource.wolfsonmicro.com>
 <20130128093449.GO26562@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ECC27265207
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 11:49:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130128093449.GO26562@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, tiwai@suse.de, Mark Brown <broonie@opensource.wolfsonmicro.com>, liam.r.girdwood@intel.com, vinod.koul@linux.jf.intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 28, 2013 at 01:34:49AM -0800, Vinod Koul wrote:
> On Mon, Jan 28, 2013 at 02:44:42PM +0800, Mark Brown wrote:
> No you read it right. We need to change a little and yes take a copy of it.
> That way you can modify the copy locally for your device rather that updating
> the system while avoiding two defines :)

I can update the patch to create a new copy for each device
however, I am not sure I prefer this approach. It seems highly
likely that presence or not of copy will be the only difference
been devices that is ever present. So making dynamic copies per
device for what will only ever be two distinct items feels
excessive compared to the cost of carrying one extra static
struct.

Charles
