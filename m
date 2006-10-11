From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: ALSA snd_xferi_t buffer arrangment
Date: Wed, 11 Oct 2006 15:22:56 +0100
Message-ID: <452CFE40.2020705@superbug.co.uk>
References: <B9FFC3F97441D04093A504CEA31B7C41E4E01C@msilexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <B9FFC3F97441D04093A504CEA31B7C41E4E01C@msilexch01.marvell.com>
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
Cc: Rita Shtern <rita@marvell.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Assaf Hoffman wrote:
> Thank you for your reply.
> Please let me clarify. What you say is that my device can deliver a raw
> ICE958 data from the capture channel to the DMA buffer and the ALSA
> stack will know how to deal with it? No need for the device to strip
> down the payload and only then transfer it to the DMA buffer?
> In case the sound card can strip down the IEC958 frames into raw sound
> data + ch status + user data, how would the ALSA stack expect the data?
> Is there an API for that?
> Thanks again.
> 

If you don't strip the IEC958 frames, tell ALSA the format is:
SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE
SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE
If you do strip the IEC958 frames, tell ALSA the format is:
SNDRV_PCM_FMTBIT_S24_LE or
SNDRV_PCM_FMTBIT_S16_LE

Or whatever format your hardware decides to send.

The API for this is contained in the following structure in the sound
driver:
This example is from the snd-emu10k1 driver.

static struct snd_pcm_hardware snd_emu10k1_capture =
{
        .info =                 (SNDRV_PCM_INFO_MMAP |
SNDRV_PCM_INFO_INTERLEAVED |
                                 SNDRV_PCM_INFO_BLOCK_TRANSFER |
                                 SNDRV_PCM_INFO_RESUME |
                                 SNDRV_PCM_INFO_MMAP_VALID),
        .formats =              SNDRV_PCM_FMTBIT_S16_LE,
        .rates =                SNDRV_PCM_RATE_8000_48000,
        .rate_min =             8000,
        .rate_max =             48000,
        .channels_min =         1,
        .channels_max =         2,
        .buffer_bytes_max =     (64*1024),
        .period_bytes_min =     384,
        .period_bytes_max =     (64*1024),
        .periods_min =          2,
        .periods_max =          2,
        .fifo_size =            0,
};


As you can see, it tells use that this device can do only
SNDRV_PCM_FMTBIT_S16_LE format.

James


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
