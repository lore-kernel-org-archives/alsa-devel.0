From: Jack Howarth <howarth@bromo.msbb.uc.edu>
Subject: arecord?
Date: Tue, 14 May 2002 19:47:13 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205142347.TAA37260@bromo.msbb.uc.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

   Can someone tell me if I am misusing arecord? On a Powermac G4/AGP
using alsa 0.9.0rc1 with the snd-powermac driver I am attempting to
record. I set up a .asoundrc file in my directory with...

pcm.copy {
  type plug
  slave {
  pcm hw
  }
  route_policy copy
}

and then tried...

arecord -d 10 -f cd -t wav -D copy foobar.wav


which created a file test.wav. However when I do...

aplay foobar.wav

I get the error...

aplay: test_wavefile:626: can't play not PCM-coded WAVE-files

Is this expected behavior or are we lacking some support in
snd-powermac that is essential for recording to work?
                     Jack

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
