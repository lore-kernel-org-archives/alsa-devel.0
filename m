From: Torrey Hoffman <thoffman@arnor.net>
Subject: Re: ALSA doesn't work with XMMS - or alsaplayer either
Date: Mon, 19 Jan 2004 15:42:03 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074555723.22882.75.camel@moria.arnor.net>
References: <1074549141.22882.71.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from devil.servak.biz (devil.servak.biz [209.124.81.2])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA06803
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2004 00:46:31 +0100
Received: from [64.122.104.99] (helo=[10.134.0.78])
	by devil.servak.biz with esmtp (Exim 4.24)
	id 1Aij60-0004LS-Re
	for alsa-devel@alsa-project.org; Mon, 19 Jan 2004 18:46:16 -0500
In-Reply-To: <1074549141.22882.71.camel@moria.arnor.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I can now confirm this is an ALSA problem, not just an XMMS problem:
alsaplayer doesn't work with this driver either.

[thoffman@moria thoffman]$ alsaplayer -d hw:1:0 12.mp3
ALSA lib pcm_hw.c:1142:(_snd_pcm_hw_open) Invalid value for card
snd_pcm_open: No such device (hw:1:0)
Failed to initialize plugin!
Failed to register plugin: /usr/lib/alsaplayer/output/libalsa_out.so
Failed to load output plugin "alsa". Trying defaults.

So... I haven't found any way to play an MP3 file on my M-Audio card
without using OSS...

Torrey


On Mon, 2004-01-19 at 13:52, Torrey Hoffman wrote:
> I'm not sure if this is a bug in the ALSA library, driver, or the XMMS
> ALSA plugin.
> 
> - I've got an M-Audio Audiophile 2496 which uses the ice1712 driver.
> - I'm using kernel 2.6.1-mm3 with ALSA 1.0.1 and the OSS emulation ALSA
> options disabled.
> - I've compiled an up-to-date XMMS with the included ALSA plugin.
> 
> It doesn't work.  Specifically:
> 
> If I use the default configuration of the ALSA XMMS plugin, it uses the
> "hw:0:0" device.  The ALSA XMMS plugin fails when it opens the device
> for playback - it can't set the sample format to any of the three
> hardware formats it tries.
> 
> If I configure the XMMS ALSA plugin to use the "plughw:0:0" device, it
> opens the device and begins playback, but I just get noise... a
> repetitive burst like a stuck CD player.
> 
> Shouldn't this work?  Anything I can do to debug this?
-- 
Torrey Hoffman <thoffman@arnor.net>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
