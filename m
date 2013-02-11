From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH TINYCOMPRESS 1/14] compress: Add function
 to get timestamp in samples
Date: Sun, 10 Feb 2013 22:34:48 -0800
Message-ID: <20130211063448.GA3789@intel.com>
References: <20130210000227.GA31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 84F51260314
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 07:59:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130210000227.GA31139@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 10, 2013 at 12:02:27AM +0000, Richard Fitzgerald wrote:
> The compress_get_hpointer() converts the timestamp into actual
> time. But Android needs it in samples. To avoid the inefficiency
> of using compress_get_hpointer() and converting into time and then
> back into samples, this change adds compress_get_tstamp() which
> returns the raw struct snd_compr_tstamp.
I am fine with adding new API for returning the samples, but then why return the
raw struct. Would make sense to just get samples if that is only thing desired.

Let users use whatever field that want, samples or time.

--
~Vinod
