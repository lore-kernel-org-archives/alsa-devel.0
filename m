From: Chris Wenn <prismatic7@bigpond.com>
Subject: Terratec DMX (Newbie)
Date: Mon, 25 Feb 2002 13:33:05 +1100
Message-ID: <3C79A261.7030704@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Alsa-Announce List <alsa-announcet@lists.sourceforge.net>, Alsa-Devel List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hey there.

Soory about the cross-posting, but I'm hoping someone can give me a 
couple of pointers. I have a Terratec SoundSystem DMX (that's a Maestro 
2E card) which I can't get fired up using either alsaconf or by hand 
(I'm running the debian packages of alsa 0.9.0beta10) When I configure 
the card in alsaconf, I get through the first part ok (though I'm 
guessing at the values for configuration), until it's time to load up 
the mixer progs, at which point it crashes out saying:

# Loading driver:
# Starting ALSA sound driver (version 0.9.0beta10): no sound cards
# defined.
# Setting the PCM volume to 100% and the Master output volume tp 50%
# amixer: Mixer attach default error: No such file or directory
# Could not initialize the mixer, the card was probably not detected
# correctly.

If I do the configuration by hand in /etc/modules.conf, I get an error 
saying that 'parm_snd_pcm_channels_p' and 'parm_snd_pcm_channels_c' do 
not exist (sorry, I don't have the exact output to hand)

If someone could mail me the correct values and a quick how-to on 
getting the damn thing fired up, I'd much appreciate it.

Thanks
Chris



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
