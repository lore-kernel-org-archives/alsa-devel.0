From: "Stefano D'Angelo" <zanga.mail@gmail.com>
Subject: Re: Line6 Toneport UX1 driver again
Date: Wed, 12 Jul 2006 12:29:26 +0200
Message-ID: <160c13350607120329k5c5f6dfby34e965e8130ac2a2@mail.gmail.com>
References: <160c13350607110559v28640db3x7abc13946b58adca@mail.gmail.com>
	<s5hveq45llx.wl%tiwai@suse.de>
	<160c13350607110815v4cf22dafg1485709d21dba49b@mail.gmail.com>
	<20060712094318.GB22449@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0769910825=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060712094318.GB22449@turing.informatik.uni-halle.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--===============0769910825==
Content-Type: multipart/alternative;
	boundary="----=_Part_1393_25883534.1152700166112"

------=_Part_1393_25883534.1152700166112
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2006/7/12, Clemens Ladisch <clemens@ladisch.de>:
> Stefano D'Angelo wrote:
> > But maybe there's another solution to the problem: since this card has
just
> > some differences at initialization and playback start with normal USB
cards,
> > maybe usb-snd-audio could be used.
>
> This would be preferrable.
>
> What are the differences?
>
>
> Regards,
> Clemens

Well, I'm already working on it. Yesterday night I starting modifying
snd-usb-audio (and I have to admit that it is a great piece of code) and
what I did is adding the quirk in usbquirks.h this way:

/* Line6 TonePort devices */
{
    USB_DEVICE(0x0e41, 0x4141),
    .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
        .vendor_name = "Line6",
        .product_name = "TonePort UX1",
        .ifnum = QUIRK_ANY_INTERFACE,
        .type = QUIRK_COMPOSITE,
        .data = & (const struct snd_usb_audio_quirk[]) {
            {
                .ifnum = 0,
                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                .data = & (const struct audioformat) {
                    .format = SNDRV_PCM_FORMAT_S16_LE,
                    .channels = 2,
                    .iface = 0,
                    .altsetting = 1,
                    .altset_idx = 1,
                    .attributes = 0,
                    .endpoint = 0x01,
                    .ep_attr = 0x01,
                    .rates = SNDRV_PCM_RATE_48000,
                    .rate_min = 48000,
                    .rate_max = 48000
                }
            },
            {
                .ifnum = 0,
                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                .data = & (const struct audioformat) {
                    .format = SNDRV_PCM_FORMAT_S16_LE,
                    .channels = 2,
                    .iface = 0,
                    .altsetting = 2,
                    .altset_idx = 2,
                    .attributes = 0,
                    .endpoint = 0x01,
                    .ep_attr = 0x01,
                    .rates = SNDRV_PCM_RATE_44100,
                    .rate_min = 44100,
                    .rate_max = 44100
                }
            },
            {
                .ifnum = 0,
                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                .data = & (const struct audioformat) {
                    .format = SNDRV_PCM_FORMAT_S24_3LE,
                    .channels = 2,
                    .iface = 0,
                    .altsetting = 3,
                    .altset_idx = 3,
                    .attributes = 0,
                    .endpoint = 0x01,
                    .ep_attr = 0x01,
                    .rates = SNDRV_PCM_RATE_48000,
                    .rate_min = 48000,
                    .rate_max = 48000
                }
            },
            {
                .ifnum = 0,
                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                .data = & (const struct audioformat) {
                    .format = SNDRV_PCM_FORMAT_S24_3LE,
                    .channels = 2,
                    .iface = 0,
                    .altsetting = 4,
                    .altset_idx = 4,
                    .attributes = 0,
                    .endpoint = 0x01,
                    .ep_attr = 0x01,
                    .rates = SNDRV_PCM_RATE_44100,
                    .rate_min = 44100,
                    .rate_max = 44100
                }
            },
            {
                .ifnum = -1
            }
        }
    }
},

Practically the sound card uses just one interface (# 0) and has 4
alsettings which work (for playback) at this parameters (playback endpoint
is always 0x01):

altsetting 0, control msgs
altsetting 1, 48000 Hz, 16 bits LE, stereo, 192 bytes max packet size
altsetting 2, 44100 Hz, 16 bits LE, stereo, 180 bytes max packet size
altsetting 3, 48000 Hz, 24 bits 3LE, stereo, 288 bytes max packet size
altsetting 4, 44100 Hz, 24 bits 3LE, stereo, 270 bytes max packet size

For each altsetting the Windows' driver works by sending in every URB 2
packets long as the endpoints' max packet size. The card responds also by
continuously  sending data on the endpoint 0x82, and that is how capture is
done (when you just want to capture you can send 0-filled URBs to the card).
I haven't investigated yet, but this card should only do mono capture and
maybe at different rates on the same altsetting (they claim it can do 96 kHz
capture).

Then at init time some control msgs are sent to the card to init it, and I
tried to do this way:

/* ugly incomprehensible messages in here, snd_usb_ctl_msg does not work */
static int snd_usb_line6_tp_boot_quirk(struct usb_device *dev)
{
    int pipe = usb_sndctrlpipe(dev, 0);
    int err = 0;

    if ((err = snd_usb_ctl_msg(dev, pipe, 0x67, 0x40, 0x0102, 0x0200, NULL,
                   0, 0)) < 0)
        return err;

    if ((err = snd_usb_ctl_msg(dev, pipe, 0x03, 0x00, 0x0100, 0x0000, NULL,
                   0, 0)) < 0)
        return err;

    if ((err = snd_usb_ctl_msg(dev, pipe, 0x67, 0x40, 0x0108, 0x0000, NULL,
                   0, 0)) < 0)
        return err;

    err = snd_usb_ctl_msg(dev, pipe, 0x67, 0x40, 0x0103, 0x0000, NULL, 0,
                  0);

    return err;
}

But it doesn't work... after the first msg is sent the second (whatever it
is), when sent, brings to a -EPIPE error, and I still don't know why (I
checked the driver I was writing and the usb_control_msg code and they're
basically similar, expect that I submit urbs with GFP_KERNEL and it does
with GFP_NOIO). What should I do with then?

Then also when starting the playback another msg is to be sent (before
playback and after altsetting is set). This is the same msg as the third in
the previous function I wrote.

Do you think it could be mergeable?

------=_Part_1393_25883534.1152700166112
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote">2006/7/12, Clemens Ladisch &lt;<a href="mailto:clemens@ladisch.de">clemens@ladisch.de</a>&gt;:</span><br><div>&gt; Stefano D'Angelo wrote:<br>&gt; &gt; But maybe there's another solution to the problem: since this card has just
<br>&gt; &gt; some differences at initialization and playback start with normal USB cards,<br>&gt; &gt; maybe usb-snd-audio could be used.<br>&gt;<br>&gt; This would be preferrable.<br>&gt;<br>&gt; What are the differences? 
<br>&gt; <br>&gt;<br>&gt; Regards,<br>&gt; Clemens<br><br>Well, I'm already working on it. Yesterday night I starting modifying snd-usb-audio (and I have to admit that it is a great piece of code) and what I did is adding the quirk in 
usbquirks.h this way:<br><br>/* Line6 TonePort devices */<br>{<br>&nbsp;&nbsp;&nbsp; USB_DEVICE(0x0e41, 0x4141),<br>&nbsp;&nbsp;&nbsp; .driver_info = (unsigned long) &amp; (const struct snd_usb_audio_quirk) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .vendor_name = &quot;Line6&quot;,
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .product_name = &quot;TonePort UX1&quot;,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .ifnum = QUIRK_ANY_INTERFACE,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .type = QUIRK_COMPOSITE,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .data = &amp; (const struct snd_usb_audio_quirk[]) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .ifnum = 0,
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .type = QUIRK_AUDIO_FIXED_ENDPOINT,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .data = &amp; (const struct audioformat) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .format = SNDRV_PCM_FORMAT_S16_LE,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .channels = 2,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .iface = 0,
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .altsetting = 1,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .altset_idx = 1,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .attributes = 0,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .endpoint = 0x01,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .ep_attr = 0x01,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .rates = SNDRV_PCM_RATE_48000,
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .rate_min = 48000,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .rate_max = 48000<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; },<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .ifnum = 0,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .type = QUIRK_AUDIO_FIXED_ENDPOINT,
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .data = &amp; (const struct audioformat) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .format = SNDRV_PCM_FORMAT_S16_LE,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .channels = 2,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .iface = 0,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .altsetting = 2,
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .altset_idx = 2,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .attributes = 0,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .endpoint = 0x01,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .ep_attr = 0x01,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .rates = SNDRV_PCM_RATE_44100,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .rate_min = 44100,
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .rate_max = 44100<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; },<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .ifnum = 0,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .type = QUIRK_AUDIO_FIXED_ENDPOINT,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .data = &amp; (const struct audioformat) {
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .format = SNDRV_PCM_FORMAT_S24_3LE,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .channels = 2,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .iface = 0,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .altsetting = 3,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .altset_idx = 3,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .attributes = 0,
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .endpoint = 0x01,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .ep_attr = 0x01,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .rates = SNDRV_PCM_RATE_48000,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .rate_min = 48000,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .rate_max = 48000<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; },<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .ifnum = 0,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .type = QUIRK_AUDIO_FIXED_ENDPOINT,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .data = &amp; (const struct audioformat) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .format = SNDRV_PCM_FORMAT_S24_3LE,
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .channels = 2,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .iface = 0,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .altsetting = 4,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .altset_idx = 4,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .attributes = 0,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .endpoint = 0x01,
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .ep_attr = 0x01,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .rates = SNDRV_PCM_RATE_44100,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .rate_min = 44100,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .rate_max = 44100<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; },<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .ifnum = -1<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; }<br>},<br><br>Practically the sound card uses just one interface (# 0) and has 4 alsettings which work (for playback) at this parameters (playback endpoint is always 0x01):
<br><br>altsetting 0, control msgs<br>altsetting 1, 48000 Hz, 16 bits LE, stereo, 192 bytes max packet size<br>altsetting 2, 44100 Hz, 16 bits LE, stereo, 180 bytes max packet size<br>altsetting 3, 48000 Hz, 24 bits 3LE, stereo, 288 bytes max packet size
<br>altsetting 4, 44100 Hz, 24 bits 3LE, stereo, 270 bytes max packet size<br><br>For each altsetting the Windows' driver works by sending in every URB 2 packets long as the endpoints' max packet size. The card responds also by continuously&nbsp; sending data on the endpoint 0x82, and that is how capture is done (when you just want to capture you can send 0-filled URBs to the card). I haven't investigated yet, but this card should only do mono capture and maybe at different rates on the same altsetting (they claim it can do 96 kHz capture).
<br><br>Then at init time some control msgs are sent to the card to init it, and I tried to do this way:<br><br>/* ugly incomprehensible messages in here, snd_usb_ctl_msg does not work */<br>static int snd_usb_line6_tp_boot_quirk(struct usb_device *dev)
<br>{<br>&nbsp;&nbsp;&nbsp; int pipe = usb_sndctrlpipe(dev, 0);<br>&nbsp;&nbsp;&nbsp; int err = 0;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if ((err = snd_usb_ctl_msg(dev, pipe, 0x67, 0x40, 0x0102, 0x0200, NULL,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; 0, 0)) &lt; 0)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return err;<br><br>
&nbsp;&nbsp;&nbsp; if ((err = snd_usb_ctl_msg(dev, pipe, 0x03, 0x00, 0x0100, 0x0000, NULL,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; 0, 0)) &lt; 0)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return err;<br><br>&nbsp;&nbsp;&nbsp; if ((err = snd_usb_ctl_msg(dev, pipe, 0x67, 0x40, 0x0108, 0x0000, NULL,<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; 0, 0)) &lt; 0)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return err;<br><br>&nbsp;&nbsp;&nbsp; err = snd_usb_ctl_msg(dev, pipe, 0x67, 0x40, 0x0103, 0x0000, NULL, 0,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; return err;<br>}<br><br>But it doesn't work... after the first msg is sent the second (whatever it is), when sent, brings to a -EPIPE error, and I still don't know why (I checked the driver I was writing and the usb_control_msg code and they're basically similar, expect that I submit urbs with GFP_KERNEL and it does with GFP_NOIO). What should I do with then?
<br><br>Then also when starting the playback another msg is to be sent (before playback and after altsetting is set). This is the same msg as the third in the previous function I wrote.<br><br>Do you think it could be mergeable?
<br></div>

------=_Part_1393_25883534.1152700166112--


--===============0769910825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============0769910825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0769910825==--
