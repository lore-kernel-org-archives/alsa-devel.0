From: "Couch, Kelly J" <kelly.j.couch@intel.com>
Subject: How to Tx/Rx data via TDM/I2S interface of Intel HD
 Audio controller without a CODEC attached?
Date: Thu, 29 Mar 2012 20:12:52 +0000
Message-ID: <934D8D6A4B048048942509C4D57C8A400A845BA6@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C5BC104548
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 22:12:59 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm designing software for a specific test application that will utilize an Intel HD audio controller.  I must verify the functionality of several sets of TDM audio signals (CK, FS, TXD, RXD) from the Intel HD Audio controller.  In this scenario, the Intel HD Audio controller is NOT connected directly to a CODEC, but to a header.   My proposal is to connect these signals directly to an FPGA, using it to loopback the data (in various permutations of loopback to channels) to verify each of the signals.  Because the FPGA will be in place of a real CODEC device, I'm concerned with how the software side of this approach will work? I essentially just want to push a known bitstream through one TDM interface and verify it upon reception via an alternate TDM interface.  This doesn't necessarily req
 uire actual audio data.  Lastly, I should point out that the system will be tested with it booted to Linux (using a recent kernel 3.x) so utilizing the standard linux audio interfaces (like 
 ALSA - though this isn't a requirement) is preferable to expedite development.

I have spent several hours reading over documentation at the official site and elsewhere, but am left unsure of how to accomplish my goal.  I am hopeful it is simply a matter of ALSA configuration, but am not sure if that will suffice, nor how to accomplish it.

The test method (hardware configuration) is unlikely to change, so I'm soliciting any suggestions and information that you all have to enable sending and receiving a specific data stream over the TDM interfaces of the Intel HD Audio controller.

Thanks,
-Kelly
