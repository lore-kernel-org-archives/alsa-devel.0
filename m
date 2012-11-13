From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: CM6206, S/PDIF + JACK
Date: Tue, 13 Nov 2012 13:55:38 +0100
Message-ID: <50A2434A.8000803@ladisch.de>
References: <CANOoOjsvRWz6N7eUgJRyFohqih4_d9-sCXhHpWs3M7i4wXjbWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 4E1FD26516B
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 13:55:40 +0100 (CET)
In-Reply-To: <CANOoOjsvRWz6N7eUgJRyFohqih4_d9-sCXhHpWs3M7i4wXjbWQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan MacDonald <allcoms@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dan MacDonald wrote:
> I've got a Startech USB device based on the CM6206 chipset. It does work
> with JACK although I can only access the two mic inputs as JACK capture
> ports even though under alsamixer I can also see line in and SPDIF In.
>
> I get no SPDIF capture port.

Have a look at section 5 of the CM6206 datasheet.
There is no S/PDIF capture port; all inputs end up at the default
stereo input port.


Regards,
Clemens
