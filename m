From: Ryan Pavlik <rpav@mephle.com>
Subject: Re: ALSA doesn't work with XMMS - or alsaplayer either
Date: Mon, 19 Jan 2004 16:18:17 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040119161817.5ceac577.rpav@mephle.com>
References: <1074549141.22882.71.camel@moria.arnor.net>
	<1074555723.22882.75.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1074555723.22882.75.camel@moria.arnor.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 19 Jan 2004 15:42:03 -0800
Torrey Hoffman <thoffman@arnor.net> wrote:

> I can now confirm this is an ALSA problem, not just an XMMS problem:
> alsaplayer doesn't work with this driver either.
> 
> [thoffman@moria thoffman]$ alsaplayer -d hw:1:0 12.mp3
> ALSA lib pcm_hw.c:1142:(_snd_pcm_hw_open) Invalid value for card
> snd_pcm_open: No such device (hw:1:0)
> Failed to initialize plugin!
> Failed to register plugin: /usr/lib/alsaplayer/output/libalsa_out.so
> Failed to load output plugin "alsa". Trying defaults.
> 
> So... I haven't found any way to play an MP3 file on my M-Audio card
> without using OSS...

I've got an m-audio delta 44, you probably just need to use the xmms
ALSA plugin and tell it to use an ALSA plugin or whatever:

My .asoundrc:

    pcm.ice1712 {
        type hw
        card 0
        device 0
    }
    
    ctl.ice1712 {
        type hw
        card 0
    }
    
    pcm.cdaudio {
        type plug
        slave {
            pcm ice1712
        }
    }

Now in the xmms plugin where it says 'Audio device:' followed by
'[ ] User defined:', check that, and enter 'cdaudio' in the box.
After that it works fine for me.

Most other ALSA stuff should follow similarly; try -d cdaudio with
alsaplayer; with mplayer I use '-ao alsa9:cdaudio', etc.

hth,

-- 
Ryan Pavlik <rpav@mephle.com>

"I take offense at your *slanderous* allegations,
 accurate though they may be." - 8BT


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
