From: Todd Dailey <todd@todddailey.ca>
Subject: Re: No sound from Mac Pro headphone port
Date: Fri, 19 Jun 2015 08:38:01 -0400
Message-ID: <55840D29.6010702@todddailey.ca>
References: <554CC0EC.5000506@todddailey.ca>
 <CAN8cciYJdMeKyYL1mqUkN3bKmEhwqHN1-pZzCvBDazBPKdH7vw@mail.gmail.com>
 <554CCCAF.6000608@todddailey.ca>
 <CAN8cciaSiJBr4RKP6Rj3JurnrPEGufBsnLEACdvrhRLcRfPkcg@mail.gmail.com>
 <5555460D.3060907@todddailey.ca>
 <CAN8cciaEdt3zM_V7M4_8YVBHrs+GQsfs1jV32owfsR_2oO52AA@mail.gmail.com>
 <CAN8cciaepxbsuprm+EFr4jE24so1-WMnNDOfdQQPaM9AsK2hNQ@mail.gmail.com>
 <55819224.5090105@todddailey.ca>
 <CAN8cciZesh=oO765REcCo=ce8vO63ASthWGFROM5p06Ms+nx1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yonca.sibername.com (yonca.sibername.com [67.212.91.121])
 by alsa0.perex.cz (Postfix) with ESMTP id 884E8266501
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 14:38:35 +0200 (CEST)
In-Reply-To: <CAN8cciZesh=oO765REcCo=ce8vO63ASthWGFROM5p06Ms+nx1g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

As I have time to work on this ...

ALSA info headphone unplugged:

http://www.alsa-project.org/db/?f=df059dc59473b812033be118a26a553767879f41

Headphone plugged:

http://www.alsa-project.org/db/?f=b91b9b46a1abe043b9dfc3bc4802b203e6a6c2e5


-- 
TD
todd@todddailey.ca

On 18/06/15 11:00 AM, Raymond Yau wrote:
> l
>  > Has there been any progress on fixing this issue?
>  >
>  > It seems that no matter what combination of settings I try with
> hdajackretask, I cannot get sound from the headphone port.
>
> Can you post the output after you retasking ?
>
>  >
>  > Jack in / out plugged status is correctly detected. However,
> selecting Headphones for output plays sound from the Line Out port. The
> Line Out port selection works as expected. I can set separate volume
> levels for both Headphone and Line Out but both selections play through
> the Line Out port.
>
> Need your patched alsa-info when headpone unpluged and plugged
>
> For the headset mic
>
> Seem need  to recompile alsa driver since spec->parser_flags cannot be
> changed by hint.
>
> spec->parser_flags = HDA_PINCFG_HEADSET_MIC;
>
> It also depend whether you alc889a need any vendor coeff
>
