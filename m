From: Daniel Svensson <nano@nittionio.nu>
Subject: snd-emu10k1x samplerate capabilities
Date: Mon, 27 Dec 2004 20:47:58 +0000
Message-ID: <1104180478.4396.5.camel@paranoia>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

The snd-emu10k1x driver accepts samplerates that the hardware is not
capable of handling.

rate = 44100;
err = snd_pcm_hw_params_set_rate_near (pcm, hwparams, &rate, NULL);

err should be less than zero if the requested rate is 44100, or the rate
should be set to 48000. As it's handled now when that line is executed
the samplerate is set to 44100 and sound is broken.

-- Daniel Svensson



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
