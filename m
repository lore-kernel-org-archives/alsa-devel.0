From: Mike Crowe <drmikecrowe@gmail.com>
Subject: Re: Accessing snd_soc_read/snd_soc_write directly for
	diagnostics
Date: Fri, 16 Jul 2010 12:00:32 +0800
Message-ID: <AANLkTimkvvZdxmJV34FozLg0e-RTPAnBvqyqmEXOu0hP@mail.gmail.com>
References: <AANLkTimRMrKi-HNOB68jWSiX6TYTuOjRCySAqvRtpWLy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4050A103930
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 06:00:58 +0200 (CEST)
Received: by ewy21 with SMTP id 21so448074ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2010 21:00:57 -0700 (PDT)
Received: by eye27 with SMTP id 27so334148eye.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2010 21:00:52 -0700 (PDT)
In-Reply-To: <AANLkTimRMrKi-HNOB68jWSiX6TYTuOjRCySAqvRtpWLy@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi folks,

Cancel this.  Turns out our codec only implemented i2c read for the first 4
bytes (not all registers).  However, it is caching the registers in the
"/sys/devices/platform/soc-audio/codec_reg" file, which was what we needed
to get to.

Thanks
Mike

On Fri, Jul 16, 2010 at 9:33 AM, Mike Crowe <drmikecrowe@gmail.com> wrote:

> Hi folks,
>
> I know this is a strange request, however, for diagnostic purposes in our
> embedded system, we would like to talk directly to the codec registers of
> our sound chip, bypassing alsa.  I have the driver compiled into the kernel
> (not loaded as a module).
>
> Is it possible to create a program which can talk to the snd_soc_read and
> snd_soc_write functions directly?  I'm not sure if this is an option, but if
> it is, I'd appreciate a pointer to something similar to use as a guide.
>
> TIA
> Mike
>
