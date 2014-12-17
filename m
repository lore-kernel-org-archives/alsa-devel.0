From: Fabio Estevam <festevam@gmail.com>
Subject: Re: iMX6 ESAI TDM with underrun and overrun support
Date: Wed, 17 Dec 2014 17:16:16 -0200
Message-ID: <CAOMZO5DZnk8ORZxfDb1=R=3c7zmRMEKH2euvkX=WJEOM+u0GiQ@mail.gmail.com>
References: <1758576875.330121.1418829223072.JavaMail.yahoo@jws11142.mail.ir2.yahoo.com>
 <CAOMZO5BOfk1HDmFmS+NQx4FWOf-bS9We46aLF89_iducw-KbxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com
 [209.85.217.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 142FC2606B2
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 20:16:18 +0100 (CET)
Received: by mail-lb0-f174.google.com with SMTP id 10so13536401lbg.33
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 11:16:16 -0800 (PST)
In-Reply-To: <CAOMZO5BOfk1HDmFmS+NQx4FWOf-bS9We46aLF89_iducw-KbxA@mail.gmail.com>
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

On Wed, Dec 17, 2014 at 2:04 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Aurelien,
>
> [Adding Nicolin and Mark on Cc]
>
> On Wed, Dec 17, 2014 at 1:13 PM, Aurelien Bouin <a_bouin@yahoo.fr> wrote:
>> Hello,
>> I am currently working on an iMX6 board, I work with the master branch of git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
>> I have seen some problems in the freescale ESAI implementation :
>>
>> 1.The registers TCCR and RCCR have TFP and RFP bits in register of a width of 5, not 4 !

I just looked at the manual: TFP and RFP are 4-bit dividers, so the
current code is correct.
