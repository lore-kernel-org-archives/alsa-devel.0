From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio Interface
 support to quirks-table
Date: Mon, 10 Mar 2014 16:40:52 +0100
Message-ID: <531DDD04.5050902@ladisch.de>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>
 <531DAB14.5080201@ladisch.de>
 <76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id DE11726571F
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 16:40:53 +0100 (CET)
In-Reply-To: <76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cyrus Harmon <cyrus@bobobeach.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cyrus Harmon wrote:
> The attached patch provides support for the Steinberg UR44 USB Audio
> Interface. It=92s nothing more than Clemens=92 patch to support the UR22,
> with the device ID modified for the UR44. The patch was tested with
> kernel versions 3.12.11 and 3.12.12 and I have primarily used it with
> a PREEMPT RT-patched 3.12.12-rt kernel.

In theory, kernel 3.11 and later should support this device without
a quirk entry.  I guess it actually does not?

> I should note that on one of the systems that I used to test the patch
> I was never able to achieve xrun-free JACK performance at -p256 -n3 as
> I would invariably see xruns roughly once every minute.

This sounds as if the playback stream needs to be synchronized to the
recording stream.

What is the output of "lsusb -v" for this device?


Regards,
Clemens
