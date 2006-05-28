From: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.17rc emu10k1 regression.
Date: Sun, 28 May 2006 12:53:38 -0400
Message-ID: <20060528165338.GA4692__25726.3231710114$1148835270$gmane$org@redhat.com>
References: <20060528164015.GA13499@redhat.com>
	<4479D500.2060305@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5E6BB183
	for <alsa-devel@alsa-project.org>;
	Sun, 28 May 2006 18:53:45 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <4479D500.2060305@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, May 28, 2006 at 05:51:12PM +0100, James Courtier-Dutton wrote:

 > > cannot find the slot for index 0 (range 0-1)
 > > EMU10K1_Audigy: probe of 0000:06:0d.0 failed with error -12
 > > 
 > > (Unremarkable, considering it *isn't* an Audigy)
 > The same driver is used for the EMU10K1 and the Prodigy.
 > the -12 is an "Out of memory", so something outside the alas driver tree
 > must have changed to cause this problem.

I rebooted into exactly the same kernel, and everything magically
started working again. Puzzling.  There were no other signs of memory
exhaustion.

Hmm. Will keep an eye on things to see if it happens again.

		Dave

-- 
http://www.codemonkey.org.uk
