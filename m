From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Intel ICH programming & ALSA driver
Date: Wed, 08 Nov 2006 14:04:18 +0100
Message-ID: <1162991058.30297.275306179@webmail.messagingengine.com>
References: <200611072028.01872.witzel.thomas@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200611072028.01872.witzel.thomas@comcast.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: witzel.thomas@comcast.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thomas Witzel wrote:
> I'm not sure this really belongs here, but I have nowhere else to ask. I'm 
> writing an Intel ICH sound driver for Xenomai (real time Linux) and got stuck 
> with no sound. I'm not doing this for a common audio application but rather 
> in an attempt to generate an experimental setup with low-cost arbitrary 
> waveform function generators (which are the sound chips).
> Long story short, I learned as much as I could from looking at the ALSA driver 
> and the datasheet.

Did you read the PRM, too?

> I'm setting up the DMA buffers, I give the chip the Buffer Descriptor
> table and after I start the DMA I get a while later an interrupt that
> the LVI was reached and handle that.

The DMA engine seems to be running OK.

> I'm running the DMA on the PCM OUT I believe, but I get no sound. I
> set all mixer volume controls to max (and read them back to confirm)
> and make sure they are unmuted. Codec one is ready, AC97 power is up.

What codec are you using?  Many codecs must be configured to route the
sound to the correct output.

> On a different note, it seems that the ALSA driver is writing to the CIV 
> register, even though the Intel datasheet indicates this to be read-only.

It's only written to when initalizing the device.  I don't know why, but
it might be for one of the ICH (not-quite-)clones by other manufacturers.


HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
