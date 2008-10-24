From: "Sean McNamara" <smcnam@gmail.com>
Subject: Re: volume scaling of usb audio class headset
Date: Fri, 24 Oct 2008 14:13:29 -0400
Message-ID: <74eb1fe20810241113q7ee8aa9ah63cf5346c6b940c1@mail.gmail.com>
References: <49020760.9080900@powercraft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id C8BBD245D6
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 20:13:47 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id l35so527048waf.16
	for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2008 11:13:29 -0700 (PDT)
In-Reply-To: <49020760.9080900@powercraft.nl>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jelle de Jong <jelledejong@powercraft.nl>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There is a *huge* (83 replies) thread in the alsa-devel ML archives
about this problem. Lennart Poettering raised the issue regarding his
Logitech external USB speakers.

http://article.gmane.org/gmane.linux.alsa.devel/52524

Sort through the replies to see if you can make any sense out of the
workarounds, patches, and so on that resulted from this discussion. If
possible, try the latest GIT alsa-driver and alsa-lib.

Sean

On Fri, Oct 24, 2008 at 1:35 PM, Jelle de Jong
<jelledejong@powercraft.nl> wrote:
> Hello everybody,
>
> I got a question, I got a few usb headsets that seem to apply to the usb
> audio class and the volume scale is way to big with alsa. with the
> control on 10 of the 100 you are almost getting deaf. So my question is
> how does alsa make an scaling for such devices and how to fix it so that
> the full range can be used in a normal volume spectrum.
>
> Thank in advance,
>
> Jelle
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
