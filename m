From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Closing the pcm streams
Date: Fri, 19 Feb 2016 09:58:09 +0530
Message-ID: <20160219042809.GL19598@localhost>
References: <CAAVaN8wroWe7xQCAnSsx_G0ruuRLiDivL2oXuFZ7U9YGGTsRow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 955762614AC
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 05:24:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAAVaN8wroWe7xQCAnSsx_G0ruuRLiDivL2oXuFZ7U9YGGTsRow@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Ng <andreas2025@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 18, 2016 at 06:46:04PM +0000, Andy Ng wrote:
> Hello,
> 
> I am working on a system that a DSP provides the audio algorithms and
> in case where the DSP crashes, I would like to shutdown nicely any
> opened PCM streams.
> The DSP has an RPC protocol to the external world. I use a small
> watchdog on ARM to monitor the "health" of the DSP. When the DSP goes
> down, I reset it. However, I would like to close down smoothly the PCM
> streams and inform the user that there was an error while playing.  Is
> there any way to inform the ALSA kernel framework in the kernel that a
> specific PCM stream gone bad? Where is the best point to reset ALSA
> kernel framework?

In your driver...

You can call snd_pcm_stop() on all the streams and then return an error on
commands, usermode may close and restart again

-- 
~Vinod
