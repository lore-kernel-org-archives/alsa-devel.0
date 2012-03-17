From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Internal speaker output from Sony Vaio Z (2010
 model) lost somewhere between 3.1.0 and 3.2.6
Date: Sat, 17 Mar 2012 10:40:46 +0800
Message-ID: <CAN8cciafudunXn-=DZaJHKQ5bBsLUhp2EGmsH+mYJW38QqJxWQ@mail.gmail.com>
References: <1331939409.22414.29.camel@adam>
	<CAN8ccibZfNEd05FDwcb2XENaW7VFkkun2GFJ2xxGmLyKgzdw-g@mail.gmail.com>
	<1331950527.1841.1.camel@adam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 0002324570
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 03:40:46 +0100 (CET)
Received: by wibhm17 with SMTP id hm17so1508870wib.2
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 19:40:46 -0700 (PDT)
In-Reply-To: <1331950527.1841.1.camel@adam>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Williamson <awilliam@redhat.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/3/17, Adam Williamson <awilliam@redhat.com>:
> On Sat, 2012-03-17 at 10:04 +0800, Raymond Yau wrote:
>> 2012/3/17, Adam Williamson <awilliam@redhat.com>:
>> > Welp, pretty much as the topic says.
>> >
>> > I just noticed today that sound is no longer playing from the internal
>> > speakers of my laptop, a 2010 model Sony Vaio Z. Plugging in headphones
>> > causes sound to be played fine through those. There are three possible
>> > choices for 'Connector' - 'Analog Speakers', 'Analog Output', and
>> > 'Analog Headphones' - but none of these seems to make sound come out of
>> > the internal speakers. The default is 'Analog Speakers', and when it's
>> > set to this, headphone output does work when headphones are plugged in.
>> >
>> > I've verified that it's broken on Fedora 16 kernels 3.2.6-4, 3.2.8-3 and
>> > 3.2.10-1. It's also broken in a very recent Fedora 17 kernel, 3.3.0rc6
>> > or so. It works on a Fedora 16 live image, with kernel 3.1.0-1.
>> > Unfortunately the kernels before 3.2.6 have been trashed from Fedora's
>> > buildsystem archives, I think, so it's hard to narrow things down any
>> > further :/
>> >
>> > the alsa-info output is
>> > http://www.alsa-project.org/db/?f=368e2359757b537d4daa0f5399830d3942540196
>> > .
>> >
>>
>> it is a bug if sound preference allow user to select speaker when
>> auto-mute mode is enabled (the speaker is automatically muted by the
>> driver when you plug the headphone)
>
> Then I guess that's another bug :) Because yes, the laptop does
> auto-mute by default. When the speakers are actually working, if I plug
> in headphones, the speakers get muted and the headphones work. No need
> to manually select an output.

http://www.intel.com/support/motherboards/desktop/sb/cs-020642.htm#multistream

AFAIK, multistreaming is not yet implemented for desktop using realtek codecs

The ALC889 provides ten DAC channels that simultaneously support 7.1
sound playback, plus 2 channels of independent stereo sound output
(multiple streaming) through the front panel stereo outputs.
