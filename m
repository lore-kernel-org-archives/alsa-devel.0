From: "Frank W. Miller" <fwmiller@cornfed.com>
Subject: Re: writing user program for alsa under fedora core
 1
Date: Mon, 31 May 2004 11:08:01 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40BB4A50.5010102@cornfed.com>
References: <40B92479.3080303@cornfed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40B92479.3080303@cornfed.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Frank W. Miller" <fwmiller@cornfed.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


With regard to my soundcard problems.  I actually have two cards in my 
system.  The first is an AC97 thing on an Intel motherboard, judging by 
this dmesg output I'd say its an Intel 8xx chip...

Intel 810 + AC97 Audio, version 0.24, 15:50:18 Oct 29 2003
PCI: Found IRQ 9 for device 00:1f.5
PCI: Sharing IRQ 9 with 00:1f.3
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH2 found at IO 0xef00 and 0xe800, MEM 0x0000 and 0x0000, IRQ 9
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: ADS96 (Analog Devices AD1885)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not 
present), total channels = 2
i810_audio: setting clocking to 41319
Creative EMU10K1 PCI Audio Driver, version 0.20, 15:51:24 Oct 29 2003
PCI: Found IRQ 11 for device 02:0a.0
emu10k1: EMU10K1 rev 8 model 0x8064 found, IO at 0xdf80-0xdf9f, IRQ 11
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
emu10k1: SBLive! 5.1 card detected
i810_audio: drain_dac, dma timeout?

The second is a SoundBlaster Live! card.  This is my default soundcard.  
When I have the CD Player running it uses the SBLive hardware and it 
sounds fine.  Now just for grins, heres the code snippet that I use for 
initializing the sound system in the softphone client program:

static int
soundcard_setup()
{
        int fmt, result;
                                                                                

        /* Set full-duplex operation */
        result = ioctl(fd, SNDCTL_DSP_SETDUPLEX, 0);
        if (result == 0) {
                log_msg(LOG_INFO, "full-duplex soundcard operation");
                full_duplex = 1;
                current_direction = SOUNDCARD_SET_NULL;
        } else
                log_msg(LOG_INFO, "half-duplex soundcard operation");
                                                                                

        /* Set buffer format */
        fmt = SOUNDCARD_BUFFER_FORMAT;
        result = ioctl(fd, SNDCTL_DSP_SETFRAGMENT, &fmt);
        if (result < 0) {
                log_msg(LOG_ERROR,
                        "set soundcard buffer format failed (%s)",
                        strerror(errno));
                return (-1);
        }
        /* Set for mono operation */
        fmt = 0;
        result = ioctl(fd, SNDCTL_DSP_STEREO, &fmt);
        if (result < 0) {
                log_msg(LOG_ERROR,
                        "set soundcard mono operation failed (%s)",
                        strerror(errno));
                return (-1);
        }
        /* Set signed 16-bit little-endian sample format */
        fmt = AFMT_S16_LE;
        result = ioctl(fd, SNDCTL_DSP_SETFMT, &fmt);
        if (result < 0) {
                log_msg(LOG_ERROR, "set soundcard format failed (%s)",
                        strerror(errno));
                return (-1);
        }
        /* Set sampling rate */
        fmt = SOUNDCARD_SAMPLING_RATE;
        result = ioctl(fd, SNDCTL_DSP_SPEED, &fmt);
        if (result < 0 || fmt != SOUNDCARD_SAMPLING_RATE) {
                log_msg(LOG_ERROR,
                        "set %d Hz soundcard sampling failed (%s)",
                        SOUNDCARD_SAMPLING_RATE, strerror(errno));
                return (-1);
        }
}

Obviously the important thing here for you guys are the ioctls.  The 
ones that don't seem to be working are the duplex call at the beginning 
and the sampling rate call at the end.  As I mentioned previously, this 
code worked great using OSS under Red Hat 9 on the same machine.  I've 
only run into problems after I reinstalled the operating system with 
Fedora Core 1.  I'd luv to hear your thoughts on this stuff.

Thanks,
FM



Frank W. Miller wrote:

>
> Greetings,
>
> I'm writing a softphone for Linux under Fedora Core 1.  I've had this 
> client working well using OSS under Red Hat 9 for awhile now.  I've 
> run into some problems however when trying to use the OSS calls under 
> Fedora.  I thought I would try to just write an ALSA driver and went 
> to the Programming docs.  Trouble is, they reference a header file 
> <alsa/asoundlib.h> and this file doesnt exist in my Fedora core 
> distro.  Do I need another RPM install or something?
>
> Thanks,
> FM
>
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 
> 10g. Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
