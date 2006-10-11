From: "Assaf Hoffman" <hoffman@marvell.com>
Subject: Re: ALSA snd_xferi_t buffer arrangment
Date: Wed, 11 Oct 2006 17:40:49 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41E4E066@msilexch01.marvell.com>
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
Thank you for your reply.
I would be happy if you kindly reply to the following questions:
1) According to your experience, is it correct to assume that once a PCM

   instance for playback/capture is prepared and triggered, the user
data 
   and channel status are constants during data transmit/receive?
2) In the case HW saves the user data and channel status in its internal

   registers, how would the ALSA stack know of any of them changed?
3) Is there a bridge application in the ALSA stack (kerne)? I mean, in
case 
   I would like to capture ICE958 frames and route them to ICE958
playback 
   channel.

Thanks.

-----Original Message-----
From: James Courtier-Dutton [mailto:James@superbug.co.uk] 
Sent: Wednesday, October 11, 2006 5:01 PM
To: Assaf Hoffman
Cc: alsa-devel@lists.sourceforge.net; Rita Shtern
Subject: Re: [Alsa-devel] ALSA snd_xferi_t buffer arrangment

Assaf Hoffman wrote:
> Hi,
> Thanks again for clear answers.
> In case the HW strip the IEC958 frames, where the ALSA stack expect to
> find the various frame data fields such as perr, valid bit, audio
> sample, user data and channel status? Is there a data structure the HW
> should follow when DMAing the striped data to the DRAM buffer?
> What do you think of such acceleration? Does this saves a significant
> CPU time processing the ICE958 frames?
> Many thanks.
> P.S.
> I was looking into the ASLA stack and I could find
> SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_XX only in snd_pcm_hardware structure
> initialization. I could not see where it is used to tell the ALSA to
> process the data as IEC958 frames.
> 

A majority of sound cards strip the frame, and only put the audio
samples in the DMA buffer. The sound card then stores the valid bits,
non-audio bit, user data etc. in a separate register on the sound card.

The processing of the IEC958 frames is done in alsa-lib.
ALSA has two parts, and kernel part, and a user space lib.
The kernel part does as little as possible, with the user space part
doing all the format conversion etc.

I have not looked closely, but I don't know if the alsa-lib decodes the
IEC958 frames or not yet.

James




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
