From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: Re: hdsp problem
Date: Thu, 15 Jan 2004 21:30:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040115213042.5011ee58.TimBlechmann@gmx.net>
References: <20040113132353.1f672adb.TimBlechmann@gmx.net>
	<587e32ba984a0af957904d78b4624f66@essej.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <587e32ba984a0af957904d78b4624f66@essej.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jesse Chappell <jesse@essej.net>
Cc: alsa list <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net, linux-audio-user@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

> Paul Davis experienced this recently with his cardbus/digiface,
> with both 0.9.8 and 1.0.x.  He found that it only does this when
> the period size is >= 512.  At 256 and below, it works fine for
> him.   Give that a try.......
it's not working on my system (i tried 64, 128, 256) ... but playing
with the different settings, i figured out, that i can't change the
number of periods in the hardware buffer ... it's always 2 times the
number of frames per period ...
jack returns as error message:
ALSA: cannot set number of periods to 1 for capture 
ALSA: cannot configure playback channel
cannot load driver module alsa

is it possible that this is the problem? i don't understand how the
driver works but if the hardware buffer always gets one block instead of
two and plays it back the whole hardware buffer the samples would be
late ...
on the other hand the distortion i hear is not related to the block
size... (btw, i tried to record a sound ... that works fine ...)

nearly giving up the hope ...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
