From: Thomas Witzel <witzel.thomas@comcast.net>
Subject: Intel ICH programming & ALSA driver
Date: Tue, 7 Nov 2006 20:28:01 -0500
Message-ID: <200611072028.01872.witzel.thomas@comcast.net>
Reply-To: witzel.thomas@comcast.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I'm not sure this really belongs here, but I have nowhere else to ask. I'm 
writing an Intel ICH sound driver for Xenomai (real time Linux) and got stuck 
with no sound. I'm not doing this for a common audio application but rather 
in an attempt to generate an experimental setup with low-cost arbitrary 
waveform function generators (which are the sound chips).
Long story short, I learned as much as I could from looking at the ALSA driver 
and the datasheet. I'm setting up the DMA buffers, I give the chip the Buffer 
Descriptor table and after I start the DMA I get a while later an interrupt 
that the LVI was reached and handle that. I'm running the DMA on the PCM OUT 
I believe, but I get no sound. I set all mixer volume controls to max (and 
read them back to confirm) and make sure they are unmuted. Codec one is 
ready, AC97 power is up. Everything looks fine.
So now I'm wondering what I'm doing wrong. I filled the buffers for the sound 
with random values, which might be wrong, but I was hoping to get some 
crackling or noise at least.

On a different note, it seems that the ALSA driver is writing to the CIV 
register, even though the Intel datasheet indicates this to be read-only.

Thank you for any useful hints in advance,
Thomas

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
