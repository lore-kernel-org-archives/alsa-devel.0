From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l35: Stash dev pointer directly
 rather than CODEC pointer
Date: Fri, 17 Mar 2017 20:07:19 +0000
Message-ID: <50852009-6dfe-4476-9266-da7803d61c44@EX3.ad.cirrus.com>
References: <1489765495-8502-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E8157267238
 for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2017 21:07:24 +0100 (CET)
In-Reply-To: <1489765495-8502-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <63E57DC21EEFBE4EB3C780C37C4CA577@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org



On 3/17/17, 10:44 AM, "Charles Keepax" <ckeepax@opensource.wolfsonmicro.com> wrote:

    The driver stashes a CODEC pointer in the cs35l35_private structure,
    which is used to obtain a struct device pointer for error messages in the
    interrupt handler.
    
    However, doing so is not very safe as the interrupt is registered, as it
    should be in bus probe, but the CODEC pointer can't be safely stored until
    the ASoC level probe. This leaves a window between the two probes where if
    any interrupts are received a NULL pointer will be deferenced in the IRQ
    handler.
    
    Fix this issue by saving a pointer to the device directly and passing that
    to the error messages in the interrupt handler rather than using the CODEC
    pointer to access the device pointer.
    
    Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
    ---
Acked-by: Brian Austin <brian.austin@cirrus.com> 
