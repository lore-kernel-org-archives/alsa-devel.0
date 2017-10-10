From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [Patch v6 1/7] slimbus: Device management on
	SLIMbus
Date: Tue, 10 Oct 2017 13:56:18 +0100
Message-ID: <20171010125618.tb2hq5ec24xjfzpx@localhost.localdomain>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
 <20171010100534.zyv3b5m6fmgmceim@localhost.localdomain>
 <6dc24d42-7c40-9ffe-6be5-bf38d712222b@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 2704F266B38
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 14:56:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6dc24d42-7c40-9ffe-6be5-bf38d712222b@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, gong.chen@linux.intel.com, arnd@arndb.de, kheitke@audience.com, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, broonie@kernel.org, daniel@ffwll.ch, gregkh@linuxfoundation.org, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 10, 2017 at 01:34:48PM +0100, Srinivas Kandagatla wrote:
> Thanks for the review comments.
> 
> On 10/10/17 11:05, Charles Keepax wrote:
> > On Fri, Oct 06, 2017 at 05:51:30PM +0200, srinivas.kandagatla@linaro.org wrote:
> > > +Required property for SLIMbus child node if it is present:
> > > +- reg		- Is Duplex (Device index, Instance ID) from Enumeration
> > > +		  Address.
> > > +		  Device Index Uniquely identifies multiple Devices within
> > > +		  a single Component.
> > > +		  Instance ID Is for the cases where multiple Devices of the
> > > +		  same type or Class are attached to the bus.
> > > +
> > > +- compatible	-"slimMID,PID". The textual representation of Manufacturer ID,
> > > +	 	  Product Code, shall be in lower case hexadecimal with leading
> > > +		  zeroes suppressed
> > 
> > This does sort of make sense but kinda makes the code a bit ugly
> > parsing the MID and PID. Some parts will support SLIMBus and also
> > other control interfaces, which means they would need to add an
> > additional compatible string just for SLIMBus. It also breaks
> > the normal conventions of vendor,part and finally it makes the
> > compatible strings really unreadable which will be a bit annoying
> > when looking at DTs.
> > 
> This change was made inline to the comments provided in previous version of
> the patch https://lkml.org/lkml/2016/5/3/576
> 
> > I think the MID and PID should just be included in the reg field
> > and just leave this as a standard compatible.
> 
> AFAIK, reg field should only contain index and instance, which was also
> discussed  at https://lkml.org/lkml/2016/5/3/747
> 

Thanks for the links, if people are determined this is the way
to go I can live with it. I guess my primary objection is the
fact my parts are going to have different compatibles depending
on if they are on I2C/SPI or on SLIMBus (we have many parts that
support all three on the same chip) which feels like it violates
the principle of least surprise. Will wait to see if Arnd or Rob
have anymore thoughts to offer.

> > > +/* Helper to get hex Manufacturer ID and Product id from compatible */
> > > +static unsigned long str2hex(unsigned char *str)
> > > +{
> > > +	int value = 0;
> > > +
> > > +	while (*str) {
> > > +		char c = *str++;
> > > +
> > > +		value = value << 4;
> > > +		if (c >= '0' && c <= '9')
> > > +			value |= (c - '0');
> > > +		if (c >= 'a' && c <= 'f')
> > > +			value |= (c - 'a' + 10);
> > > +
> > > +	}
> > > +
> > > +	return value;
> > > +}
> > 
> > Isn't this just reimplementing kstrtoul?
> > 
> I would say partly, I think kstrtoul will only parse string as hex if its
> prefixed with "0x" But the compatible does not have 0x prefix..
> we could probably do some prefixing before passing to kstrtoul to remove
> above function.. I will try that and see!
> 

I am pretty sure kstrtoul is happy without the 0x as long as you
specify the base as 16 which I guess you should be doing here.

Thanks,
Charles
