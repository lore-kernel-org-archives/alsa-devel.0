From: Ramya Desai <ramya.desai@gmail.com>
Subject: Re: Linux USB audio driver - sample code / link /
	documentation
Date: Fri, 26 Nov 2010 14:42:53 +0530
Message-ID: <AANLkTime7fy8UQe55A0w_ESF0yrwpDGiXMkaee1JFpo5@mail.gmail.com>
References: <AANLkTi=R_2dPhOGCB+5Dv_KUG3PrESg+Z+x1A_bhiTjr@mail.gmail.com>
	<4CEEC5B3.3040506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CE0F103CF4
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 10:12:55 +0100 (CET)
Received: by gyg8 with SMTP id 8so961745gyg.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 01:12:54 -0800 (PST)
In-Reply-To: <4CEEC5B3.3040506@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 26, 2010 at 1:53 AM, Daniel Mack <zonque@gmail.com> wrote:
> On 11/25/2010 01:51 AM, Ramya Desai wrote:
>> I did not find a document for writing a USB audio driver under Linux
>> environment. Please let me know any sample driver / link / document
>> which describes about the USB audio driver under Linux environment.
>
> As Clemens wrote, examining existing drivers in the kernel repository
> (under sound/usb) might help you most. Just have a look how they
> communicate with the hardware and how they set up the ALSA components
> inside the kernel.

Thank you very much for your reply.

I have gone through the sound/usb/* sources. However, I have also gone
through the sound/soc/* sources. There is a documentation about the
SOC implementation like platform driver, machine driver etc. The
documentation is available in Documentation/sound/alsa/soc. Is there
any documentation, like soc, for USB implementation?

Thanks and Regards,
Ramya.
