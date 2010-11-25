From: Daniel Mack <zonque@gmail.com>
Subject: Re: Linux USB audio driver - sample code / link /
	documentation
Date: Thu, 25 Nov 2010 12:23:15 -0800
Message-ID: <4CEEC5B3.3040506@gmail.com>
References: <AANLkTi=R_2dPhOGCB+5Dv_KUG3PrESg+Z+x1A_bhiTjr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D10910397A
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 21:23:20 +0100 (CET)
Received: by gwaa20 with SMTP id a20so719841gwa.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 12:23:19 -0800 (PST)
In-Reply-To: <AANLkTi=R_2dPhOGCB+5Dv_KUG3PrESg+Z+x1A_bhiTjr@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/25/2010 01:51 AM, Ramya Desai wrote:
> I did not find a document for writing a USB audio driver under Linux
> environment. Please let me know any sample driver / link / document
> which describes about the USB audio driver under Linux environment.

As Clemens wrote, examining existing drivers in the kernel repository
(under sound/usb) might help you most. Just have a look how they
communicate with the hardware and how they set up the ALSA components
inside the kernel.

Is there any documentation for the chip you're writing the driver for,
about the USB protocol it uses etc? Are you sure it does not follow the
USB audio class specifications? Posting the output of 'lsusb -v' might
also help.


Daniel
