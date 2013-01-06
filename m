From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Roland-Boss RC-300 support
Date: Sun, 06 Jan 2013 21:18:36 +0100
Message-ID: <50E9DC1C.6030704@ladisch.de>
References: <CAEzrNVQop3Og5KwcHM9cHH_FdUWEkD4iBx-dBBxeEsuH_+o1JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 73CFF264F1C
 for <alsa-devel@alsa-project.org>; Sun,  6 Jan 2013 21:19:17 +0100 (CET)
In-Reply-To: <CAEzrNVQop3Og5KwcHM9cHH_FdUWEkD4iBx-dBBxeEsuH_+o1JA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Samuel Reynaud <js.reynaud@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jean-Samuel Reynaud wrote:
> I have a Boss RC-300 loop station with an USB connector. The windows
> driver add an audio device but it was not working under linux. So
> please find attached, the patch for supporting audio in this device.

Thanks, but please read Documentation/SubmittingPatches.

> Note that midi is not working yet but I'm working on it...

Please show the output of "lsusb -v" for this device.


Regards,
Clemens
