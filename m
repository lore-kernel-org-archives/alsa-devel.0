From: Aner Gusic <aner@lysator.liu.se>
Subject: problems with the mixer (fwd)
Date: Sat, 8 May 2004 16:37:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040508143705.GA7511@sture.lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hi!

I didn't get any answer on alsa-user list so I try here.


I have a Hoontech NX card with outputs for front and rear speakers.
Volume settings for these I would like to set independently of each
other, and this worked just fine while I was running ALSA 0.5.x.
However, a couple of days ago I upgraded to ALSA 1.0.3.

Now, there are two possibilities for controling volume settings on
speakers, one with "Sigmatel 4-speaker stereo" off and another with
this switch turned on.

The second posibility (4-s s on), has following setup:
  - "Master" controls front speakers
  - "PCM" controls both front and rear speakers

Sigmatel 4-speaker stereo off is almost what I want:
  - "Master", "PCM", "PCM Front" control front speakers
  - "Surrownd", "PCM Reverb" control rear speakers

However, PCM Front and PCM Reverb are set to 100% resp. 0% each time
/dev/dsp is opened.  This works perfectly for front speakers since
they can be controled with Master or PCM controls, but rear speakers
are muted each time a new song starts.

Is this a bug? (I hope it is.)  Is it a known bug, or is it some kind
of feature I can hope to be able to go around in future release of
trident driver?

Regards,

-- 
Aner Gusic,
Linköping
Sweden


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
