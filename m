From: Fabio Estevam <festevam@gmail.com>
Subject: Re: iMX6 ESAI TDM with underrun and overrun support
Date: Wed, 17 Dec 2014 17:19:32 -0200
Message-ID: <CAOMZO5Br58rZTSSjvve02t0LWi-k0VxGrQ9WRgur8MW11nGMLA@mail.gmail.com>
References: <1758576875.330121.1418829223072.JavaMail.yahoo@jws11142.mail.ir2.yahoo.com>
 <CAOMZO5BOfk1HDmFmS+NQx4FWOf-bS9We46aLF89_iducw-KbxA@mail.gmail.com>
 <CAOMZO5DZnk8ORZxfDb1=R=3c7zmRMEKH2euvkX=WJEOM+u0GiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id AEA75260690
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 20:19:32 +0100 (CET)
Received: by mail-la0-f48.google.com with SMTP id gf13so13469775lab.21
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 11:19:32 -0800 (PST)
In-Reply-To: <CAOMZO5DZnk8ORZxfDb1=R=3c7zmRMEKH2euvkX=WJEOM+u0GiQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Aurelien Bouin <a_bouin@yahoo.fr>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 17, 2014 at 5:16 PM, Fabio Estevam <festevam@gmail.com> wrote:

> I just looked at the manual: TFP and RFP are 4-bit dividers, so the
> current code is correct.

Your second hunk:

-#define ESAI_xCCR_xDC_WIDTH    4
+#define ESAI_xCCR_xDC_WIDTH    5

Looks correct though. Would you like to submit a patch to fix it?
