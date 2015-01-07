From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 1/3] ASoC: rt5670: fix bit definition for
	ASRC control
Date: Wed, 7 Jan 2015 02:16:33 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B76385D@SHSMSX101.ccr.corp.intel.com>
References: <1481c597e90b5daacce80a021fa0c513a7a2ec6d.1420451186.git.mengdong.lin@intel.com>
 <20150105181714.GA2634@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70103ABE3@RTITMBSV03.realtek.com.tw>
 <20150106110325.GU2634@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EAB9261558
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 03:16:56 +0100 (CET)
In-Reply-To: <20150106110325.GU2634@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, January 06, 2015 7:03 PM

> On Tue, Jan 06, 2015 at 02:08:45AM +0000, Bard Liao wrote:
> 
> > > > This patch fixes bit definitions for two ASRC control registers
> > > > 0x84 and
> > > 0x85.
> 
> > > This appears to do something more or different to fixing definitions
> > > - if it was fixing I'd expect to see equal numbers of lines added
> > > and removed in blocks identical apart from some numbers but this
> > > appears to be adding some new definitions like these...
> 
> > Maybe we should call redefine rather than fix. The previous definition
> > of registers 0x84 and 0x85 doesn't match the register's description.
> > To make the code more readable, we would like to rewrite the
> > definition of registers
> > 0x84 and 0x85.
> 
> Yes, if it's just redefining the definitions that are currently unused then it
> should be described as such - a fix is something that should get sent to Linus
> and possibly also to stable.

I've changed this patch subject to "redefine" and submitted the v2 patches. 
Please have a review.

Thanks
Mengdong
