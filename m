From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: Tascam US-224 support: MIDI OK, Audio KO?
Date: Tue, 30 Mar 2004 22:19:09 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32797.192.168.1.5.1080681549.squirrel@www.rncbc.org>
References: <44618.195.245.190.94.1080560065.squirrel@www.rncbc.org>
    <200403292129.04497.annabellesgarden@yahoo.de>
    <32817.192.168.1.5.1080596468.squirrel@www.rncbc.org>
    <200403300157.51963.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200403300157.51963.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Karsten,
>
> Concerning us224's Lights I'm currently left in the dark....
> For us428 I found that a 7Byte long USB-Message on pipe 4 is a Lights
> set command, while a 5Byte long is an internal mixer set command.
> You could tweak us428control to toggle the 0'th light instead of the
> 25'th light, which is InputMonitor Light on us428. the 0th light is
> Select Channel 1 on the us428.
> Exchange Cus428State.cc Line 118 , 119
> 				Light[0].Value = StateInputMonitor() ? SelectInputMonitor : Select;
> 				Light[2].Value = StateInputMonitor() ? MuteInputMonitor : Mute;
> for
> 				Light[0].Value = 0x55;
> 				Light[2].Value = 0xAA;
> to check light mechanics.
>

Made this tweak, and nothing changed. LEDs remain dark.


> If there's still no lights, some usb snooping on windoz might help.
> I've some specially tuned stuff here which I could send you then.
>

Let's go deep :)
--
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
