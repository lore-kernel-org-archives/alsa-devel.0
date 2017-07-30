From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Gina 3g and Echomixer issue
Date: Sun, 30 Jul 2017 16:32:21 +0200
Message-ID: <0c17fe9f-a231-10fe-3a92-d0279c40246d@ladisch.de>
References: <1501304297.1407.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 495F1266C9B
 for <alsa-devel@alsa-project.org>; Sun, 30 Jul 2017 16:32:41 +0200 (CEST)
Received: from [192.168.42.63] (tmo-096-125.customers.d1-online.com
 [80.187.96.125])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 9EE2E5582665
 for <alsa-devel@alsa-project.org>; Sun, 30 Jul 2017 16:32:40 +0200 (CEST)
In-Reply-To: <1501304297.1407.0@smtp.gmail.com>
Content-Language: en-US
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

Britt Yazel wrote:
> each time I reboot the system the digital mode is set to Coaxial
> digital, rather than ADAT, and I must set it after each reboot. Is
> there a way to make this setting persist through reboot, or perhaps
> a parameter that can be set when the kernel module is loaded to force
> ADAT?

In theory, all mixer controls can be saved over reboots.  (Some boot
script should call "alsactl store"/"alsactl restore").  Does this happen
for other controls?

As a last resort, you could change that control separately:

  amixer set "Digital mode Switch" "ADAT Optical"


Regards,
Clemens
