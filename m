From: Joao Bonina <bonina_2001@yahoo.com>
Subject: Re: Alsa: USB Class 2 Audio soundcard device
	disappears suddenly
Date: Wed, 1 Aug 2012 03:07:59 -0700 (PDT)
Message-ID: <1343815679.50686.YahooMailNeo@web121604.mail.ne1.yahoo.com>
References: <1343736296.42529.YahooMailNeo@web121606.mail.ne1.yahoo.com>
 <Pine.LNX.4.44L0.1207311034140.1532-100000@iolanthe.rowland.org>
Reply-To: Joao Bonina <bonina_2001@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm17-vm3.bullet.mail.ne1.yahoo.com
 (nm17-vm3.bullet.mail.ne1.yahoo.com [98.138.91.147])
 by alsa0.perex.cz (Postfix) with SMTP id 7B3A9260316
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 12:07:59 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.44L0.1207311034140.1532-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-usb <linux-usb@vger.kernel.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org






>________________________________
> From: Alan Stern <stern@rowland.harvard.edu>
>To: Joao Bonina <bonina_2001@yahoo.com> =

>Cc: Daniel Mack <zonque@gmail.com>; "alsa-devel@alsa-project.org" <alsa-de=
vel@alsa-project.org>; linux-usb <linux-usb@vger.kernel.org> =

>Sent: Tuesday, 31 July 2012, 15:35
>Subject: Re: [alsa-devel] Alsa: USB Class 2 Audio soundcard device disappe=
ars suddenly
> =

>On Tue, 31 Jul 2012, Joao Bonina wrote:
>
>> You're right about the EMI message, it's happening when the streaming st=
ops.
>> =

>> I've tried different cables before, but that didn't solve the problem.
>> =

>> The motherboard is an Alix 1D, and I'm using the onboard USB 2.0 ports.
>> =

>> If this really is an EMI issue, guess I'll have to source some kind of m=
iniPCI-USB 2.0 card and see if that solves the problem.
>
>Another possibility is to put a USB hub before the sound device.=A0 That =

>_might_ clean up the signal.
>
>Alan Stern
>


Thanks for that suggestion, Alan.

I=A0 used a cheap hub that I had stashed away. At the begining that seemed =
to solve the problem. But after a while, some clicks and pops became audibl=
e.

Disconnected it all for a while, and when I reconnected, the problem was ba=
ck again with this message on mpd.log:

Aug 01 05:57 : output: "USB" [alsa] failed to play: No such device
Aug 01 05:57 : output: closed plugin=3Dalsa name=3D"USB"



This time, there's no EMI message in dmesg. =



Still have to try copying files from one usb flash to another.

Jo=E3o Bonina



>
