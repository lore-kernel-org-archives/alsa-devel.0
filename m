From: Andrew Gaydenko <a@gaydenko.com>
Subject: Re: Aureon71, two parallel stereo outputs
Date: Fri, 11 Mar 2005 00:03:45 +0300
Message-ID: <200503110003.45666@goldspace.net>
References: <200503102035.19825@goldspace.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
In-Reply-To: <200503102035.19825@goldspace.net>
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

OK, I have found in FAQs how to achive parallel outputs. The
route plugin solves the problem:

pcm.2x2 {
    type route
    slave.pcm surround40
    slave.channels 4
    ttable.0.0 1
    ttable.1.1 1
    ttable.0.2 1
    ttable.1.3 1
}

But I don't understand this decision. Whill anybody be so kind to point
me to explanation of such kind of routing?

Andrew

======= On Thursday 10 March 2005 20:35, Andrew Gaydenko wrote: =======
...
I have ice1724 card (Terratec Aureon 7.1 Space, driver is 1.0.8). It has four
analogue stereo outputs. I'd like to use two of these outputs this way:

- line output 1 - stereo channel for head phones (it is the only output with
                  head phones amplifier),

- line output 2 - stereo channel to connect to an external audio amplifier.
...


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
