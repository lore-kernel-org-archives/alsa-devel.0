From: =?ISO-8859-1?Q?st=E9phane_cerveau?= <scerveau@gmail.com>
Subject: Re: Default volume set to maximum
Date: Thu, 10 Oct 2013 16:48:40 +0200
Message-ID: <5256BE48.9040902@gmail.com>
References: <1380728209-24440-1-git-send-email-maillist-alsa@barfooze.de>
 <52569410.3040001@barfooze.de> <s5hfvs98f5j.wl%tiwai@suse.de>
 <5256A7FD.6040909@gmail.com> <5256B5A5.3080007@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id F33D7261701
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 16:48:42 +0200 (CEST)
Received: by mail-wg0-f42.google.com with SMTP id m15so9250684wgh.3
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 07:48:42 -0700 (PDT)
In-Reply-To: <5256B5A5.3080007@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thx for your reply
I just wanted to know if it was possible to put some default value =

overriding the default alsa mixer value.
Best regards.

Steph
On 10/10/2013 04:11 PM, Clemens Ladisch wrote:
> st=E9phane cerveau wrote:
>> Dear all,
> Please do not reply to another message if you want to start
> a new thread.
>
>> I would like to have a default volume set to maximum for my DAC/device.
>> Is there a way to tell alsa that my default volume is a certain value ?
> The default value is whatever volume the device uses when it is
> powered up, and typically cannot be changed.
>
> It is possible to change the value later.  Many distributions save/
> restore mixer settings when the computer is shut down/started up.
>
> What exactly is your problem?
>
>
> Regards,
> Clemens
