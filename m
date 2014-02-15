From: Olivier Langlois <olivier@trillion01.com>
Subject: Re: user defined plugin and namehint
Date: Sat, 15 Feb 2014 02:55:17 -0500
Message-ID: <1392450917.2165.22.camel@Wailaba2>
References: <1392385549.2165.13.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy7-pub.mail.unifiedlayer.com
 (oproxy7-pub.mail.unifiedlayer.com [67.222.55.9])
 by alsa0.perex.cz (Postfix) with SMTP id 90E0D2610D1
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2014 08:55:26 +0100 (CET)
Received: from [173.179.63.169] (port=36398 helo=[192.168.1.104])
 by box610.bluehost.com with esmtpsa (SSLv3:RC4-SHA:128) (Exim 4.80)
 (envelope-from <olivier@trillion01.com>) id 1WEa5o-0000MI-1D
 for alsa-devel@alsa-project.org; Sat, 15 Feb 2014 00:55:20 -0700
In-Reply-To: <1392385549.2165.13.camel@Wailaba2>
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

On Fri, 2014-02-14 at 08:45 -0500, Olivier Langlois wrote:
> Hi,
> 
> I created a new plugin in asound.conf and I would like it to appear in
> the list presented with aplay -L as this is the list used by my media
> player (vlc) to offer the option to choose my playback device.
> 
> I have tried this:
> 
> pcm.rate96000Hz {
>         type hw
>         card 0
>         device 0
>         rate 96000
>         hint {
>                 show on
>                 description "96000Hz rate output"
>         }
> }
> 
I cannot make sense of everything that the function try_config() in
control/namehint.c is doing or what the hint compound undocumented
fields are supposed to mean but by changing my pcm definition to:

pcm.rate96000Hz {
        type hw
        card 0
        device 0
        rate 96000
        hint {
                show on
                device -1 # type hw are excluded. Adding this field
trick alsa-lib to add this PCM in the list of PCMs
                description "96000Hz rate output"
        }
}

Unfortunately, it did not resolve my problem. I have finally figured out
that by simply changing the default dmix sampling rate was what I
needed.

greetings,
