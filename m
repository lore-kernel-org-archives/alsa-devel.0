From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: change set_tdm_slot api to allow
 slot_width override.
Date: Thu, 06 Aug 2009 22:36:22 +0800
Message-ID: <4A7AEA66.5010408@gmail.com>
References: <1245113071.24109.559.camel@brutus>
	<20090804205545.GB29518@sirena.org.uk>
Reply-To: eric.y.miao@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EFD824537
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Aug 2009 16:36:27 +0200 (CEST)
Received: by ewy23 with SMTP id 23so998118ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 06 Aug 2009 07:36:26 -0700 (PDT)
In-Reply-To: <20090804205545.GB29518@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Jun 15, 2009 at 09:44:31PM -0300, Daniel Ribeiro wrote:
>> Extend set_tdm_slot to allow the user to arbitrarily set the frame width
>> and active TX/RX slots.
> 
>> Updates magician.c and wm9081.c for the new set_tdm_slot(). wm9081.c
>> still doesn't handle the slot_width override.
> 
>> While being there, correct an incorrect use of SlotsPerFrm(7) use in
>> bitmask on pxa-ssp.c (SSCR0_SlotsPerFrm(x) is (((x) - 1) << 24)) ).
> 
>> (this series is meant for Mark's for-2.6.32 branch)
> 
>> Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>
> 
> So.  These have been sitting for quite some time now.  Unfortunately I
> went on holiday immediately after it was last submitted my Zylonite
> system has been bricked for pretty much all of the time since then so
> I've been remiss in following up.  Sorry about that, my bad.
> 
> My inclination here is to apply these changes - they look like a clear
> win for pretty much every machine except Daniel Mack's out of tree
> system which needs the 64 bit TDM slots.  It's a shame to break that but
> there seems to be such a clear advantage from the changes, especially
> the new set_tdm_slot() API, that it seems like a win overall.  I've got
> a feeling that the fix for that system may have to be allowing the
> machine driver to rewrite the hw_params for the CPU driver to lie about
> the data format.
> 
> I'll try to do that this week.
> 

I seem to remember this failed on Littleton - playback just doesn't work
any more, and DMA looks to be inactive. Didn't follow this thread for a
long time, but Daniel, could you repost the whole series if you have any
update
