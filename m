From: Daniel Mack <zonque@gmail.com>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Tue, 23 Aug 2011 10:43:52 +0200
Message-ID: <CACTFLAP0gMjSShp59Gn1q+aXzPMNGMH05ze_p5S0sEsYwum9JA@mail.gmail.com>
References: <4E5234F0.8000502@amlie.name>
	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
	<4E52401C.8030605@amlie.name>
	<CACTFLANnEEV8waJvs7Yw4Y_KdD5CmK565+YBWLqZ8tu8qfGO3w@mail.gmail.com>
	<4E53585D.9050004@amlie.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id 4C9CD2461D
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 10:43:59 +0200 (CEST)
Received: by pzk1 with SMTP id 1so10782488pzk.2
	for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2011 01:43:52 -0700 (PDT)
In-Reply-To: <4E53585D.9050004@amlie.name>
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

On Tue, Aug 23, 2011 at 9:35 AM, Kristian Amlie <kristian@amlie.name> wrote:
> On 08/22/11 13:49, Daniel Mack wrote:
>> It doesn't seem to be using a standard MIDI interface, but there's a
>> chance that it accepts raw MIDI byte streams. Can you check the patch
>> below?
>
> With that patch, the device shows up, but aseqdump does not report any
> MIDI events after connecting to it.
>
> The Windows drivers are called "USB Serial Converter" and "USB Serial
> Port", so maybe it's all wrapped in a different protocol. Does that name
> ring a bell?

That's possible, and it should be easy to support these type of
devices in ALSA. However, some logic is neccessary to configure the
hardware to its correct baud rate and hardware protocol. The easiest
way to determine the setup sequence is certainly to sniff the Windows
driver communication with some tool like usbsnoop. Can you give that a
try?


Daniel
