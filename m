From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MOTU Midi Express XT
Date: Mon, 31 Oct 2016 16:01:02 +0100
Message-ID: <0ee7780b-d697-ace0-99bb-07ac36b710e1@ladisch.de>
References: <26f710a4f67283761948a697c1d6e698@owncloud.dehnhardt.org>
 <c04f2a54-3b2e-9a07-dd83-97a81c0123f8@ladisch.de>
 <2e5e4e51f4f2c63ecab719a1937d695f@owncloud.dehnhardt.org>
 <9d5810a657a4fb63805acea778570a49@owncloud.dehnhardt.org>
 <1bdf9e49-1bbb-4f45-5122-bd0f6f4315bf@ladisch.de>
 <bf3281416a57f2788d4772e9f7926b3a@owncloud.dehnhardt.org>
 <9393708728a54b11ca4bd1edc65d90f8@owncloud.dehnhardt.org>
 <56dad789446d6e7477f82b06ce68e941@owncloud.dehnhardt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 6F5B4261B03
 for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2016 16:01:34 +0100 (CET)
In-Reply-To: <56dad789446d6e7477f82b06ce68e941@owncloud.dehnhardt.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: holger@dehnhardt.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

holger@dehnhardt.org wrote:
> 29. Oktober 2016 21:28 Uhr, holger@dehnhardt.org schrieb:
>> 29. Oktober 2016 19:28 Uhr, "Clemens Ladisch" <clemens@ladisch.de> schrieb:
>>> Is there any message in the system log?
>>
>> Motu MidiTimePiece on parallel port irq: 10 ioport: 0xb010

In theory, this indicates that the driver has been initialized correctly.
But it doesn't actually check if the device is there.

A PCI device needs to be enabled before it can be used, and this driver
does not know about PCI.

The partport-serial driver gets loaded, doesn't it?

> I added a print statement to to __init function (see the code and arrow -> below).
> It initialises without error.
>
> static int __init alsa_card_mtpav_init(void)

The actual device initialization is in snd_mptav_probe().


Regards,
Clemens
