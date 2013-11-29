From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/4] ASoC: Add support for the Analog
 Devices AXI-I2S core
Date: Fri, 29 Nov 2013 15:34:13 +0100
Message-ID: <5298A5E5.4090704@metafoo.de>
References: <1385665372-29477-1-git-send-email-lars@metafoo.de>
 <1385665372-29477-2-git-send-email-lars@metafoo.de>
 <20131129115830.GT27568@sirena.org.uk> <529890F0.7090100@metafoo.de>
 <20131129142750.GB27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-136.synserver.de (smtp-out-236.synserver.de
 [212.40.185.236])
 by alsa0.perex.cz (Postfix) with ESMTP id E9AAB261700
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 16:16:41 +0100 (CET)
In-Reply-To: <20131129142750.GB27568@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 11/29/2013 03:27 PM, Mark Brown wrote:
> On Fri, Nov 29, 2013 at 02:04:48PM +0100, Lars-Peter Clausen wrote:
> 
>> We only use it on ZYNQ and Microblaze though. And people have complained in
>> the past about symbols that are viable on their platform, but are not
>> relevant for their platform. And to use the core on a different FPGA
>> platform will most likely require changes to the core, unless the other FPGA
>> also has a PL330 DMA interface. So I'd prefer to only make it avaiable on
>> ZYNQ and Microblaze right now.
> 
> Is it really restricted to PL330 at the hardware level?  I don't recall
> anything too fancy in the datasheet there.

Yes, it is using the PL330 peripheral request interface.  See
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0424a/index.html
and
https://github.com/analogdevicesinc/fpgahdl_xilinx/blob/master/cf_lib/edk/pcores/adi_common_v1_00_a/hdl/vhdl/pl330_dma_fifo.vhd

- Lars
