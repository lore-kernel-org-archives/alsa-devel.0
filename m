From: James Stafford <jstafford@ampltd.com>
Subject: Re: [PATCH] Envy24HT
Date: Wed, 04 Dec 2002 12:54:54 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m18JZ72-003yUSC@mail.corpex.com>
References: <m18JGZc-003yTeC@mail.corpex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0212031858070.503-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

At 19:06 03/12/02 +0100, you wrote:

>I think that the default should be left in the AC97 code and write the 
>appropriate configuration after snd_ac97_mixer() call when you detect your 
>hardware and VT1616 codec.

I have added a build_controls function in the amp.c file which sets the
relavent ac97 register. Is this the correct way to do this?

>We send data in this order: channel0,1 = front; channel2,3 = rear; 
>channel4,5 = center/lfe ; if your hardware has swapped some stereo paths, 
>you need to swap channels in software - see 
>alsa-lib/src/conf/cards/ICH.conf - ICH.pcm.surround51.0 {} section
Once I have a conf file, what do I do with it and how do I use it? 

As a test, I added 

pcm.ice1724 {
	type plug
	ttable.0.0 1
	ttable.1.1 1
	ttable.2.4 1
	ttable.3.5 1
	ttable.4.2 1
	ttable.5.3 1
	slave.pcm {
		type hw
		card 0
		device 0
	}
}

to my ~/.asoundrc file.
The channels were then routed correctly when using the "ice1724" device.



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
