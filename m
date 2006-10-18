From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [BULK] Re: CMIPCI driver. IEC958 user data and
 channel status
Date: Wed, 18 Oct 2006 17:34:29 +0200
Message-ID: <1161185669.16519.273641415@webmail.messagingengine.com>
References: <B9FFC3F97441D04093A504CEA31B7C41E91858@msilexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <B9FFC3F97441D04093A504CEA31B7C41E91858@msilexch01.marvell.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Assaf Hoffman <hoffman@marvell.com>
Cc: alsa-devel@lists.sourceforge.net, Rita Shtern <rita@marvell.com>
List-Id: alsa-devel@alsa-project.org

Assaf Hoffman wrote:
> 1) According to your experience, is it correct to assume that once a PCM
>    instance for playback/capture is prepared and triggered, the user data 
>    and channel status are constants during data transmit/receive?

Many drivers assume this for playback, i.e., they set these bits once when
the PCM stream is configured.

When capturing, these bits could change at any time, depending on the
source.  Most drivers allow to read the current values of these bits.

> 2) In the case HW saves the user data and channel status in its internal
>    registers, how would the ALSA stack know if any of them changed?

It wouldn't know at all, unless the hardware can issue an interrupt for
this situation.

There is a flag SNDRV_CTL_ELEM_ACCESS_VOLATILE for controls that can
change their value without notification.

> 3) Is there a bridge application in the ALSA stack? I mean, in case 
>    I would like to capture ICE958 frames and route them to ICE958 playback 
>    channel.

It would be possible to write an application that records and then plays
back the data, or to pipe the output of arecord into aplay.  ALSA
doesn't have any built-in functionality for that.


HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
