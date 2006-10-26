From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: [PATCH] hda: add sigmatel dig mic support
	and	refactor 9227
Date: Thu, 26 Oct 2006 08:03:34 -0700
Message-ID: <1161875014.18211.100.camel@razman>
References: <20061025202110.GA351@matthew-porters-computer.local>
	<s5hejsv7321.wl%tiwai@suse.de>
	<20061026143624.GB1507@matthew-porters-computer.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6F486225
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Oct 2006 17:03:36 +0200 (MEST)
In-Reply-To: <20061026143624.GB1507@matthew-porters-computer.local>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Matt Porter <mporter@embeddedalley.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> Ok, will do. I'm sending a separate patch which just adds 9205
> dmic support and we can address the 927x/9227 issue separately.
> 
I understand the need for cutting the 9227 from the 927x series codecs.
This can easily be done, just remember to keep the 965_5stack code with
the 927x, as that is the codec they have
(http://support.intel.com/products/motherboard/DG965WH/).  The 3-stack
boards all use the 9227 codec.

At the time I wrote the 5-stack code, I had received a pre-release
motherboard 1 week prior to product launch, and 3 days before my
contract ended.  Sigmatel didn't have any information on their web site
for the 9271, and the engineer that was supposed to provide me with
specs didin't have this one.  It was a real shot in the dark.

The code I wrote works with these boards, and I wouldn't worry about the
digital mic on them, as the Intel 5 stack boards aren't wired to use
them, except maybe through retasking of existing ports.  It isn't
documented in the motherboard technical product specification.

-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
