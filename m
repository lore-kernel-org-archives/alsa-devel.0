From: Mark J Roberts <mjr@znex.org>
Subject: Audigy1 MIDI input, wavetable support?
Date: Fri, 7 Mar 2003 09:44:02 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030307154402.GA338@znex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am trying to load a soundfont into my Audigy1's wavetable and play
it with a MIDI keyboard. I am using kernel 2.5.64.

MIDI output verifiably works. However, MIDI input does not. The
cable and keyboard are not the problem--I've tried them with an
es1371, and I easily got MIDI input working.

My procedure with the Audigy1:

	cat /dev/snd/midiC0D0
	watch /proc/interrupts
	watch /proc/asound/Audigy/midi0

No interrupts occur and no bytes are read. I have also tried using
aconnect to connect the inputs. Does anyone else see this behavior?

I've got one more question. What program should I use to configure
the wavetable and load the soundfonts? I found a couple versions of
"awesfx", neither of which was compatible with my ALSA.


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
