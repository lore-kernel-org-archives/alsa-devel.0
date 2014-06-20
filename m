From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 00/19]: add mrfld DSP support
Date: Fri, 20 Jun 2014 10:57:25 +0200
Message-ID: <53A3F775.80303@metafoo.de>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <53A3EB23.4050302@metafoo.de> <20140620082041.GG22053@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-242.synserver.de (smtp-out-242.synserver.de
 [212.40.185.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A4F9D261A49
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 10:57:24 +0200 (CEST)
In-Reply-To: <20140620082041.GG22053@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 06/20/2014 10:20 AM, Vinod Koul wrote:
[...]
>> * Use regmap for IO instead of the read/write callbacks in the
>> platform_driver struct.
> I dont think we need that for our DSP. The read/write are writing to driver
> memory which is later used to send data to DSP using IPCs. So how will regmap
> help here?

The idea is to get rid of the IO abstraction layer inside ASoC and only rely 
on regmap for this. This is a process this has been going on ever since the 
regmap framework was added to the kernel and we are almost there now. The 
best is to implement a regmap bus or a bus-less regmap instance that 
implements the IPC for the DSP. If the IPC does not map nicely onto a 
register map, we need to come up with something better. It's basically the 
same problem that that HDA CODEC by RT has.

- Lars
