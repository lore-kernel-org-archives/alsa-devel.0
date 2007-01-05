From: "Andrew Johnson" <ajohnson@intrinsyc.com>
Subject: Click after draining
Date: Fri, 5 Jan 2007 14:48:20 -0800
Message-ID: <DBC923D919FAB345973A94E6E194E84903DC5175@yvrmail01.itc.intrinsyc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi All,

This bug
(http://thread.gmane.org/gmane.linux.alsa.devel/14700/focus=14700)
appears to exist for the pxa2xx-pcm driver on a PXA270 platform.  

- It appears that Takashi's patch isn't included in the ALSA Drivers as
of 2.6.16 - is there any reason why?
- Takashi commented in the thread that the period sizes must all be the
same.  Is this still true?  If the sizes are not the same (as in the
pxa2xx-pcm driver), could this cause this problem?

I've done some analysis by toggling a GPIO when a period ends.  The
result is (N indicates sound, the two N's at the end indicate unwanted
sound which appears to come from earlier in the circular buffer):

     |-------------------|-------------------|-------------------|
     NNNN                                   NN
                  ^                          ^
End of audio data |                          | SNDRV_PCM_TRIGGER_STOP


So the IRQ is occurring but the ALSA core is not turning off the DMA
until the next IRQ.  I've experimented with setting 

	runtime->stop_threshold = runtime->buffer_size -
runtime->period_size;

And this works but ends up cutting other .wav files short.  I have found
that setting 

	runtime->silence_size = runtime->period_size * 2;
	runtime->silence_threshold = runtime->period_size * 2;

causes this problem to go away however this causes issues when playing
multiple sound files back to back.

Any help on this would be much appreciated!

Kind Regards,

Andrew

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
