From: Andrew Gaydenko <a@etver.com>
Subject: ice1724 controls meaning
Date: Mon, 16 Feb 2004 22:32:38 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402162232.38240@goldspace.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

Briefly: Will anybody be so kind to explain (or to give some links) to
         understand ice1724 controls meaning?

Info: I have Terratec Aureon 7.1 Space. After some struggling with qamix 
      and adding few lines to code, I'm able now to configure qamix to be
      in synch with all alsamixer controls (the problem was with controls
      which have the same "alsaname" and different indexes; I have added
      "index" attribute to "element" element, and the problem was gone).
      Now I'm slightly confused where to go now. If anybody will find a 
      minute for comments, all controls are listed below.

With hope,
Andrew

=================== controls list =======================
numid=1, iface=CARD,name='ICE1724 EEPROM'

numid=2, iface=MIXER,name='Multi Track Internal Clock'
numid=3, iface=MIXER,name='Multi Track Rate Locking'
numid=4, iface=MIXER,name='Multi Track Rate Reset'

numid=5, iface=MIXER,name='H/W Playback Route'
numid=6, iface=MIXER,name='H/W Playback Route',index=1
...
numid=12,iface=MIXER,name='H/W Playback Route',index=7

numid=13,iface=MIXER,name='Multi Track Peak'

numid=14,iface=MIXER,name='IEC958 Playback Route'
numid=15,iface=MIXER,name='IEC958 Playback Route',index=1

numid=16,iface=MIXER,name='IEC958 Output Switch'

numid=17,iface=PCM,name='IEC958 Playback Default',device=1

numid=18,iface=MIXER,name='IEC958 Playback Con Mask',device=1
numid=19,iface=MIXER,name='IEC958 Playback Pro Mask',device=1

numid=20,iface=MIXER,name='DAC Volume'
numid=21,iface=MIXER,name='DAC Volume',index=1
...
numid=27,iface=MIXER,name='DAC Volume',index=7

numid=28,iface=MIXER,name='Master Playback Volume'

numid=29,iface=MIXER,name='ADC Volume'
numid=30,iface=MIXER,name='ADC Volume',index=1

numid=31,iface=MIXER,name='Capture Route'


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
