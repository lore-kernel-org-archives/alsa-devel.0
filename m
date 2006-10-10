From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [alsa-cvslog] alsa-kernel: snd-emu10k1: Add
 emu1010 internal clock rate control for	44100 or 48000.
Date: Tue, 10 Oct 2006 18:23:59 +0100
Message-ID: <452BD72F.6000605@superbug.co.uk>
References: <ALOGGER1160500186.86@alsa-project.org>
	<1160500766.629.84.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1160500766.629.84.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Tue, 2006-10-10 at 19:09 +0200, James Courtier-Dutton wrote:
>> +                       /* Allow DLL to settle */
>> +                       udelay(10000); 
> 
> Should it be "usleep"?  Spinning for 10ms in the kernel could be
> considered rude...
> 
> Lee
> 
Yes. I used the wrong one.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
