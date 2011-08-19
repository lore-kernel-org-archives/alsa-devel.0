From: Daniel Mack <zonque@gmail.com>
Subject: Re: TASCAM US-122mkII
Date: Fri, 19 Aug 2011 13:46:00 +0200
Message-ID: <CACTFLAPnWpq7AQ3KZakqkLRV7CtgDG-fXM77T9NLK5o90hfxzA@mail.gmail.com>
References: <20110819100156.GA31665@yumi>
	<CACTFLANmONgmCtPKFpofJGQ72a5BSbZHkj5+e=yGfDrynDPrQA@mail.gmail.com>
	<20110819113727.GA9522@yumi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id 670712465B
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 13:46:01 +0200 (CEST)
Received: by pzk1 with SMTP id 1so5035474pzk.2
	for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2011 04:46:00 -0700 (PDT)
In-Reply-To: <20110819113727.GA9522@yumi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cyril Hrubis <metan.lists@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 19, 2011 at 1:37 PM, Cyril Hrubis <metan.lists@gmail.com> wrote:
> Hi!
>> > The good news is that I have 122mkII to play with, the bad news is that
>> > it doesn't work with the snd_usb_122l driver.
>>
>> IIRC, the 122mkII implements an entirely different USB protocol
>> compared to its former version. Can you send your "lsusb -v" output?
>
> Attached.

Ok, nothing that even remotely looks like class compliant descriptors.

> As far as I understand it, there are two endpoints for audio and two for
> MIDI. The MIDI part seems to be initalized fine although I don't have
> any MIDI device to test it.
>
> And in the log from windows machine the audio part does some
> intialization and then only buch of isochronous transfers.

Hmm, so it seems that our only option is really to look at these
Windows dumps and reverse-engineer the protocol.



Daniel
