From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add asynchronous mode support
Date: Tue, 5 Aug 2014 19:07:36 +0800
Message-ID: <20140805110735.GA16503@MrMyself>
References: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
 <53E0B926.9010103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53E0B926.9010103@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, b42378@freescale.com, b02247@freescale.com
List-Id: alsa-devel@alsa-project.org

Hi Varka,

On Tue, Aug 05, 2014 at 04:29:50PM +0530, Varka Bhadram wrote:
> >diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> >index 0f4e238..77864f4 100644
> >--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> >+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> >@@ -24,6 +24,22 @@ Required properties:
> >  - big-endian-data: If this property is absent, the little endian mode will
> >    be in use as default, or the big endian mode will be in use for all the
> >    fifo data.
> >+- fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
> >+  that SAI will work in the synchronous mode (sync Tx with Rx) which means
> >+  both the transimitter and receiver will send and receive data by following
> >+  receiver's bit clocks and frame sync clocks.
> >+- fsl,sai-asynchronous: This is a boolean property. If present, indicating
> >+  that SAI will work in the asynchronous mode, which means both transimitter
> >+  and receiver will send and receive data by following their own bit clocks
> >+  and frame sync clocks separately.
> >
> Would be readable if it like this...
> 
> fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
> 			that SAI will work in the synchronous mode (sync Tx with Rx) which means
> 			both the transimitter and receiver will send and receive data by following
> 			receiver's bit clocks and frame sync clocks.
> - fsl,sai-asynchronous: This is a boolean property. If present, indicating
> 			that SAI will work in the asynchronous mode, which means both transimitter
> 			and receiver will send and receive data by following their own bit clocks
> 			and frame sync clocks separately.

I agree, however, the doc was initialized in that format. Adding
indentations for these two appended lines makes the whole text
look weird. :(

Thank you,
Nicolin
