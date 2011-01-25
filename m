From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Should "Master" control the "Line In" volume
	(loopback)
Date: Tue, 25 Jan 2011 10:32:59 +0800
Message-ID: <AANLkTik1xUCsy5Fh_pC++c-jwHzsVtV_WKDGehQBOdWx@mail.gmail.com>
References: <ihhp04$h9d$1@dough.gmane.org>
	<s5h39oi8mf9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A970A103848
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 03:33:02 +0100 (CET)
Received: by ewy19 with SMTP id 19so2239401ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 18:33:01 -0800 (PST)
In-Reply-To: <s5h39oi8mf9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/1/24 Takashi Iwai <tiwai@suse.de>

> At Sun, 23 Jan 2011 17:37:07 +0000,
> Colin Guthrie wrote:
> >
> > Hi,
> >
> > I have a question-by-proxy from a user who is confused because his
> > "Master" kcontrol is affecting the volume via Line In (which he uses to
> > loopback an analog signal to his speakers).
> >
> > I've not got much hardware here for comparison, but I'm pretty sure that
> > Master usually doesn't affect Line In.
> >
> > So couple of questions:
> >  1. Is it typical that Master affects Line In?
>
> Yes, but only for the loopback volume.  It's independent from the
> line-in capture volume.
>
>

>> ALSA info here: https://bzattachment.mandriva.com/attachment.cgi?id=18170

>> (for reference the full bug is here:
>> https://qa.mandriva.com/show_bug.cgi?id=62218<https://qa.mandriva.com/show_bug.cgi?id=62218>
)

>> (1) KDE kmix is now pulseaudio aware and as such, kmix does not show the
>> individual channels in the mixer
>> I have my Sirrus/XM satellite radio plugged into LINE-IN and I listen to
it
>> while using the computer.

"virtual master" already have "Front" and "Headphone" as slaves

if the user want to hear the satelite radio from LINE_IN

Why Kmix does not control those  "Mic Playback" and "Line Playback" any more
?


The max dB of Line and Mic playback volume are +12dB while those slave
volume controls are only +3dB


	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 63'
		comment.dbmin -9150
		comment.dbmax 300
		iface MIXER
		name 'Front Playback Volume'
		value.0 61
		value.1 61
	}

 control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 63'
		comment.dbmin -9150
		comment.dbmax 300
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 61
		value.1 61
	}


	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Line Playback Volume'
		value.0 28
		value.1 28
	}



http://www.analog.com/en/audiovideo-products/audio-codecs/ad1983/products/product.html
