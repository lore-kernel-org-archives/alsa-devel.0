From: Joao Bonina <bonina_2001@yahoo.com>
Subject: Re: Alsa: USB Class 2 Audio soundcard device
	disappears suddenly
Date: Thu, 2 Aug 2012 08:10:40 -0700 (PDT)
Message-ID: <1343920240.85272.YahooMailNeo@web121605.mail.ne1.yahoo.com>
References: <1343736296.42529.YahooMailNeo@web121606.mail.ne1.yahoo.com>
 <Pine.LNX.4.44L0.1207311034140.1532-100000@iolanthe.rowland.org>
 <1343815679.50686.YahooMailNeo@web121604.mail.ne1.yahoo.com>
Reply-To: Joao Bonina <bonina_2001@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm22-vm3.bullet.mail.ne1.yahoo.com
 (nm22-vm3.bullet.mail.ne1.yahoo.com [98.138.91.152])
 by alsa0.perex.cz (Postfix) with SMTP id 83168265363
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2012 17:10:39 +0200 (CEST)
In-Reply-To: <1343815679.50686.YahooMailNeo@web121604.mail.ne1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joao Bonina <bonina_2001@yahoo.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-usb <linux-usb@vger.kernel.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org



----- Original Message -----
> From: Joao Bonina <bonina_2001@yahoo.com>
> To: Alan Stern <stern@rowland.harvard.edu>
> Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>; linux-us=
b <linux-usb@vger.kernel.org>; Daniel Mack <zonque@gmail.com>
> Sent: Wednesday, 1 August 2012, 11:07
> Subject: Re: [alsa-devel] Alsa: USB Class 2 Audio soundcard device disapp=
ears suddenly
> =

> =

> =

>> ________________________________
>>  From: Alan Stern <stern@rowland.harvard.edu>
>> To: Joao Bonina <bonina_2001@yahoo.com> =

>> Cc: Daniel Mack <zonque@gmail.com>; =

> "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>; =

> linux-usb <linux-usb@vger.kernel.org> =

>> Sent: Tuesday, 31 July 2012, 15:35
>> Subject: Re: [alsa-devel] Alsa: USB Class 2 Audio soundcard device =

> disappears suddenly
>> =

>> On Tue, 31 Jul 2012, Joao Bonina wrote:
>> =

>>>  You're right about the EMI message, it's happening when the =

> streaming stops.
>>> =

>>>  I've tried different cables before, but that didn't solve the =

> problem.
>>> =

>>>  The motherboard is an Alix 1D, and I'm using the onboard USB 2.0 =

> ports.
>>> =

>>>  If this really is an EMI issue, guess I'll have to source some kind =

> of miniPCI-USB 2.0 card and see if that solves the problem.
>> =

>> Another possibility is to put a USB hub before the sound device.=A0 That =

>> _might_ clean up the signal.
>> =

>> Alan Stern
>> =

> =

> =

> Thanks for that suggestion, Alan.
> =

> I=A0 used a cheap hub that I had stashed away. At the begining that seeme=
d to =

> solve the problem. But after a while, some clicks and pops became audible.
> =

> Disconnected it all for a while, and when I reconnected, the problem was =
back =

> again with this message on mpd.log:
> =

> Aug 01 05:57 : output: "USB" [alsa] failed to play: No such device
> Aug 01 05:57 : output: closed plugin=3Dalsa name=3D"USB"
> =

> =

> =

> This time, there's no EMI message in dmesg. =

> =

> =

> Still have to try copying files from one usb flash to another.
> =

> Jo=E3o Bonina
> =

> =


Did the copying test and all went well there.

Also did a usbmon =

session with the DAC disconnecting/reconnecting automatically. There was
 no EMI message in dmesg there, and I'm connecting the DAC through a USB
 hub.

Analyzed the usbmon log with Virtual USB analyzer, but =

couldn't find reasons there for the disconnection. I'm not very =

experienced in this subject, so excuse me if I'm missing something =

obvious here.

I have the usbmon log. If someone wants to take a look at it, please let me=
 know and I'll send it.


Cheers,
Joao Bonina
