From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 4/4] ASoC: acpi: remove hard-coded
 i2c-device name length
Date: Tue, 09 Jan 2018 12:39:50 +0200
Message-ID: <1515494390.7000.816.camel@linux.intel.com>
References: <20180105205536.10366-1-pierre-louis.bossart@linux.intel.com>
 <20180105205536.10366-5-pierre-louis.bossart@linux.intel.com>
 <20180108044133.GW18649@localhost>
 <12631c8f-699c-cb2f-643f-5f4c7ab982c0@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 381F126717C
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 11:40:00 +0100 (CET)
In-Reply-To: <12631c8f-699c-cb2f-643f-5f4c7ab982c0@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
Cc: jeremy@jcline.org, tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2018-01-08 at 14:28 -0600, Pierre-Louis Bossart wrote:
> On 1/7/18 10:41 PM, Vinod Koul wrote:
> > On Fri, Jan 05, 2018 at 02:55:36PM -0600, Pierre-Louis Bossart
> > wrote:
> > > Remove hard-coded [16] array size, replace with clearer
> > > description and
> > > dependency on ACPI_ID_LEN
> > > 


> > >   
> > > +/* codec name is used in DAIs is i2c-<HID>:00 with HID being 8
> > > chars */
> > > +#define SND_SOC_ACPI_I2C_DEVICE_NAME_LEN (4 + ACPI_ID_LEN + 3 +
> > > 1)
> > 
> > nitpicking, thats a very long name :(
> > 
> > how about SND_ACPI_I2C_ID_LEN, we can drop SOC. And replace
> > DEVICE_NAME with ID
> 
> Fine with me. Andy do you concur or have a more precise suggestion?

Looks sane to me.
Thank you, Vinod, for a suggestion.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
