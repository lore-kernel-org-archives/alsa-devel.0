From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: Re: Non-functional Altec Lansing FX5051 USB-soundcard
 +	speakers
Date: Mon, 10 Nov 2008 11:45:03 +0100
Message-ID: <491810AF.7020804@powercraft.nl>
References: <20081110040933.GA29870@katran.rifetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node01.cambriumhosting.nl (node01.cambriumhosting.nl
	[217.19.16.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 076741037F2
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 11:45:12 +0100 (CET)
In-Reply-To: <20081110040933.GA29870@katran.rifetech.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jeremy Nickurak <alsa-devel@atrus.rifetech.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jeremy Nickurak wrote:
> About 14 months ago I purchased a nice new ~$300 set of altec lansing 
> 5.1 speakers, which include a USB-sound card. Since that time they've 
> largely gone unused, or at least not properly used. I brought this up on 
> the mailing list at the time, but didn't get much response, so I thought 
> I'd poke my head up again and see if anybody has any insight.
> 
> First off, the set works correctly, out-of-the-box under windows, 
> without having to install any special drivers or software at all.
> 
> Under linux, plugging them in instantly freezes the usb sound card up, 
> and locks it at 100% volume, in such a way that there's absolutely no 
> way to turn the volume down: not from alsamixer, and not from the 
> speaker's hardware control dial. Sound does play, but again, it's 
> unbearably loud, to the point where I don't do it for risk of damaging 
> my speakers and/or ears.
> 
> I filed the bug away on the bug-tracker, but haven't heard much out of 
> it since. The bug contains my lsusb -v information, the "contents" 
> output from amixer for this card, and some preliminary results showing 
> some ability to tweak the volume with amixer, but not reliably.
> 
> Any suggestions are welcome. I'm happy to experiment with this set more 
> if it can help, run experimental code, etc. Heck, I'd go at the thing 
> with a screwdriver for chipset information if I know what I was looking 
> for or thought it could help.

I also have some volume issues with some of my usb audio devices, it
might be related tot the dB0 scaling issues that where discussed on the
list. There may be a good usable workaround for you, that will be a
software volume control.

change all the zeros to your hardware id and set the correct user

echo 'pcm.softvol {
    type softvol
    slave.pcm dmix:0
    control.name Master
    control.card 0
}

pcm.!default {
    type plug
    slave.pcm softvol
}

ctl.!default {
    type hw
    card 0
}' | tee /home/user0/.asoundrc
chmod 600 /home/user0/.asoundrc
chown user0:user0 /home/user0/.asoundrc

Best regards,

Jelle
