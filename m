From: Rick Mann <rmann@latencyzero.com>
Subject: Audio routing in the tlv320aic3104
Date: Wed, 7 Oct 2015 04:12:05 -0700
Message-ID: <18B9FBAF-1EB4-413F-8639-9AC94B50F445@latencyzero.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id C1074260A5D
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 13:12:07 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 2B8A52033D
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 07:12:07 -0400 (EDT)
Received: from [192.168.15.51] (c-50-168-55-93.hsd1.ca.comcast.net
 [50.168.55.93])
 by mail.messagingengine.com (Postfix) with ESMTPA id B9203C0001D
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 07:12:06 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I've managed to get a hacky, fragile config working, in the sense that it sends my tlv320aic3104 samples from speaker-test, and the clocks and data all look good on the oscilloscope, and it ping-pongs between the left and right channel.

But it's outputting the signal on the HPLOUT/HPROUT pins, not the L&R Line Out pins.

My DTS has this:

    fragment@3 {
        target = <&ocp>;
        __overlay__ {
            sound {
                compatible = "ti,da830-evm-audio";
                ti,model = "DA830 EVM";
                ti,audio-codec = <&tlv320aic3x>;
                ti,mcasp-controller = <&mcasp0>;
                ti,codec-clock-rate = <12000000>;
                ti,audio-routing =
                    "Line Out",             "LLOUT",
                    "Line Out",             "RLOUT";
            };
        };
    };

The original had:

	"Headphone Jack",       "HPLOUT",
	"Headphone Jack",       "HPROUT",
	"LINE1L",               "Line In",
	"LINE1R",               "Line In";

I also have an asound.state file I got from the Audio Cape:

	https://raw.githubusercontent.com/CircuitCo/BeagleBone-Audio/files/asound.state

I don't really know how to interpret that file. One resource online said it held the current state of the system. I guess that suggests I should play with amixer. But how does the DTS routing come into play?

Thanks,




-- 
Rick Mann
rmann@latencyzero.com
