From: James <whitetigerx7@sbcglobal.net>
Subject: Extra Emu10k1 documentation that may be helpful
Date: Mon, 14 Mar 2005 15:17:50 -0800
Message-ID: <42361B9E.2080604@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

I found that by loading the snd-emu10k1-synth module and such like 
awesfx, pmidi, and timidity up using the rc.local script in my Slackware 
10.1 installation worked very well if not very simplified. Here's a copy 
and sample of what I used:

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo "Loading Emu10kx Wavetable Synthesizer module: /sbin/modprobe 
snd-emu10k1-synth"
/sbin/modprobe snd-emu10k1-synth
echo "Loading AWESFX Soundfonts for Emu10kx Wavetable Synthesizer: 
/usr/bin/asfxload /etc/midi/CT4MGM.SF2"
/usr/bin/asfxload /etc/midi/CT4MGM.SF2
echo "Starting TiMidity Software Midi Synthesizer: /usr/bin/timidity -iA 
-B2,8 -Os -EFreverb=0 > /dev/null"
/usr/bin/timidity -iA -B2,8 -Os -EFreverb=0 > /dev/null &
echo "Loading PMidi ALSA Midi Sequencer and Ports: /usr/bin/pmidi -l"
/usr/bin/pmidi -l &
echo "Defining Pmidi Default Sequencer Port: /usr/bin/pmidi -p 65:0"
/usr/bin/pmidi -p 65:0 &
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

For other users it would have to be editted some but documentation on 
this is lacking and most people don't know enough on how easy it is to 
setup Midi on Linux.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
