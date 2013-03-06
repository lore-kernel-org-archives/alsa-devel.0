From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA: usb: Work around CM6631 sample
Date: Wed, 06 Mar 2013 09:43:00 +0100
Message-ID: <51370194.1080808@ladisch.de>
References: <001f01ce19fa$6d770c80$48652580$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 20D9426086D
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 09:43:03 +0100 (CET)
In-Reply-To: <001f01ce19fa$6d770c80$48652580$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Demian Martin <demianm_1@yahoo.com>
Cc: hegge@resisty.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Demian Martin wrote:
> CMedia ... told me that the chips are different

The CM6610/20 chips did not get an updated -A version, so it's possible
that the changes are just for the I=B2S I/Os, which should not affect the
USB interface.  Maybe the newer chip just gave them an opportunity to
update the firmware.

> there is a sequence problem between setting sample rate and sending
> the "play' command.

This sound like the interface setting problem fixed by this patch.

> Something about UAC1 method not being the same as UAC2.

But this might indicate that we need to kick the Clock Source Entity.


Regards,
Clemens
