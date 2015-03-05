From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ALSA: line6: Fix volume calculation for big-endian
Date: Thu, 5 Mar 2015 13:21:49 +0300
Message-ID: <20150305102149.GA10971@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi Iwai,

The patch 0416980d0a2b: "ALSA: line6: Fix volume calculation for
big-endian" from Jan 28, 2015, leads to the following static checker
warning:

	sound/usb/line6/playback.c:42 change_volume()
		warn: always clamps to s16min
	sound/usb/line6/playback.c:57 change_volume()
		warn: always clamps to (-8388608)
	sound/usb/line6/playback.c:129 add_monitor_signal()
		warn: always clamps to s16min

sound/usb/line6/playback.c
    25  static void change_volume(struct urb *urb_out, int volume[],
    26                            int bytes_per_frame)
    27  {
    28          int chn = 0;
    29  
    30          if (volume[0] == 256 && volume[1] == 256)
    31                  return;         /* maximum volume - no change */
    32  
    33          if (bytes_per_frame == 4) {
    34                  __le16 *p, *buf_end;
    35  
    36                  p = (__le16 *)urb_out->transfer_buffer;
    37                  buf_end = p + urb_out->transfer_buffer_length / sizeof(*p);
    38  
    39                  for (; p < buf_end; ++p) {
    40                          short pv = le16_to_cpu(*p);
    41                          int val = (pv * volume[chn & 1]) >> 8;
    42                          pv = clamp(val, 0x7fff, -0x8000);
                                                ^^^^^^^^^^^^^^^^
You didn't really add this, but you might know what was intended here.
It is a complete mystery to me.  :)

    43                          *p = cpu_to_le16(pv);
    44                          ++chn;
    45                  }
    46          } else if (bytes_per_frame == 6) {
    47                  unsigned char *p, *buf_end;
    48  
    49                  p = (unsigned char *)urb_out->transfer_buffer;
    50                  buf_end = p + urb_out->transfer_buffer_length;
    51  
    52                  for (; p < buf_end; p += 3) {
    53                          int val;
    54  
    55                          val = p[0] + (p[1] << 8) + ((signed char)p[2] << 16);
    56                          val = (val * volume[chn & 1]) >> 8;
    57                          val = clamp(val, 0x7fffff, -0x800000);
                                                 ^^^^^^^^^^^^^^^^^^^^
    58                          p[0] = val;
    59                          p[1] = val >> 8;
    60                          p[2] = val >> 16;
    61                          ++chn;
    62                  }
    63          }
    64  }

	[snip]


   127                          short piv = le16_to_cpu(*pi);
   128                          int val = pov + ((piv * volume) >> 8);
   129                          pov = clamp(val, 0x7fff, -0x8000);
                                                 ^^^^^^^^^^^^^^^^
   130                          *po = cpu_to_le16(pov);
   131                  }

regards,
dan carpenter
