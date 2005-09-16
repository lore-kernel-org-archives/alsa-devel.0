From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0 modem
Date: Fri, 16 Sep 2005 20:04:01 +0800
Message-ID: <432AB4B1.1050808@netvigator.com>
References: <20050913173529.GD31269@sashak.softier1.local> <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com> <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <20050915204345.GC27700@sashak.softier1.local> <20050916084653.GB524@titan.lahn.de> <432A8887.4020808@netvigator.com> <20050916103604.GA3168@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050916103604.GA3168@titan.lahn.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: pmhahn@titan.lahn.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Philipp Matthias Hahn wrote:
> Hello!
> 
> On Fri, Sep 16, 2005 at 04:55:35PM +0800, Raymond wrote:
> 
>>>>2. GPIO
>>>>
>>>>Probably we are lucky and au88x0 implements it in AC97 way, try to write
>>>>mc97 registers via /proc (for this you need build drivers in debug mode,
>>>>'--with-debug=detect' is ok):
>>>># echo 42 ffff > /proc/asound/card0/codec97#0/mc97#1-1+regs
>>>># echo 42 0 > /proc/asound/card0/codec97#0/mc97#1-1+regs
>>>># echo 54 1 > /proc/asound/card0/codec97#0/mc97#1-1+regs
>>>
>>>Sorry, I did echo those values and read mc97#1-1+regs, but no values
>>>changed.
>>
>>This may mean the patched  vortex_codec_read() works but 
>>vortex_codec_write() is still not working as expected.
>>
>>Do system log show any timeout error of the codec ?
> 
> 
> No messages.
> 
> BYtE
> Philipp


Add printk to dump the ac97 read/write to system log


  		VORTEX_CODEC_WRITE);

  	/* Flush Caches. */
  	hwread(card->mmio, VORTEX_CODEC_IO);
+	printk(KERN_INFO "vortex_codec_write %d %.2x : 
%.4x\n",codec->num,addr,data);
  }

  static unsigned short vortex_codec_read(ac97_t * codec, unsigned short 
addr)
@@ -2567,7 +2556,7 @@
  		}
  	} while ((data & VORTEX_CODEC_ADDMASK) !=
  		 (addr << VORTEX_CODEC_ADDSHIFT));
-
+	printk(KERN_INFO "vortex_codec_read  %d %.2x : 
%.4x\n",codec->num,addr,data & VORTEX_CODEC_DATMASK);
  	/* return data. */
  	return (u16) (data & VORTEX_CODEC_DATMASK);
  }



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
