From: Matteo Fortini <matteo.fortini@gmail.com>
Subject: WM8904 SAMA5D channel swap
Date: Fri, 18 Jul 2014 15:31:41 +0200
Message-ID: <53C921BD.809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 35593265610
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 15:31:46 +0200 (CEST)
Received: by mail-we0-f179.google.com with SMTP id u57so4552807wes.10
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 06:31:44 -0700 (PDT)
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
Cc: Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

I'm seeing left/right channel swapping problems on a board with a WM8904 
codec and a SAMA5D35 CPU.

configuration is CBM and CFM and original data format is I2S. Our board 
has the same connections and parts as the EK from Atmel.

I tried to apply commit bc567a93502275755492141524935269dcf0ea1b
     ASoC: sam9x5_wm8731: change to work in DSP A mode
by Bo Shen. (It needs another fix because TCMR CKS is set to PIN, but 
needs to be set to CLK, like it is for I2S, otherwise playback would stall)

Even using DSP-A mode the sound sometimes is swapped and this is quite a 
problem.

Anyone found a fix?
