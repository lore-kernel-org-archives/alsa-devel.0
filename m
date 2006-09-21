From: James Courtier-Dutton <James@superbug.co.uk>
Subject: alsa resampler comstraints.
Date: Thu, 21 Sep 2006 21:54:00 +0100
Message-ID: <4512FBE8.6060905@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

Hi,

I want to document some of the constraints of the alsa resampler.
Here is what I understand, and I would like someone to verify my 
statements before I document them.

1) The buffer and period sizes for the sound card hardware to resampler 
are limited to the max buffer and period sizes available on the 
hardware. As a result, the available buffer and period sizes vary 
depending on hardware utilised.
2) The resampler converts one hardware period size at a time. This 
results in the buffer and period size constraints explained in (1) 
arriving at the application as a direct ratio of source and destination 
sample rate.
e.g. hardware has 2 periods of 1024 frames running at 48000 Hz.
application will see 2 periods of 1024 * 44100 / 48000 = 940.8. This is 
rounded down to 940 frames. So the user application sees 2 periods of 
940 frames.
If user space asks for 2 periods of 1024 at 44100 hz it will fail.


The above 2 points were true some time ago. Has anything changed?


Kind Regards

James


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
