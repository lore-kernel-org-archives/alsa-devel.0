From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: module snd-atiixp issue with
	suspend/hibernate/resume
Date: Wed, 29 Apr 2009 22:42:10 -0400
Message-ID: <75b66ecd0904291942u3b352dbj74e5de00ebdf167b@mail.gmail.com>
References: <bf4fda4a0904282106u7fd3ed03s8d1234423abd679@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.152])
	by alsa0.perex.cz (Postfix) with ESMTP id EFD74103897
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Apr 2009 04:42:10 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 6so1021984yxn.2
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2009 19:42:10 -0700 (PDT)
In-Reply-To: <bf4fda4a0904282106u7fd3ed03s8d1234423abd679@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Dunn <oryandunn.ml@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 29, 2009 at 12:06 AM, Ryan Dunn <oryandunn.ml@gmail.com> wrote:
> I have a Compaq V2000 laptop with the ATI IXP chipset and make use of the
> snd-atiixp module. =A0The laptop needs to have the ac97_quirk option set =
to 7
> to enable the mute LED. =A0After setting this option in the
> /etc/modprobe.d/options.conf file, the mute LED works after a reboot.
> However, after a resume from suspend or hibernate, the mute LED does not
> work. =A0The alsa-info.sh script reports that the quirk is still set with=
 7.
> At this point a reboot will NOT fix the problem. =A0The only way to fix i=
t is
> to remove and reinsert the module with modprobe.
>
> This is on a fresh Ubuntu 9.04 install. =A0Any ideas? =A0I wasn't sure if=
 this
> should be reported here or on the kernel list. =A0I saw a similar issue w=
ith
> the ac97_quirk on the kernel list and they were referred here. =A0I'm a
> software developer, so I'd be willing to try ideas/possible solutions if =
you
> have them.

Get the Ubuntu source code for the package that owns that ALSA driver,
find the place in the driver's initialization code where ac97_quirk=3D7
is handled, then check the driver's suspend and resume callbacks and
make sure the suspend callback is correctly saving the LED state and
that the resume callback is re-initializing the LED from the saved
state in the same way the init code does.  grep and printk() are your
friends ;-)

HTH,

Lee
