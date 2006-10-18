From: "Assaf Hoffman" <hoffman@marvell.com>
Subject: Re: ALSA PCM  data format
Date: Wed, 18 Oct 2006 17:17:01 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41E91C7D@msilexch01.marvell.com>
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
Where can I find the code for alsa-lib IEC958 plugin?
Thanks.

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Wednesday, October 18, 2006 1:34 PM
To: Assaf Hoffman
Cc: alsa-devel@lists.sourceforge.net; Rita Shtern
Subject: Re: [Alsa-devel] ALSA PCM data format
Importance: Low

At Wed, 18 Oct 2006 09:33:23 +0200,
Assaf Hoffman wrote:
> 
> Hi,
> I'm new to ALSA and I would be happy if anyone can explain the format
of
> the data the ALSA stack is expecting to find in its buffer.  
> For example, if I support IEC958 frames that contains 20bit PMC sample
> in each sub-frame payload, (total of 40 bits per frame), the HW, which
> is capable of striping down the sound sample will DMA to the buffer 40
> bits of sound sample. The following frame containing the next 40bits
> will be placed right after the last 40 bits, creating a total of 80
bits
> in the DMA buffer.
> Is that correct?

If the hardware supports the raw SPDIF frames, then yes, you can pass
the data embedded in IEC958 subframes, including preamble, channel
status and parity bits.  More exactly, it consists of:

 bit 0-3  = preamble
     4-7  = AUX (=0)
     8-27 = data (12-27 for 16bit, 8-27 for 20bit, and 24bit without
AUX)
     28   = validity (0 for valid data, else 'in error')
     29   = user data (0)
     30   = channel status (24 bytes for 192 frames)
     31   = parity

But, this is optional.  The alsa-lib plugin does this conversion if
necessary.

If the hardware doesn't support the raw SPDIF frames, you pass only
the PCM data and set up IEC958 status bits externally.  Usually it's
packed in either 2-byte, 3-byte or 4-byte samples formats.


Takashi

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
