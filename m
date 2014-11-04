From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC] AXD Audio Processing IP ALSA support -
 Questions
Date: Tue, 4 Nov 2014 16:10:50 +0530
Message-ID: <20141104104050.GI1870@intel.com>
References: <5458A0E2.4010602@imgtec.com>
 <5458A35C.9050405@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B27D42612AD
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 11:40:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5458A35C.9050405@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Qais Yousef <qais.yousef@imgtec.com>, Neil Jones <neil.jones@imgtec.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 04, 2014 at 10:58:52AM +0100, Clemens Ladisch wrote:
> Qais Yousef wrote:
> > 3- Can we get an example of how transcoding (back to disk) is supposed to be working?
> 
> ALSA PCM devices are assumed to run with their own clock, i.e., it is
> not directly possible for applications to control when a playback device
> reads data from the ring buffer, of when a capture device writes data to
> it.  The ALSA API is designed for real-time opertation; it would not be
> a good choice for batch conversions.
ALSA Compressed devices can be used here

-- 
~Vinod
