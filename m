From: Daniel Mack <zonque@gmail.com>
Subject: Re: US-1641 drivers involvment
Date: Sun, 08 Sep 2013 16:42:05 +0200
Message-ID: <522C8CBD.9000109@gmail.com>
References: <CA+5WxH+L75iiV4OkXoHAZk38AG9984VLctGNKm+61nTh4P2XTA@mail.gmail.com>
 <521F4639.2060600@ladisch.de>
 <CA+5WxHLQ-Ao80aUVg6nt2shYJ=7GFWvVuQqyMVC92Lm1obWgEA@mail.gmail.com>
 <CA+5WxHJ9wBB8-YB=mFFMv=qxvuxKzZmw1XFgNXuwnuixt9hocA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id B7C682616C1
 for <alsa-devel@alsa-project.org>; Sun,  8 Sep 2013 16:42:08 +0200 (CEST)
Received: by mail-wg0-f47.google.com with SMTP id f12so4365768wgh.2
 for <alsa-devel@alsa-project.org>; Sun, 08 Sep 2013 07:42:07 -0700 (PDT)
In-Reply-To: <CA+5WxHJ9wBB8-YB=mFFMv=qxvuxKzZmw1XFgNXuwnuixt9hocA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Luca Novarini <luca.novarini@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 05.09.2013 14:30, Luca Novarini wrote:
> Hello?
> No one got any advice where to start?

Try to add the USB ID to the exisiting Tascam driver. Than see how far
the driver gets in understanding the device's replies to the setup commands.

As Clemens said, you probably need to reverse engineer the Windows
driver in order to understand the details in their protocol.


Daniel
