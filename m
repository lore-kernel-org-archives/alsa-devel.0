From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH 0/3] EP93xx: Add i2s audio support
Date: Thu, 10 Jun 2010 09:40:02 +1200
Message-ID: <4C100A32.7010403@bluewatersys.com>
References: <1275991272-30122-1-git-send-email-ryan@bluewatersys.com>
	<20100609101742.GA5618@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CD5510384C
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jun 2010 23:40:05 +0200 (CEST)
In-Reply-To: <20100609101742.GA5618@opensource.wolfsonmicro.com>
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
Cc: john.cooper@third-harmonic.com, chasedouglas@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, r&d4@dave-tech.it, hartleys@visionengravers.com, dhuggins@cs.cmu.edu, marshall@coolbananas.co.nz, buytenh@wantstofly.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, Jun 08, 2010 at 10:01:09PM +1200, Ryan Mallon wrote:
>> Repost of the i2s audio series for ep93xx. Patch 2/3 is unchanged. The
>> core support has been modified to move setting of the SPOL and ORIDE
>> bits of the i2sclkdiv register, as well as the i2s pin strapping
>> configuration, to a new function called ep93xx_i2s_acquire which is
>> called from the audio board drivers.
> 
> I've now applied both patches.  There was a trivial fixup required for
> the clocks due to an add/add overlap with the SPI clock - I think it's
> OK but please check.

Stupid question, but where was it applied? I can't find it in any of the
branches at:
http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git;a=summary

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
