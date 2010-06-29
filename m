From: Adish Kuvelker <adkuvi@gmail.com>
Subject: Re: snddevices issue
Date: Tue, 29 Jun 2010 22:19:33 +0530
Message-ID: <AANLkTilOUTWDlMPr7Mp7obI-vtR7cUTQ0g-Oc-BvWnLk@mail.gmail.com>
References: <AANLkTikzjyDqClZopaTvVmT7wwazRHE4K3XbH2m48rgg@mail.gmail.com>
	<4C2A1234.2030001@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9AA9F24740
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jun 2010 18:49:35 +0200 (CEST)
Received: by vws11 with SMTP id 11so4970332vws.38
	for <alsa-devel@alsa-project.org>; Tue, 29 Jun 2010 09:49:33 -0700 (PDT)
In-Reply-To: <4C2A1234.2030001@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The question is whether alsa utilities will run on nodes like pcmC0D0p
in such a situation?...The device nodes created under /dev and in proc
file system show different device numbers (minor numbers are
different).

Regards;
Aadish

On Tue, Jun 29, 2010 at 9:03 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Adish Kuvelker wrote:
>> I find that the device nodes created in the /dev/snd for Control,
>> Timer and pcmC0D0 have different minor numbers from the class devices
>> created by the ALSA core.
>
> The help text for the --enable-dynamic-minors option (when using the
> alsa-driver package) or the CONFIG_SND_DYNAMIC_MINORS option (when
> using the in-kernel ALSA) says that this can be used only when the
> machine is running udev. =A0(If you are actually running udev, you don't
> need the snddevices script).
>
>> I just did kernel prints to capture the minor numbers
>
> These numbers are also available in /proc/asound/devices.
>
>
> Regards,
> Clemens
>
