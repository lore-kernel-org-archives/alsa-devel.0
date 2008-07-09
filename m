From: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: FWIW: is this right
Date: Wed, 9 Jul 2008 16:59:35 +0000
Message-ID: <dd18b0c30807090959u121b0d7oc1e58312723e915b@mail.gmail.com>
References: <dd18b0c30807081218t30d33614yf79509ceb07502e6@mail.gmail.com>
	<s5hd4lnymgs.wl%tiwai@suse.de> <20080709143101.GJ7132@sci.fi>
	<s5hy74ayjl7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FBD724408
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jul 2008 18:59:37 +0200 (CEST)
Received: by hs-out-0708.google.com with SMTP id x43so712790hsb.0
	for <alsa-devel@alsa-project.org>; Wed, 09 Jul 2008 09:59:36 -0700 (PDT)
In-Reply-To: <s5hy74ayjl7.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 9, 2008 at 6:54 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 9 Jul 2008 17:31:01 +0300,
> Ville Syrj=E4l=E4 wrote:
>>
>> On Wed, Jul 09, 2008 at 07:52:03PM +0200, Takashi Iwai wrote:
>> > At Tue, 8 Jul 2008 19:18:21 +0000,
>> > Justin Mattock wrote:
>> > >
>> > > Hello; FWIW I think this is the right area for this question:
>> > > basically I have a bug filed:http://bugzilla.kernel.org/show_bug.cgi=
?id=3D10954
>> > > and am trying to fix it or find a work around.
>> > > what I'm seeing in dmesg is:
>> > > hda_intel: azx_get_response timeout, switching to polling mode: last
>> > > cmd=3D0x010f1c00
>> > > I can't seem to reproduce this issue, only seems to appear every 100=
  +/- boots.
>> > > any ideas.(attached is dmesg of the bug).
>> > > regards;
>> >
>> > This is no fatal error and you can mostly ignore it...
>>
>> It is fatal at least in my case. PCM playback doesn't work after getting
>> the error until you close all applications using the device.
>
> It alone can't be a fatal error.  Either you must have more error
> messages or a different error is hidden behind.
>
>
> Takashi
>

This is interesting after removing:options snd-hda-intel position_fix=3D1
from /etc/modprobe.d/alsa-base I have not seen this after recompiling
my kernel loads of times
keep in mind I'm using a macbook pro: the above option was used to
help with the crackling
noise in the headphones. I'm going to watch this and see if I see this
message appears.
regards;


-- =

Justin P. Mattock
