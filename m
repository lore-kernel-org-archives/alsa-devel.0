From: "Geoff Beasley" <songshop@bizmedia.com.au>
Subject: Multi device for 2 C-Ports... More help needed
Date: Mon, 2 May 2005 13:06:46 +1000
Message-ID: <20050502030713.6801471A28@mail.netspace.net.au>
References: <Pine.HPX.4.33n.0504251306330.2934-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="windows-1250"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0504251306330.2934-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Clemens Ladisch' <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks for the help so far. I've done that but when I start up jack it works
for about 5 - 10 seconds then says the jack watchdog times out and stops the
server. During the few seconds it is working I checked in the connections
tab and there are only 2 ins and 2 outs. Do I need to make any alterations
to the file?

Here is the file I have currently:

pcm.cport_a {
	type hw
	card 0       # change the card numbers as appropriate
	device 0
}
pcm.cport_b {
	type hw
	card 1
	device 0
}

pcm.playback20 {
	type multi
	slaves.a { pcm cport_a channels 10 }
	slaves.b { pcm cport_b channels 10 }
	bindings [
		{ slave a channel 0 }
		{ slave a channel 1 }
		{ slave a channel 2 }
		{ slave a channel 3 }
		{ slave a channel 4 }
		{ slave a channel 5 }
		{ slave a channel 6 }
		{ slave a channel 7 }
		{ slave a channel 8 }
		{ slave a channel 9 }
		{ slave b channel 0 }
		{ slave b channel 1 }
		{ slave b channel 2 }
		{ slave b channel 3 }
		{ slave b channel 4 }
		{ slave b channel 5 }
		{ slave b channel 6 }
		{ slave b channel 7 }
		{ slave b channel 8 }
		{ slave b channel 9 }
	]
}

pcm.capture24 {
	type multi
	slaves.a { pcm cport_a channels 12 }
	slaves.b { pcm cport_b channels 12 }
	bindings [
		{ slave a channel 0 }
		{ slave a channel 1 }
		{ slave a channel 2 }
		{ slave a channel 3 }
		{ slave a channel 4 }
		{ slave a channel 5 }
		{ slave a channel 6 }
		{ slave a channel 7 }
		{ slave a channel 8 }
		{ slave a channel 9 }
		{ slave a channel 10 }
		{ slave a channel 11 }
		{ slave b channel 0 }
		{ slave b channel 1 }
		{ slave b channel 2 }
		{ slave b channel 3 }
		{ slave b channel 4 }
		{ slave b channel 5 }
		{ slave b channel 6 }
		{ slave b channel 7 }
		{ slave b channel 8 }
		{ slave b channel 9 }
		{ slave b channel 10 }
		{ slave b channel 11 }
	]
}

pcm.both {
	type plug
	slave.pcm {
		type asym
		playback.pcm playback20
		capture.pcm capture24
	}
}

Cheers,
Geoff.
 

-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.308 / Virus Database: 266.11.0 - Release Date: 4/29/2005
 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
