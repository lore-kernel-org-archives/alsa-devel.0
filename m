From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [RFC][PATCH] ELD routines and proc interface
Date: Wed, 19 Nov 2008 15:17:57 +0800
Message-ID: <20081119071757.GA32376@localhost>
References: <1226542918.126598.6912@de> <20081119071135.GA17733@csy.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 81CB7245BE
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 08:18:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081119071135.GA17733@csy.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shane W <shane-alsa@csy.ca>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 18, 2008 at 11:11:35PM -0800, Shane W wrote:
> On Thu, Nov 13, 2008 at 10:21:53AM +0800, Wu Fengguang wrote:
> > Create hda_eld.c for ELD routines and proc interface.
> 
> Hi,

Hi Shane,

> Just testing this and your multichannel HDMI code over here
> but it doesn't seem to get ELD data for my setup.  Intel
> g45-id board with an Yamaha RX-v1800 receiver which is HDMI
> 1.3 capable.

Do you run the latest xorg intel driver?  Also dmesg should tell us
something if anything goes wrong with ELD retrieving/parsing.

> shane@chintoka:~$ cat /proc/asound/Intel/eld#3
> monitor name
> connection_type         HDMI
> eld_version             [0x0] reserved
> edid_version            [0x0] no CEA EDID Timing Extension
> block present
> manufacture_id          0x0
> product_id              0x0
> port_id                 0x0
> support_hdcp            0
> support_ai              0
> audio_sync_delay        0
> speakers                [0x0]
> sad_count               0
> 
> 2ch audio is coming through just fine over HDMI though so
> the connection itself is there.

Yes. Obviously the ELD stuct has not been populated yet.

Thanks,
Fengguang
