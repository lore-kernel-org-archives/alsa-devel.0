From: Joshua N Pritikin <vishnu@pobox.com>
Subject: Re: S/PDIF RCA IEC958 C-Media PCI CMI8738 - can't record
Date: Fri, 4 Oct 2002 13:00:09 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021004073009.GB799@always.joy.eth.net>
References: <20021004031139.GB705@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20021004031139.GB705@always.joy.eth.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
Cc: jcwjcw@qwest.net, cltien@cmedia.com.tw, support@cmedia.com.tw, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 04, 2002 at 08:41:39AM +0530, Joshua N Pritikin wrote:
> I have an Iwill DVD266-uRN with CMI8738 sound.  I'm trying to record
> through the RCA S/PDIF Input port.  My system is Linux 2.4.19 i386 SMP.
> 
> I tried both C-Media's driver and the driver from the stock 2.4.19
> kernel.  S/PDIF RCA Output works but S/PDIF RCA Input doesn't
> work for either.  I also tried:
> 
>   http://member.nifty.ne.jp/Breeze/softwares/unix/cmictl-e.html
> 
> When i turn on Monitor then my analogue speakers output static.
> 
> I also tried Alsa 9.0rc1 CMIPCI driver.  Playback works fine but
> recording looks like this:
> 
> joshua@remix:~$ arecord -v -D spdif -t wav -f S16_LE -r 44100 -c 2 iectest
> Recording WAVE 'iectest' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo

Oops!  I installed cmipci from alsa 9.0rc3 and it works!!

-- 
Victory to the Divine Mother!!         after all,
  http://sahajayoga.org                  http://why-compete.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
