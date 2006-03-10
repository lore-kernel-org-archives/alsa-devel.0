From: Greg Borter <GregBWeb@yahoo.com>
Subject: Sound Blaster AWE64 card information
Date: Thu, 09 Mar 2006 23:21:46 -0500
Message-ID: <4410FEDA.3050606@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Recently I needed to get a Sound Blaster AWE64 working with my Debian 
based SimplyMEPIS 3.4.3 Linux system.  Most of the installation 
instructions on the web will only get the sound section working.   After 
a bit of digging I was able to piece together the extra steps that are 
needed to get the on-board  synthesizer working.  Because my card is an 
ISA card I needed to use isapnptools to setup the card.  Isapnptools 
doesn't properly detect all the needed addresses.  Two addresses had to 
be manually added to the isapnp.conf file.  I also had to manually add 
the snd-sbawe, snd-pcm-oss, snd-mixer-oss, snd-seq-oss, snd-seq-midi and 
snd-emu8000-synth modules to the etc/modules file.  The last step was to 
use asfxload to load the sound fonts.  Once this was done, I am now able 
to use the on-board EMU8000 synthesizer with various music programs, 
like Kmid, Note Edit, Rosegarden 4, etc.   If you would like, I can do a 
more detailed write up.

 



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
