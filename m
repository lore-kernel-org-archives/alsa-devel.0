From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: Re: [linux-audio-dev] Mp3 File Decoder
Date: Tue, 26 Feb 2002 08:36:07 +0100 (MET)
Message-ID: <XFMail.20020226083607.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
In-Reply-To: <XFMail.20020226071043.guenther.sohler@newlogic.com>
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


This might not be 100% alsa related but not out of topic
Until now I use Xaudio for my application xgmc.

I want to get rid of it because

*It seems very out of date
*it when decoding it outputs much 0's at at the very first output.
 I dont want this. I immediately want data.
*It seems that the granularity in positioning within within the mp3 file
 is to high. I need to be able to seek any accurate position with maximum
   50 ms tolerance. 10ms preferred.

In general I am looking for free c code/ c-library which outputs raw audio
data 
@ 44.1kHz stereo, 16bit. Important is that i can rewind/seek to any position
any time(within 10ms preferred).

Can anybodyhelp me ?


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
