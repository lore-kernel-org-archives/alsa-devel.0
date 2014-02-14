From: Olivier Langlois <olivier@trillion01.com>
Subject: user defined plugin and namehint
Date: Fri, 14 Feb 2014 08:45:49 -0500
Message-ID: <1392385549.2165.13.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from alt-proxy30.mail.unifiedlayer.com
 (alt-proxy30.mail.unifiedlayer.com [74.220.223.59])
 by alsa0.perex.cz (Postfix) with SMTP id 07BB3261703
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 14:46:00 +0100 (CET)
Received: from [173.179.63.169] (port=34835 helo=[192.168.1.104])
 by box610.bluehost.com with esmtpsa (SSLv3:RC4-SHA:128) (Exim 4.80)
 (envelope-from <olivier@trillion01.com>) id 1WEJ5Y-0006gv-Li
 for alsa-devel@alsa-project.org; Fri, 14 Feb 2014 06:45:56 -0700
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

Hi,

I created a new plugin in asound.conf and I would like it to appear in
the list presented with aplay -L as this is the list used by my media
player (vlc) to offer the option to choose my playback device.

I have tried this:

pcm.rate96000Hz {
        type hw
        card 0
        device 0
        rate 96000
        hint {
                show on
                description "96000Hz rate output"
        }
}

It seems that it is missing the small magic used by standard specs. ie:
from front.conf:

        hint {
                show {
                        @func refer
                        name defaults.namehint.basic
                }
                description "Front speakers"
                device $DEV
        }

Background problem:

I have a flac audio file with 88.2 kHz sampling rate 24 bits and the
player is opening the playback device at 48kHz and downsample my file.
>From the ui, there doesn't seem to be a way to fine tune these params. I
will bring the discussion to vlc dev as well.

Thank you,
