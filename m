From: =?UTF-8?Q?Dainius_Masili=C5=ABnas?= <pastas4@gmail.com>
Subject: Microphone issues with Microsoft LifeCam Studio
Date: Sat, 16 May 2015 23:37:07 +0300
Message-ID: <CABhjJhPS=RBWZdmtbLGj1pPhxy+f-aqvzY79FkjXS66kmY-v9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm having an issue with the Microsoft LifeCam Studio in that the
camera does not work if the integrated microphone in the camera is
activated at the same time. When that happens, the kernel log outputs
a variety of warnings such as:

cannot get freq at ep 0x82
ALSA lib pcm_dsnoop.c:614:(snd_pcm_dsnoop_open) unable to open slave
uvcvideo: Failed to query (GET_DEF) UVC control 2 on unit 4: -32 (exp. 2).
uvcvideo: Failed to query (GET_DEF) UVC control 2 on unit 4: 0 (exp. 2).
ALSA lib pcm.c:7980:(snd_pcm_set_params) Channels count (1) not
available for CAPTURE: Incorrect argument
ALSA lib pcm.c:7956:(snd_pcm_set_params) Broken configuration for
CAPTURE: no configurations available
ALSA lib pcm_route.c:867:(find_matching_chmap) Found no matching channel map
uvcvideo: Failed to set UVC probe control : -32 (exp. 26).

There is a workaround in that disabling the built-in microphone by
blacklisting snd_usb_audio does make the camera work, but obviously
it's not ideal at all, as that way half the camera's functionality is
not available and no other USB audio peripherals can be used.

I'm assuming that this is some sort of a quirk in the camera itself;
the UVC page ( http://www.ideasonboard.org/uvc/#footnote-13 ) does
mention that there is an issue with the bandwidth requests, but
setting the 0x80 quirk does not change the situation with the
microphone in any way, unfortunately.

I am running the latest mainline kernel (kernel-ml from elrepo) on CentOS 7.1.

Can anything be done about this issue, and is there anything I could
do to help debug it?

Also, this issue has been noted a few years back, but it was left unsolved:
https://bugs.launchpad.net/ubuntu/+source/guvcview/+bug/1033146
https://sourceforge.net/p/linux-uvc/mailman/message/29645043/
The original reporter said it was a Flash bug, but that is in no way
the case because my machine does not have Flash installed to begin
with (I'm testing this with WebRTC).
