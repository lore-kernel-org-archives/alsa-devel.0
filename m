From: Josh Green <josh@resonance.org>
Subject: Re: Intel Azalia problems (some progress)
Date: Fri, 15 Apr 2005 05:12:59 -0700
Message-ID: <1113567180.7140.17.camel@SillyPuddy.localdomain>
References: <1113394027.16526.3.camel@SillyPuddy.localdomain>
	 <s5hll7mg30n.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hll7mg30n.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I finally got headphone output with my Azalia sound interface.  I ended
up trying all the models listed in the patch_realtek.c file until
finally "model=w810" worked and I now get headphone output.

Useful info from lspci:

lspci
0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)

lspci -n
0000:00:1b.0 Class 0403: 8086:2668 (rev 04)


I imagine this probably isn't exactly the right model.  The "Surround"
control affects the headphone volume but not the "Front" output (it
seems there is no volume level for the "Headphone" control for the w810
model).  The "Front" volume works as expected (internal speakers).  I
have not tested it any more than that.

Still clicking in output, seemingly even with 48KHz audio, still
investigating.  Also many programs lock up at the end of the audio
output (like Rhythmbox when a song is finished for instance).

I'd like to look into getting proper support for this configuration, any
tips on what kind of info to try and obtain?  Cheers!
	Josh Green




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
