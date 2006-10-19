From: "Assaf Hoffman" <hoffman@marvell.com>
Subject: Re: Question on PCM formats
Date: Thu, 19 Oct 2006 11:40:42 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41E91E64@msilexch01.marvell.com>
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
To: Clemens Ladisch <cladisch@fastmail.net>, alsa-devel@lists.sourceforge.net
Cc: Rita Shtern <rita@marvell.com>
List-Id: alsa-devel@alsa-project.org

Hi,
Many thanks for your answer.
Please see my comments below.
Thanks.

-----Original Message-----
From: Clemens Ladisch [mailto:cladisch@fastmail.net] 
Sent: Thursday, October 19, 2006 10:55 AM
To: Assaf Hoffman; alsa-devel@lists.sourceforge.net
Cc: Rita Shtern
Subject: Re: [Alsa-devel] Question on PCM formats

Assaf Hoffman wrote:
> I was looking in
http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html
> and I have some questions regarding the PCM format paragraph:
> 
> Q1: I think the sentence:
> "...but the sample is stored in low three bits."
> Should be
> "...but the sample is stored in low three bytes."

Yes, thanks.

> Q2: What is the meaning of "full range" in the sentence:
> "Some hardware does not support processing of full range"?

In that case, "full range" is the size of the samples as specified
by the sample format (in the example, 32 bits).

[Assaf]: If you could give some examples there it would be great.

> Q3: I'm working with kernel 2.6.12.6 and I could not find the
> snd_pcm_hw_params_get_sbits() function there. In which kernel version
> can I find it?

This function is part of ALSA's user space API.  It just returns the
value of the kernel's msbits field.

[Assaf]: What is the msbits fields? How the kernel get that information?
Can you point me to where I can get an ALSA user space code that will
demonstrate how to use the snd_pcm_hw_params_get_sbits()?

> Q4: Working with 2.6.12.6 kernel, how can I solve the problem of the
> ICE1712? How do I tell the stack where is the sound sample bit start
> inside the 32-bit frame? 

When the number of valid bits (_get_sbits()) is not as large as the
number of bits of the sample format, the valid bits are always the most
significant bits.  This means that applications can just ignore the
_get_sbits() function and pretend that the ICE1712 uses 32-bit samples.

[Assaf]: Regarding the first sentence in the above paragraph, isn't the
"number of valid bits" and the "number of bits in sample" are the same
thing? Can you elaborate? 

There are special sample formats for hardware that aligns its data in
the least significant bits of a word, e.g., S24_xE is for 24-bit samples
in the lower three bytes of a 32-bit word. 

[Assaf]: What about x20_3xE format? Where the 20-bit sample is located
in the 24-bit memory?

HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
