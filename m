From: Daniel Mack <zonque@gmail.com>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Wed, 24 Aug 2011 15:18:20 +0200
Message-ID: <CACTFLAM_g-ASNkKV4it9DyUu_ymsS8tL51kPgeistX9UH5dpLg@mail.gmail.com>
References: <4E5234F0.8000502@amlie.name>
	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
	<4E52401C.8030605@amlie.name> <4E537524.9010303@ladisch.de>
	<4E537BE9.4050004@amlie.name>
	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>
	<4E53959A.7090702@amlie.name>
	<CACTFLAMh2Brji5NBOZjtDmyP-DPR3S4HCP93SO0sE9J7xEn3NQ@mail.gmail.com>
	<4E53A748.4070404@amlie.name>
	<CACTFLANSwy66KAyLbxyy=pB9Z+K+r7ur564Frx7ep1W_JY=XCQ@mail.gmail.com>
	<4E53AAE4.2070303@amlie.name>
	<CACTFLANav3woJuXjdpsYEqvvbbTb53S0d2MtVoq9EByv-j-cxw@mail.gmail.com>
	<4E54B1A5.5080507@amlie.name>
	<CACTFLAPkyYNxRkd=9R12U8_dBbkJQZ=LSXr9a8au_Kfc5R78fQ@mail.gmail.com>
	<4E54CF09.90001@amlie.name>
	<CACTFLAPMg75au0VX_rAF3dLRsSyX8Wex+LFj7pfPXygvZrR7qw@mail.gmail.com>
	<4E54F953.2060209@amlie.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id 4F91924699
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 15:18:21 +0200 (CEST)
Received: by pzk1 with SMTP id 1so833762pzk.2
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2011 06:18:20 -0700 (PDT)
In-Reply-To: <4E54F953.2060209@amlie.name>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 24, 2011 at 3:14 PM, Kristian Amlie <kristian@amlie.name> wrote:
> On 08/24/11 12:29, Daniel Mack wrote:
>> Ok - can you play around with these commands and add them to the MIDI
>> driver? The stubs are all there now, and =A0I think all that's missing
>> is the termios call and maybe write_latency_timer(). I could prepare
>> another patch, but I think it's faster if you just try around which
>> command sequence helps :)
>
> I have tried to replicate the control messages to the best of my
> ability, but I'm still getting no MIDI events. The actual values in the
> stream may still be wrong (as per Clemens' email), so is there anywhere
> I can hook into to see if I get any USB activity *at all*?

Yes, you can check for received usb packets in  snd_usbmidi_in_urb_complete=
().
