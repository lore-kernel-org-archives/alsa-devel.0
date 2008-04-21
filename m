From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Subject: Re: snd_hda_intel locking up on VIA CX700M2 with
 VT1708A codec
Date: Mon, 21 Apr 2008 10:05:40 +0100
Message-ID: <480C58E4.5030000@onelan.co.uk>
References: <4808AE84.3000803@onelan.co.uk> <4808DCC3.7030804@onelan.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay4.mail.uk.clara.net (relay4.mail.uk.clara.net
	[80.168.70.184]) by alsa0.perex.cz (Postfix) with ESMTP id 7590A2437B
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 11:05:51 +0200 (CEST)
Received: from host217-35-101-6.in-addr.btopenworld.com ([217.35.101.6]
	helo=f8simon.office.onelan.co.uk)
	by relay4.mail.uk.clara.net with esmtpa (Exim 4.62)
	(envelope-from <simon.farnsworth@onelan.co.uk>) id 1Jnry8-0002TE-UH
	for alsa-devel@alsa-project.org; Mon, 21 Apr 2008 10:05:50 +0100
In-Reply-To: <4808DCC3.7030804@onelan.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Simon Farnsworth wrote:
> Simon Farnsworth wrote:
>> Hello,
>>
>> I'm trying to work out what's going wrong with the HDA controller in our 
>> VIA CX700M2 board; there's a full bug report at 
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3910, but 
>> briefly, I'm seeing it lock up and refuse to DMA after long enough 
>> transferring audio data.
>>
> Following up on myself; the last command sent to the codec is always 
> 0x014f000a in my testing. Is it likely that the digital output (node 
> 0x14) is causing problems (it's not wired to anything)?

I've manually crippled the code that enables the digital output 
(commented out the following lines in patch_via.c at line 846 ish):

	if (spec->autocfg.dig_out_pin)
		spec->multiout.dig_out_nid = VT1708_DIGOUT_NID;
	if (spec->autocfg.dig_in_pin)
		spec->dig_in_nid = VT1708_DIGIN_NID;

This hasn't helped, beyond removing the last_cmd message from dmesg. 
Back to the drawing board for me.
-- 
Simon Farnsworth
