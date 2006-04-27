From: Brad Midgley <bmidgley@xmission.com>
Subject: Re: bluetooth plugin "jittery" and "sticky"
Date: Thu, 27 Apr 2006 08:20:03 -0600
Message-ID: <4450D313.7020501@xmission.com>
References: <444F38BB.4020702@xmission.com> <s5hpsj3xplt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpsj3xplt.wl%tiwai@suse.de>
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

Takashi

>> We finally got around to working on the stereo (a2dp) bluetooth alsa
>> plugin. It's mostly working in the cvs version of the project "btsco" at
>> http://bluetooth-alsa.sf.net.
> 
> Hm, it's a bit too ambiguous to say something.  Could you elaborate
> what do you mean xmms jitters?  The time springs or just the audio
> matters?

The time display in xmms goes back and forth between two values. It
counts like 02,01,02,01,02,03,02,03,02,03 so it does actually go
forward. The audio sounds fine. It's just the display doesn't look right
and xmms locks up at the end of a song.

I think it's in our .transfer callback, a2dp_transfer. I had two
versions contributed. The other version, a2dp_transfer2, randomly locks
up xmms but when it works, the time display looks ok and xmms can switch
between songs without problems.

We have to enforce timing of packets sent to the headset in the
.transfer cb. Is there a plugin out there I can look at that also has to
deal with timing? We're not sure how to best enforce it... see
http://bluetooth-alsa.sf.net/pcm_a2dp.c

Brad


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
