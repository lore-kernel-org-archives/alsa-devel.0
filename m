From: Bo Shen <voice.shen@atmel.com>
Subject: Re: WM8904 SAMA5D channel swap
Date: Tue, 22 Jul 2014 10:34:12 +0800
Message-ID: <53CDCDA4.8090308@atmel.com>
References: <53C921BD.809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SJOEDG01.corp.atmel.com (nasmtp02.atmel.com [204.2.163.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 815D22654AF
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 04:36:06 +0200 (CEST)
In-Reply-To: <53C921BD.809@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matteo Fortini <matteo.fortini@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Matteo,

On 07/18/2014 09:31 PM, Matteo Fortini wrote:
> I'm seeing left/right channel swapping problems on a board with a WM8904
> codec and a SAMA5D35 CPU.
>
> configuration is CBM and CFM and original data format is I2S. Our board
> has the same connections and parts as the EK from Atmel.
>
> I tried to apply commit bc567a93502275755492141524935269dcf0ea1b
>      ASoC: sam9x5_wm8731: change to work in DSP A mode
> by Bo Shen. (It needs another fix because TCMR CKS is set to PIN, but
> needs to be set to CLK, like it is for I2S, otherwise playback would stall)
>
> Even using DSP-A mode the sound sometimes is swapped and this is quite a
> problem.

Oops, DSP-A mode still has this issue? I will try to reproduce this 
issue. If any updates, I will let you know.

> Anyone found a fix?

Best Regards,
Bo Shen
