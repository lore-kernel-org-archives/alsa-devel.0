From: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: CodingStyle (was: Re: sound/pci/hda/intel_hda:
	small cleanups)
Date: Wed, 6 Sep 2006 09:23:19 +0200
Message-ID: <200609060923.22459.ioe-lkml@rameria.de>
References: <20060831123706.GC3923@elf.ucw.cz>
	<20060905080813.GE1958@elf.ucw.cz>
	<20060905084352.1ced999e.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de
	[80.67.18.13])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 34A4D259
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Sep 2006 09:23:29 +0200 (MEST)
In-Reply-To: <20060905084352.1ced999e.rdunlap@xenotime.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pshou@realtek.com.tw, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Hi,

On Tuesday, 5. September 2006 17:43, Randy.Dunlap wrote:
> Is there an acceptable way to leave source code in a file but
> render it unused?  Like #if 0/#endif or #if BOGUS_SYMBOL/#endif ?

They are to reading like gaps in a road.

If you really need to keep unused code for reference
just do it in your LOCAL repository.

There are exceptions where you remove the last user of code 
in one patch and a different developer just needs this code
for his new stuff in another patch.

In this case an #if 0/#endif is quite common to reduce merging
conflicts.

Regards

Ingo Oeser

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
