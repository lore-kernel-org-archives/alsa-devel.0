From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Question on PCM formats
Date: Thu, 19 Oct 2006 17:46:00 +0200
Message-ID: <1161272760.22900.273737044@webmail.messagingengine.com>
References: <B9FFC3F97441D04093A504CEA31B7C41E91E64@msilexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <B9FFC3F97441D04093A504CEA31B7C41E91E64@msilexch01.marvell.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Assaf Hoffman <hoffman@marvell.com>, alsa-devel@lists.sourceforge.net
Cc: Rita Shtern <rita@marvell.com>
List-Id: alsa-devel@alsa-project.org

(quoting fixed)

Assaf Hoffman wrote:
> Clemens Ladisch wrote:
> > Assaf Hoffman wrote:
> > > Q3: I'm working with kernel 2.6.12.6 and I could not find the
> > > snd_pcm_hw_params_get_sbits() function there. In which kernel version
> > > can I find it?
> > 
> > This function is part of ALSA's user space API.  It just returns the
> > value of the kernel's msbits field.
> 
> What is the msbits fields? How the kernel get that information?

This is a field that is stored as part of the hardware constraints.
To set it, call snd_pcm_hw_constraint_msbits() in the open callback.

> Can you point me to where I can get an ALSA user space code that will
> demonstrate how to use the snd_pcm_hw_params_get_sbits()?

I don't know of any program that bothers to read it.  If you would want
to read it, you would do it immediately after one sample format has
been selected, i.e., after the call to snd_pcm_hw_params().

> > > Q4: Working with 2.6.12.6 kernel, how can I solve the problem of the
> > > ICE1712? How do I tell the stack where is the sound sample bit start
> > > inside the 32-bit frame? 
> > 
> > When the number of valid bits (_get_sbits()) is not as large as the
> > number of bits of the sample format, the valid bits are always the most
> > significant bits.
> 
> isn't the "number of valid bits" and the "number of bits in sample"
> are the same thing?

The first is the number of bits that actually contain data, the second,
the number of bits of the sample _format_, describes how the bits in the
memory must be interpreted (together with physical width and endianness).

In the case of the ICE1712, the first is 24 while the second is 32.
(The samples can be interpreted as 32-bit samples because it's the least
significant bits that contain invalid/zero data.)

> > There are special sample formats for hardware that aligns its data in
> > the least significant bits of a word, e.g., S24_xE is for 24-bit samples
> > in the lower three bytes of a 32-bit word. 
> 
> What about x20_3xE format? Where the 20-bit sample is located
> in the 24-bit memory?

The sample bits that are part of the sample format name (in this case,
20) are always aligned to the least significant bit of the memory.

This is a special sample format because, unlike the ICE1712 case, you
couldn't just access the memory as 24-bit values.


HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
