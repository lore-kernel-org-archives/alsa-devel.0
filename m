From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: AW: usb quattro
Date: Tue, 10 Sep 2002 01:36:45 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D7CCE1D.1020902@boosthardware.com>
References: <3D77A319.3010703@boosthardware.com>	<DAELIEGDPLDDCIJPAICBGEHNCDAA.annabellesgarden@yahoo.de>	<s5hvg5jwgvk.wl@alsa2.suse.de>	<3D7912A2.1000908@boosthardware.com> <s5hy9abzefz.wl@alsa2.suse.de> <3D7C8C53.7060001@boosthardware.com> <3D7CA2FF.2030705@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:

>  Currently the hw layer produces white
> noise.
> 

What is odd about this is that the noise only comes from the internal 
i/o. If I play through an external and use the direct monitor switch the 
  sound is perfect.

I get the most stable jack with these settings:

- using the hw layer.

jackd -v -R -d alsa -d quattro2 -p 4608

- using the plug layer.

jackd -v -R -d alsa -d q4 -p 1017

I have tested (using ardour) a 48khz stereo sine wave. For the first 
example I get white noise and for the second I get an almost clean 
signal which sounds slightly higher pitched than it should.

Note that using the previous version of the driver I could get a clean 
signal from all native alsa apps.

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
