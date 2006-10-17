From: "Assaf Hoffman" <hoffman@marvell.com>
Subject: Re: [BULK] Re: CMIPCI driver. IEC958 user data and
	channel status
Date: Tue, 17 Oct 2006 13:16:57 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41E91858@msilexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Rita Shtern <rita@marvell.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
Thank you for your answer.
I would be happy if you could address the following correlated
questions:
1) According to your experience, is it correct to assume that once a PCM

   instance for playback/capture is prepared and triggered, the user
data 
   and channel status are constants during data transmit/receive?
2) In the case HW saves the user data and channel status in its internal

   registers, how would the ALSA stack know if any of them changed?
3) Is there a bridge application in the ALSA stack? I mean, in case 
   I would like to capture ICE958 frames and route them to ICE958
playback 
   channel.

Thanks.

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Tuesday, October 17, 2006 12:58 PM
To: Assaf Hoffman
Cc: alsa-devel@lists.sourceforge.net; Rita Shtern
Subject: [BULK] Re: [Alsa-devel] CMIPCI driver. IEC958 user data and
channel status
Importance: Low

At Mon, 16 Oct 2006 13:41:02 +0200,
Assaf Hoffman wrote:
> 
> Hi,
> As I understand, the IEC958 frame incorporates not only sound sample
but
> also other information such as user data and channel status.
> I could not locate in the CMIPCI driver where the user data or channel
> status is read/write from/to the device and where is it kept on DRAM.

This depends on the chip model.  With the earlier chip, you have to
use 32bit SPDIF "raw" data including SPDIF status bits and data.
The soft_ac3 corresponding to this.  In the ALSA framework, alsa-lib
encodes/decodes the SPDIF raw data.

The recent version of chip has some register bits to indicate the
non-audio data.  The driver sets them up accordingly.
Then the 16bit data is handled as is without modification.


Takashi

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
