From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: problem linking pcm timer to midi timer at SB
	Audigy
Date: Fri, 25 Aug 2006 17:34:38 +0200
Message-ID: <1156520078.7520.269417316@webmail.messagingengine.com>
References: <44EF14F5.5000304@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <44EF14F5.5000304@gmx.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Gerald Grabner <gerald.grabner@gmx.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Gerald Grabner wrote:
> I'm having troubles with linking the pcm timer to the midi timer for a
> SB Audigy. I slightly adapted the code of Steve deRosier
> [http://thread.gmane.org/gmane.linux.alsa.devel/22156/focus=22160], my
> function is listed below. While it works with an ES1938 card, it
> doesn't with a SB Audigy: If I'm trying to record audio (generated
> from a midi signal I'm sending from the same card), I only hear the
> first note sent. Obviously the timing is completely wrong. The problem
> doesn't occur for pcm playback.

Look into /proc/asound/seq/queues and /proc/asound/seq/timers to see
what's going on.

> Unfortunatly, I didn't find much documentation about cards, devices
> and subdevices.
> Do I have to choose a particular one for the Audigy?

Yes.  See "arecord -l" for a list of recording devices.  You have to
choose the same device that you're using for recording.

> Why the "SDevice = SDevice << 1;" statement?

The subdevice number of the timer is not the same as the PCM subdevice
number, see /proc/asound/timers.

> Where can I find documentation on this topic?

This stuff is basically undocumented.


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
