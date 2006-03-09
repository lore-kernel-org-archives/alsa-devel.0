From: =?UTF-8?B?T25kcmVqIEl2YW5pxI0=?= <ondrej@kmit.sk>
Subject: Re: Bt87x Audio Capture
Date: Thu, 09 Mar 2006 10:06:11 +0100
Message-ID: <440FF003.5050106@kmit.sk>
References: <440F4F06.4030904@kmit.sk> <20060309074930.GA993@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060309074930.GA993@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

>>After `modprobe snd_bt87x', I have got nothing in logs.
>>
>>Last relevant info is from bt878 module:
>>
>>bt878: AUDIO driver version 0.0.0 loaded
> 
> This is the wrong module.  "bt878" is the old OSS driver, but you want

I didn't have OSS support in kernel and this module is from media/dvb:

filename: 
/lib/modules/2.6.15-gentoo-r1-3/kernel/drivers/media/dvb/bt8xx/bt878.ko
license:        GPL
vermagic:       2.6.15-gentoo-r1-3 PENTIUMIII gcc-3.4
depends:        bttv
alias:          pci:v0000109Ed00000878sv*sd*bc*sc*i*
parm:           debug:Turn on/off debugging, default is 0 (off). (int)
parm:           verbose:verbose startup messages, default is 1 (yes) (int)

> to use the "snd-bt87x" driver.


I was unloaded all modules form kernel and loaded only snd_bt87x module:

localhost init.d # lsmod
Module                  Size  Used by
localhost init.d # modprobe snd_bt87x load_all=1 enable=1
localhost init.d # cat /proc/asound/cards
--- no soundcards ---
localhost init.d # ls -la /dev/snd/
total 0
drwxr-xr-x   2 root root       60 Mar  9 01:51 .
drwxr-xr-x  13 root root     2720 Mar  9 01:51 ..
crw-rw----   1 root audio 116, 33 Mar  9 01:51 timer

In dmesg was't any output from snd_bt87x module...

Thanks

-- 
Ondrej Ivanic
(ondrej@kmit.sk)


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
