From: "Assaf Hoffman" <hoffman@marvell.com>
Subject: Re: ALSA snd_xferi_t buffer arrangment
Date: Wed, 18 Oct 2006 08:31:56 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41E91A69@msilexch01.marvell.com>
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
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Rita Shtern <rita@marvell.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
The ALSA PCM supported formats are located in pcm.h file. 
Where can I find the specification (bit fields) of those PCM formats?
Many thanks.


-----Original Message-----
From: James Courtier-Dutton [mailto:James@superbug.co.uk] 
Sent: Wednesday, October 11, 2006 3:54 PM
To: Assaf Hoffman
Cc: alsa-devel@lists.sourceforge.net; Rita Shtern
Subject: Re: [Alsa-devel] ALSA snd_xferi_t buffer arrangment

Assaf Hoffman wrote:
> Hi,
> 
> I'm mew to sound and ALSA.
> 
> My project deals with PCM in standard (I2S) mode and IEC958 (SPDIF)
> mode. 
> 
> Can anyone tell me how the ALSA stack expects to "see" the data
received
> form the sound device? I mean, what is the format of the data DMA'ed
> from the sound device to DRAM that the ALSA stack expects? 
> 
> Is this raw sound data? SPDIF frame includes non sound data as well.
> Does the sound card HW strip the sound payload from the IEC958 frame
to
> deliver the raw sound data to the ALSA buffer? 
> 
> Please shed some light...
> 
> Many thanks. 
> 
>  

ALSA can deal with all the different formats that the sound device might
deliver. The low level sound driver simply tells the upper layers what
formats are available. ALSA then handles those formats and all format
conversion required to reach the user space application.
It depends what your device does as to which format ALSA will see.

James





-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
