From: Julien Bramary <julien.bramary@blueyonder.co.uk>
Subject: Re: Trigger Callback
Date: Tue, 01 Aug 2006 21:14:24 +0100
Message-ID: <44CFB620.40609@blueyonder.co.uk>
References: <44CFB014.2050704@blueyonder.co.uk>
	<1154462119.14540.73.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1154462119.14540.73.camel@mindpipe>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>>  > "PCM engine" refers to the hardware's PCM engine, not ALSA's.  It's 100%
>>  > device dependent - you need to consult the docs for your sound device to
>>  > determine how to start the PCM.
>>  >
>>  > Lee
Thanks, I see now why it starts, I'm doing some inits in my dac in the
open callback... I should do those here in the trigger.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
