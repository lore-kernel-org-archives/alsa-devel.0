From: Steve deRosier <derosier@pianodisc.com>
Subject: How to tell how many frames gone to PCM
Date: Tue, 26 Apr 2005 13:18:18 -0700
Message-ID: <426EA20A.70403@pianodisc.com>
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
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

All,

I'm having issues w/ synchronizing MIDI and audio data I output via Alsa.  I'm working through my program trying to confirm data flow and I need some help.

Is there a particular function (or other method) I can use to tell me the number of frames I have sent to alsa via snd_pcm_writei()?  

Either type would be good:
---
open pcm
write all data
get # frames written
close pcm
--- or
open pcm
get current frame count
write all data
get new frame count
print new - old counts
close pcm
---

Any help you could give would be appreciated.

Thanks,
- Steve


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
