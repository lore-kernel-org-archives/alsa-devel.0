From: Janina Sajka <janina@rednote.net>
Subject: No dmix with HDSP Multiface
Date: Tue, 22 Mar 2005 13:05:10 -0500
Message-ID: <20050322180510.GA8180@rednote.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

I have 1.0.9RC1 compiled and installed--but cannot get dmix to work. Am
I going about it wrong? Or are there still known issues with dmix using
RME hardware? Mine is a HDSP Multiface. Here's what I get:

#aplay -D dmix:SLAVE=\"hw:0,0\",RATE=48000 Any_Dream_Will_Do.wav
ALSA lib conf.c:3808:(parse_args) Unknown parameter SLAVE
ALSA lib conf.c:3930:(snd_config_expand) Parse arguments error: No such
file or directory
ALSA lib pcm.c:2070:(snd_pcm_open_noupdate) Unknown PCM
dmix:SLAVE="hw:0,0",RATE=48000
aplay: main:508: audio open error: No such file or directory
[root@concerto 12:59:57] ~

On the other hand, if I leave the arguments out, the file plays:

#aplay Any_Dream_Will_Do.wav
Playing WAVE 'Any_Dream_Will_Do.wav' : Signed 16 bit Little Endian, Rate
44100



Janina Sajka				Phone: +1.202.494.7040
Partner, Capital Accessibility LLC	http://www.CapitalAccessibility.Com

Chair, Accessibility Workgroup		Free Standards Group (FSG)
janina@freestandards.org		http://a11y.org

If Linux can't solve your computing problem, you need a different problem.



-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
