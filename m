From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: cplay error "Can't find sync world"
Date: Tue, 4 Jun 2013 05:29:34 +0530
Message-ID: <20130603235934.GA23045@intel.com>
References: <51AC55B4.5080105@linux.intel.com>
 <20130603162004.GC31108@opensource.wolfsonmicro.com>
 <51AD30FD.9080406@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EC322650B9
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 02:37:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51AD30FD.9080406@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Keyon.Jey" <yang.jie@linux.jf.intel.com>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 04, 2013 at 08:12:45AM +0800, Keyon.Jey wrote:

Pls *DONT* drop ppl from CC,
Pls CC maintainers

> >>when I try use clpay -c 1 -d 2 test.mp3 to use tinycompress hwdec on my
> >>phone, "Can't find sync world" always occurred, no matter what mp3 music
> >>I try to play.
> >I believe the issue here is cplay does not currently handle MP3s
> >with meta data, such as track naming etc. You will need to strip
> >anything like this from the start of the MP3 file before playing.
> it helps! thanks a lot, Charles!
The current code, doesn't parse the header looking for the SYNC bits, it checks
at a predefined offset. Which means that most of the files will work but as
Charles said, if the the file has meta data, it wont work.

And yes patch is welcome...

--
~Vinod
