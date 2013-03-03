From: LH <lhyyryne@live.com>
Subject: Re: Trouble about Roland UA-55 and snd-usb-audio module
Date: Sun, 3 Mar 2013 14:25:42 +0200
Message-ID: <BLU0-SMTP3373EB4C32D8FE75E0B686A7F90@phx.gbl>
References: <50A349A5.6010403@firebuntu.com> <50A34C36.7080506@ladisch.de>
 <50A56FE6.3050009@firebuntu.com> <loom.20130109T124035-460@post.gmane.org>
 <50FC3009.9070401@ladisch.de> <loom.20130125T202229-943@post.gmane.org>
 <loom.20130128T221942-836@post.gmane.org> <5106F107.90704@ladisch.de>
 <loom.20130131T042847-100@post.gmane.org> <51140FFD.3060907@ladisch.de>
 <5114F5D6.4070404@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s16.blu0.hotmail.com (blu0-omc3-s16.blu0.hotmail.com
 [65.55.116.91]) by alsa0.perex.cz (Postfix) with ESMTP id 7B6F62616EF
 for <alsa-devel@alsa-project.org>; Sun,  3 Mar 2013 13:25:46 +0100 (CET)
In-Reply-To: <5114F5D6.4070404@ladisch.de>
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

On 02/08/2013 02:55 PM, Clemens Ladisch wrote:
> I wrote:
>>        ALSA: usb-audio: detect implicit feedback on Roland devices
> This probably works only with the first rate (44.1 kHz), but please
> test anyway.
>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
I can confirm the current version 
0ddd4478912f64e6976774c00d29a5d24adab479 works at 44.1kHz with the 
Roland Quad-Capture.

$ lsusb|grep Roland
Bus 003 Device 002: ID 0582:012f Roland Corp.


Regards,
Lasse
