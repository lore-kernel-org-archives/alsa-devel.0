From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 3/4] ALSA: usb-audio: parse UAC2 sample
 rate ranges correctly
Date: Mon, 14 Jun 2010 14:41:31 +0200
Message-ID: <20100614124131.GO17833@buzzloop.caiaq.de>
References: <1276263191-8652-1-git-send-email-daniel@caiaq.de>
	<1276263191-8652-4-git-send-email-daniel@caiaq.de>
	<AANLkTin3LMCu_f2emsh6kAT8H6G3zKF8Ud-ZUMpZjbmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A2A41103835
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 14:41:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTin3LMCu_f2emsh6kAT8H6G3zKF8Ud-ZUMpZjbmg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alex Lee <alexlee188@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 11, 2010 at 10:59:44PM +0800, Alex Lee wrote:
> If the device has a variable clock, it may report a RES of only 1.  So you
> may end up with thousands (and even millions) of sample rates.  It might be
> better to have separate code to cater to discrete clocks vs variable clocks.

Just for the records: this is exactly what Mac OS X does, and it will
comsume 100% CPU when a device with such descriptors is plugged in. So
even though this is now sanely handled by ALSA, it really shouldn't be
done that way by implementors.

Daniel
