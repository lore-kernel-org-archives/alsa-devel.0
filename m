From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: Keyboard volume buttons
Date: Thu, 5 Mar 2009 19:06:21 +0530
Message-ID: <98769532B4BB14429434178695419EAE3219F953@bgsmsx501.gar.corp.intel.com>
References: <98769532B4BB14429434178695419EAE3208CBBD@bgsmsx501.gar.corp.intel.com>
	<fd3eb9bf0902262306t71958159h42325e98035ceb6c@mail.gmail.com>
	<20090228070007.GA21641@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DAEF24480
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 14:38:12 +0100 (CET)
In-Reply-To: <20090228070007.GA21641@tango.0pointer.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks a lot. That helps!

>-----Original Message-----
>From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-=
project.org]
>On Behalf Of Lennart Poettering
>Sent: Saturday, February 28, 2009 12:30 PM
>To: alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] Keyboard volume buttons
>
>On Fri, 27.02.09 08:06, Vedran Mileti=E6 (rivanvx@gmail.com) wrote:
>
>> On Fri, Feb 27, 2009 at 3:20 AM, Harsha, Priya <priya.harsha@intel.com> =
wrote:
>> > Hi,
>> >
>> > Can anyone tell me how keyboard's volume buttons are converted into re=
al volume
>change? Will there be an application that monitors the keyboard volume but=
ton events and
>call ALSA API to set the volume?
>> >
>> > Thanks
>> > Harsha
>> >
>> > _______________________________________________
>> > Alsa-devel mailing list
>> > Alsa-devel@alsa-project.org
>> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >
>>
>> Yes, X catches keypress and lets the window manager know about it. In
>> case of metacity, which is what GNOME uses, if that key is bound to a
>> volume control action, it calls gnome-volume-control to do the
>> apropriate change. I _believe_ it is so, never checked source code.
>
>It is actually not the window manager.
>
>In GNOME it is a little daemon that runs in the session and is called
>gnome-settings-daemon. It does a lot of little thinks, one of them
>handling volume key events and showing a nice OSD for it.
>
>Lennart
>
>--
>Lennart Poettering                        Red Hat, Inc.
>lennart [at] poettering [dot] net         ICQ# 11060553
>http://0pointer.net/lennart/           GnuPG 0x1A015CC4
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@alsa-project.org
>http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
