From: Andrew Gaydenko <a@gaydenko.com>
Subject: Aureon71, two parallel stereo outputs
Date: Thu, 10 Mar 2005 20:35:19 +0300
Message-ID: <200503102035.19825@goldspace.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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

I have ice1724 card (Terratec Aureon 7.1 Space, driver is 1.0.8). It has four
analogue stereo outputs. I'd like to use two of these outputs this way:

- line output 1 - stereo channel for head phones (it is the only output with
                  head phones amplifier),

- line output 2 - stereo channel to connect to an external audio amplifier.

How to make .asoundrc file to accomplish this tasks? I understand, some
alsa device must be configured, but it's all I understand :-)

My own attempts results:

I'm able to hear line outputs 1/2/3/4 with appropriate JACK-routing. So, hardware
works. Moreover, I was able to write appropriate qamix XML config file, and all
the controls are in sync with alsamixer. Now I know a mapping between hw:0,0 
subdevices, mixer controls and the card output jacks. But attempts to understand
.asoundrc secrets are not such lucky. For example, 'aplay -D rear/front' gives
the 'Sample format non available' error (without any redefinitions for rear/front
devices).

P.S. I'm ready to test something concerning Aureon71 with alsa from CVS :-)

Thanks!
Andrew


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
