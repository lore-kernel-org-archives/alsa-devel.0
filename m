From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa] Crackling after 6.45 hours
Date: Mon, 26 Jan 2015 15:52:48 +0100
Message-ID: <54C654C0.9010307@metafoo.de>
References: <3427562.sVz54J9OhN@linux-le0l.site> <54C62E62.3060904@metafoo.de>
 <39512580.o0cGg5VYGZ@linux-le0l.site>
 <CAOMZO5CZjwdunjw=3uMGki782iAga5877_3huK41Axxi-cwqAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-157.synserver.de (smtp-out-157.synserver.de
 [212.40.185.157])
 by alsa0.perex.cz (Postfix) with ESMTP id 394A22605D7
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 15:52:50 +0100 (CET)
In-Reply-To: <CAOMZO5CZjwdunjw=3uMGki782iAga5877_3huK41Axxi-cwqAg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, "a.renault@kaptalia.com" <a.renault@kaptalia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 01/26/2015 03:44 PM, Fabio Estevam wrote:
> On Mon, Jan 26, 2015 at 12:41 PM, a.renault@kaptalia.com
> <a.renault@kaptalia.com> wrote:
>
>> First of all, I had to comment the lspci part of the script because I am using
>> busybox on my imx6. (Did not found a way to add it :S)
>>
>> Then I have got this card : http://www.msc-technologies.eu/products/boards/qseven/msc-q7-imx6.html
>> with a Wolfson WM9711.
>
> Which kernel version are you using? Can you try 3.19-rc6 or at least 3.18.3?

This seems to be a vendor kernel based on 3.0 with custom audio drivers. As 
Clemens said this is most likely a driver bug. So I guess there is not that 
much we can do.

- Lars
