From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA error : frame 0 active: -75
Date: Fri, 12 Nov 2010 09:46:49 +0100
Message-ID: <4CDCFEF9.6060700@ladisch.de>
References: <AANLkTin2wz0U-nociG9qMFP5R8ZhgVdDQASdXsezgzEh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 5E433103917
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 09:44:55 +0100 (CET)
In-Reply-To: <AANLkTin2wz0U-nociG9qMFP5R8ZhgVdDQASdXsezgzEh@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajul Kumar <rajul.manit1@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rajul Kumar wrote:
> ALSA sound/usb/usbaudio.c:354: frame 0 active: -75

-75 = -EOVERFLOW

> which is followed by coninous loop of below messages :
> 
> ALSA sound/usb/usbaudio.c:354: frame 0 active: -71

-71 = -EPROTO

> ALSA sound/usb/usbaudio.c:354: frame 0 active: -18

-18 = -EXDEV

Documentation/usb/error-codes.txt says:
| -EOVERFLOW (*)          The amount of data returned by the endpoint was
|                         greater than either the max packet size of the
|                         endpoint or the remaining buffer size.  "Babble".

| -EPROTO (*, **)         a) bitstuff error
|                         b) no response packet received within the
|                            prescribed bus turn-around time
|                         c) unknown USB error 

| -EXDEV                  ISO transfer only partially completed
|                         look at individual frame status for details

| (*) Error codes like -EPROTO, -EILSEQ and -EOVERFLOW normally indicate
| hardware problems such as bad devices (including firmware) or cables.


Regards,
Clemens
