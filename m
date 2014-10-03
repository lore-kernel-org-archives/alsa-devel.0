From: Daniel Mack <daniel@zonque.org>
Subject: Re: Alsa-devel AKAI eie pro found on github
Date: Fri, 03 Oct 2014 20:26:21 +0200
Message-ID: <542EEA4D.4080806@zonque.org>
References: <mailman.1276.1412271694.872.alsa-devel@alsa-project.org>
 <cced3ce9f1b69ee542f027c829207ba2@ztealmax.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E40F2604AF
 for <alsa-devel@alsa-project.org>; Fri,  3 Oct 2014 20:26:27 +0200 (CEST)
In-Reply-To: <cced3ce9f1b69ee542f027c829207ba2@ztealmax.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Svensson <martin.svensson@ztealmax.se>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/02/2014 08:03 PM, Martin Svensson wrote:
> Hello ive talked to you about the akai eie pro of the posibility to get
>      it working on
>      linux, i found this on the web is it some one of you working on this
>      driver?
>      github(dot)com/mmm444/eie-pro-linux
>      Sincerally looking forward to responces :)

The code in this repository has nothing to do with an ALSA kernel
driver. It's a userspace program that uses libusb to communicate with an
USB device. That could be a proof of concept to figure out the protocol
details, I don't know.

Best to contact the author of that repository and ask what his/her plans
are. Patches for ALSA to support more hardware are always welcome, but
the driver must eventually live in the kernel.


Daniel
