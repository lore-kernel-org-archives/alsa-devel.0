From: Martin Langer <martin-langer@gmx.de>
Subject: Re: my alsa driver can't work
Date: Tue, 19 Nov 2002 10:29:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021119092921.GK24419@tuba.home>
References: <20021119002232.8CB591BD05@smtp.x263.net>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20021119002232.8CB591BD05@smtp.x263.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: sendto <sendto@263.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 19, 2002 at 08:27:16AM +0800, sendto wrote:
> hi,all.
> I am a debian user.When I install alsa-modules for 2.4.19-k7, and run /usr/share/doc/alsa-base/examples/snddrivers, I found that my driver can't work.
> I'm using via 82c686b chipset. I used alsaconf to create configure file.When start /etc/init.d/alsa, it report:
> Warning: ignoring snd_major=116, no such parameter in this module
> Warning: ignoring snd_cards_limit=1, no such parameer in this module
> Warning: ignoring snd_device_mode=0660, no such parameer in this module
> Warning: ignoring snd_device_gid=29, no such parameer in this module
> Warning: ignoring snd_device_uid=0, no such parameer in this module
> Module snd loaded, with warnings
> Starting ALSA sound driver (version 0.9.0rc5):Warning: ignoring snd_major=116, no such parameter in this module
> Warning: ignoring snd_cards_limit=1, no such parameer in this module
> Warning: ignoring snd_device_mode=0660, no such parameer in this module
> Warning: ignoring snd_device_gid=29, no such parameer in this module
> Warning: ignoring snd_device_uid=0, no such parameer in this module
> Module snd loaded, with warnings
>  (via686a)
> and snd-via82xx module wasn't loaded.
> 
> Can somebody help me, I want to program base on alsa-lib, but no alsa-driver I can't test my program!

All module parameters are now without "snd_" prefix. Editing
/etc/modules.conf should solve this problem for your "snd-via82xx".

e.g.: 		  snd_major -> major
		  snd_cards_limit -> cards_limit
		  ...


martin


-- 
"2b|!2b"


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
