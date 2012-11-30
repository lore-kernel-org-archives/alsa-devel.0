From: Daniel Mack <zonque@gmail.com>
Subject: Re: Support request for codec WM8731 porting
Date: Fri, 30 Nov 2012 18:17:28 +0100
Message-ID: <50B8EA28.5060208@gmail.com>
References: <50B8E1AB.6000006@elno.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F3452602DC
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 18:17:35 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so329992bkc.38
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 09:17:34 -0800 (PST)
In-Reply-To: <50B8E1AB.6000006@elno.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cyril GERMAINE <c.germaine@elno.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 30.11.2012 17:41, Cyril GERMAINE wrote:
> Hello,
> 
> I work on a board based from DM365EVM baseboard, but with the WM8731 
> codec instead of the TLV320AIC3x.
> I tried with several linux kernels (one is the 3.6.6 release). Now the 
> playback works but not the capture, and I'm not able to debug this 
> issue. I have many "0" frames in the captured data, although data and 
> rate on I2S bus is OK.

Do you see the audio gaps in I2S as well? This is the first thing to
investigate on, because if they aren't, your problem is unrelated to the
Codec.

What are the differences between your board and the DM365EVM regarding
the SoC and the clocks ratios? Does the DM365EVM work with 3.6.6? How do
your board support files and ASoC machine driver differ?

Too many open questions here that need to be addressed.


Daniel
