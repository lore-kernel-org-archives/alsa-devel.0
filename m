From: Daniel Mack <zonque@gmail.com>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Mon, 22 Aug 2011 12:54:36 +0200
Message-ID: <CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
References: <4E5234F0.8000502@amlie.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id 68E782458E
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 12:54:37 +0200 (CEST)
Received: by pzk1 with SMTP id 1so9123980pzk.2
	for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2011 03:54:36 -0700 (PDT)
In-Reply-To: <4E5234F0.8000502@amlie.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristian Amlie <kristian@amlie.name>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 22, 2011 at 12:52 PM, Kristian Amlie <kristian@amlie.name> wrote:
> I have just received a new MIDI instrument (Starr Labs Z7S) which is not
> recognized by the kernel, and I'd like to add support for it. I'm hoping
> that it uses a standard MIDI interface and it's just a matter of adding
> the correct entry in the table of devices.
>
> I have tried to add an entry to sound/usb/usbquirks.h
> (sound/usb/quirks-table.h in later kernels), but so far I haven't
> succeeded. Is there any documentation for how to do this, and which
> options to use? Google hasn't really turned up anything...

The USB descriptors should give us a hint. Can you send your "lsusb
-v" output, please?


Daniel
