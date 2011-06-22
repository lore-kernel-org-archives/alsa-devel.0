From: Adam Jiang <jiang.adam@gmail.com>
Subject: Re: How to implement capture_switch control?
Date: Wed, 22 Jun 2011 16:56:26 +0900
Message-ID: <BANLkTinwT4TLrmaVOmLUfQE+zPAzH=zZ2A@mail.gmail.com>
References: <BANLkTikZYqdQJh6T1_XwpcxcTb=m1qOuUw@mail.gmail.com>
	<20110621015149.GA3753@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6A76724554
	for <Alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 09:56:28 +0200 (CEST)
Received: by ywm39 with SMTP id 39so278809ywm.38
	for <Alsa-devel@alsa-project.org>; Wed, 22 Jun 2011 00:56:26 -0700 (PDT)
In-Reply-To: <20110621015149.GA3753@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/6/21 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Jun 20, 2011 at 04:15:38PM +0900, Adam Jiang wrote:
>
>> I have a device with wm8903 codec. To support mute/unmute capture
>> signal, I was trying to enable/disable PGA on this codec from user
>> space application like
>
> If the hardware does not physically support mute then this should be
> emulated in software. =A0In the case of the WM8903 the device does not
> have a specific capture mute control, though extremely low gains are
> supported for the Capture Volume control which function as a mute so
> you could also set minimum Capture Volume.

I got the idea about software emulation for mute. Would you please
point me to an example about device/driver where hardware capture
switch is supported?

>
>> alwasy return false. I guess something is missing in my driver. Could
>> you please give some bright how could I use capture switch to
>> mute/unmute a channel. How could I implement capture_switch control
>> properly? Thank you!
>
> Not all hardware supports all possible features. =A0Either configure a
> software volume control, the softvol plugin for ALSA should be able to
> do this, or adjust your application to handle this in the application
> layer.
>
> http://alsa.opensrc.org/How_to_use_softvol_to_control_the_master_volume
>
> has some information on using softvol.
>

I have solved the problem by enabling/disabling PGA for analog input
paths. For digital mic on wm8903, this function could be implemented
by turning volume to lowest level for mute, and restore volume level
for unmute. Thank you!
