From: Lars Heineken <Lars.Heineken@gmx.de>
Subject: Re: Opening dev/dsp takes very long
Date: Sat, 20 Mar 2004 17:59:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405C788C.7000000@gmx.de>
References: <Pine.HPX.4.33n.0403160917290.14608-100000@studcom.urz.uni-halle.de> <4056BF90.2060005@gmx.de> <405AE7B8.6080603@gmx.de> <405B6CFD.9070303@gmx.de> <405B88B1.3070204@superbug.demon.co.uk> <405BFEB2.9040402@gmx.de> <Pine.LNX.4.58.0403201420340.1816@pnote.perex-int.cz> <405C6CAA.9030709@gmx.de> <Pine.LNX.4.58.0403201708340.1816@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0403201708340.1816@pnote.perex-int.cz>
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

> It affects both, but ALSA API does the setup of stream parameters once, 
> but OSS API does this multiple times because there is no way to distict 
> the configuration phase and the working phase, thus we must reconfigure
> after settings of all parameters.
> 
> If you strace aplay then you'll see that one ALSA ioctl has exactly same 
> 0.5 sec peek.

Thanks a lot for your help, I would have never found that by myself.

To test it, i modified these lines (an ugly hack, for sure)

snd_cs8427_reg_write(cs8427, CS8427_REG_CLOCKSOURCE, 
chip->regmap[CS8427_REG_CLOCKSOURCE]);
         //udelay(200);
         chip->regmap[CS8427_REG_CLOCKSOURCE] |= CS8427_RUN | 
CS8427_RXDILRCK;
         snd_cs8427_reg_write(cs8427, CS8427_REG_CLOCKSOURCE, 
chip->regmap[CS8427_REG_CLOCKSOURCE]);
         //udelay(200);
         snd_i2c_unlock(cs8427->bus);
         end_time = 0; //jiffies + HZ / 2;

..and it works like a charm on my Terratec EWX24/96. After the next 
release I'll test the module option.

Thanks again,

Lars.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
