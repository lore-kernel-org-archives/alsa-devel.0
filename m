From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Fri, 10 Jul 2015 09:33:24 +0530
Message-ID: <20150710040324.GX836@localhost>
References: <20150703143608.7afb34c985d82982e929484e@ao2.it>
 <20150703130658.GA1689228@phare.normalesup.org>
 <559A90CE.2030105@gmail.com> <20150707031950.GD11002@localhost>
 <559BDB7F.9010105@gmail.com> <20150707170821.GL11002@localhost>
 <559C3F4A.5030307@gmail.com> <20150708033604.GM11002@localhost>
 <20150708102308.91b7258f243e354b1365a47e@ao2.it>
 <559D3411.6060306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 505262664B5
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 06:01:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <559D3411.6060306@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tyler Yeomans <tyeo098@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Antonio Ospite <ao2@ao2.it>, Nicolas George <george@nsup.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 08, 2015 at 10:30:41AM -0400, Tyler Yeomans wrote:
> Vinod,
> 
> I have attached the dmesg that occurs after I play the sound test.
> (dynamic debug and FE-BE was set via SSH terminal)

Thanks

[63718.847709] sst-mfld-platform sst-mfld-platform: enable=1, usage=0
[63718.847808] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff
55 00 00 00  ............U...
[63719.798810] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0,
msg_id:0x1 fw_state 0x3

This tells me initial command failed. Now there will be messages before this
(when FW code is downloaded) can you send that as well

-- 
~Vinod
