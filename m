From: Juhana Sadeharju <kouhia@nic.funet.fi>
Subject: emu10k1 sample rates?
Date: Wed, 13 Oct 2004 16:10:47 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <S23465AbUJMNKr/20041013131047Z+4248@nic.funet.fi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello.

This is the third time I ask these questions within a couple of
years because I have not got the answer. So, please reply and
explane very carefully.

When I record from emu10k1 (e.g., from livedrive linein2)
with sample rate 44100 Hz, then what sample rate the
emu10k1 is running at?

I have heard that emu10k1 runs only at rate 48000 Hz. Yes or no?
If yes, then I would like to know:
 (1) At what rate A/D converters are running when I record at 44100 Hz?
     (It would be perfectly ok if the A/Ds would run at 48000 Hz.)
 (2) Who does the conversion to 44100 Hz?

Specially I would like to know if Alsa is doing the conversion
with software, e.g., by boldly skipping samples.

If the conversion is done in emu10k1 with the rate converters
provided by E-mu, then what quality setting is used? MS Windows
driver provides two quality settings (the good quality and the
best quality). Is the quality setting the emu10k1 hardware property?

Think also the extreme cases such as rate 11025 Hz. At that rate
the rate conversion becomes important. Also, if the emu10k1 can
be made to run at rate 11025 Hz, then that means 4x more processing
power for frequencies less than 5000 Hz.

Juhana
-- 
  http://music.columbia.edu/mailman/listinfo/linux-graphics-dev
  for developers of open source graphics software


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
