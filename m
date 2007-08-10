From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Why there is no SNDRV_PCM_RATE_24000 in pcm.h
Date: Fri, 10 Aug 2007 09:39:57 +0200
Message-ID: <1186731597.24600.1204693985@webmail.messagingengine.com>
References: <579fa30a0708092335w4c2383e5se192b96e112dce81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 61DDA10383B
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 09:39:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <579fa30a0708092335w4c2383e5se192b96e112dce81@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wei Kai <kai.wei.cn@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Wei Kai wrote:
> I checked the include/sound/pcm.h in kernel and find this problem, it
> seemed strange, so many codecs support the 24000 sample rate, why
> there is no such definition.

When the header file was created many years ago, 24000 Hz wasn't a
common sample rate.

To support a sample rate that is not in that list of predefined rates,
your driver should set the RATE_KNOT bit and call the
snd_pcm_hw_constraint_list() function; see the section "Constraints" in
the "Writing an ALSA Driver" document.


HTH
Clemens
