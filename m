From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: multi channels input and single channel out
Date: Fri, 6 May 2011 08:23:23 +0800
Message-ID: <20110506002323.GA2581@qtel.sh.intel.com>
References: <190162.6375.qm@web161716.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 4580F2433F
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 02:24:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <190162.6375.qm@web161716.mail.bf1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: hong zhang <henryzhang62@yahoo.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 06, 2011 at 07:47:55AM +0800, hong zhang wrote:
> List,
> 
> I have 8 channels of hdmi input and one channel output on my board.
> When arecord -f dat hdmi-rx.wav to store 8 channels data, aplay -f dat hdmi-rx.wav releases noise.
> 
> Ia there any way arecord stores each channel data to 8 different files?

check out the "--separate-channels" option for arecord.
see if it meets your needs.

> Or I have to do beam forming to sort 8 channels out by custom application?
> 
> Thanks.
> 
> ---henry
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
guanqun
