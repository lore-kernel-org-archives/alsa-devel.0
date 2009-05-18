From: Cameron Stone <camerons.lists@cse.unsw.edu.au>
Subject: Re: Support for USB-Audio devices with Multiple
	configurations?
Date: Mon, 18 May 2009 18:30:21 +1000
Message-ID: <4A111C9D.4010301@cse.unsw.edu.au>
References: <4A0BBAF4.6000108@cse.unsw.edu.au> <4A0D14BD.1050002@ladisch.de>
	<4A0D2CC7.7000408@cse.unsw.edu.au> <4A0DA47E.1070607@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tone.orchestra.cse.unsw.EDU.AU (tone.orchestra.cse.unsw.EDU.AU
	[129.94.242.59])
	by alsa0.perex.cz (Postfix) with ESMTP id E83CA1037F7
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 10:30:32 +0200 (CEST)
In-Reply-To: <4A0DA47E.1070607@ladisch.de>
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

Clemens Ladisch wrote:
> Cameron Stone wrote:
>> Is it possible to have alternate settings with different numbers of
>> channels?
> 
> Yes.  Each alternate setting has its own set of descriptors; you can
> change _any_ parameter in those descriptors.

Great, I've got this working now.

However, how do I ask arecord to use a particular alternate setting? I'd
like to have two alternate settings with the same number of channels,
but different microphones enabled. Is that possible? I'm using the
following command line (my USB mic array is card 1):

$ arecord -Dplughw:1,0 test.wav -d 1 -c 4 -r 30

I have two alternate settings with 4 channels, and arecord seems to
always choose the last one (the one with the highest alternate setting
number. This could also be the alsa driver making this choice.

amixer can display and control the different interfaces using the
second, but I can't find a command line option for arecord.

Thanks,	
	Cameron.

FYI arecord -L returns:

front:CARD=NVidia,DEV=0
    HDA NVidia, ALC662 Analog
    Front speakers
surround40:CARD=NVidia,DEV=0
    HDA NVidia, ALC662 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=NVidia,DEV=0
    HDA NVidia, ALC662 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=NVidia,DEV=0
    HDA NVidia, ALC662 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=NVidia,DEV=0
    HDA NVidia, ALC662 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=NVidia,DEV=0
    HDA NVidia, ALC662 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
null
    Discard all samples (playback) or generate zero samples (capture)
front:CARD=Adaptor,DEV=0
    8-Mic AVR Adaptor, USB Audio
    Front speakers
surround40:CARD=Adaptor,DEV=0
    8-Mic AVR Adaptor, USB Audio
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Adaptor,DEV=0
    8-Mic AVR Adaptor, USB Audio
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Adaptor,DEV=0
    8-Mic AVR Adaptor, USB Audio
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Adaptor,DEV=0
    8-Mic AVR Adaptor, USB Audio
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Adaptor,DEV=0
    8-Mic AVR Adaptor, USB Audio
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=Adaptor,DEV=0
    8-Mic AVR Adaptor, USB Audio
    IEC958 (S/PDIF) Digital Audio Output
