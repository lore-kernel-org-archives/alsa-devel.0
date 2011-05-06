From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [uclinux-dist-devel] [PATCH 1/4] Blackfin: Use
 8bit spi transfers for the ad1836
Date: Fri, 06 May 2011 15:31:26 +0200
Message-ID: <4DC3F82E.3060605@metafoo.de>
References: <1304617966-4410-1-git-send-email-lars@metafoo.de>	<BANLkTi=u+_LBkv2=DAwhZ53FEoRaYcHErA@mail.gmail.com>	<4DC3E970.2030207@metafoo.de>	<20110506124858.GA11701@sirena.org.uk>	<4DC3F577.2040206@metafoo.de>
	<20110506132608.GO23729@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-004.synserver.de (smtp-out-004.synserver.de
	[212.40.185.4]) by alsa0.perex.cz (Postfix) with ESMTP id A0D93243F0
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 15:31:44 +0200 (CEST)
In-Reply-To: <20110506132608.GO23729@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 05/06/2011 03:26 PM, Mark Brown wrote:
> On Fri, May 06, 2011 at 03:19:51PM +0200, Lars-Peter Clausen wrote:
>> On 05/06/2011 02:48 PM, Mark Brown wrote:
> 
>>> So clearly the cache stuff ought to be using cpu_to_be16 for this stuff.
>>> At present we've been lazy about this as on most CPUs the swap boils
>>> down to a noop.  If we do end up needing both swaps then we just add
>>> this as another parameter in the cache infrastructure.
> 
>> Currently everything is stored as big endian.
> 
> What do you mean?  The cache is CPU native.
> 

Sorry, I meant the buffer which is transmitted not the cache it-self.


- Lars
