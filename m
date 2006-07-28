From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [alsa-cvslog] alsa-lib: Move dB parser to mixer
 abstraction
Date: Fri, 28 Jul 2006 21:46:10 +0100
Message-ID: <44CA7792.2010703@superbug.co.uk>
References: <ALOGGER1154091319.81@alsa-project.org>
	<44CA5789.1040308@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44CA5789.1040308@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Takashi Iwai wrote:
>> changeset:   2174:9cef8245d99a19f79d6c90e8ddc78606e317fdd7
>> tag:         tip
>> user:        tiwai
>> date:        Fri Jul 28 14:36:37 2006 +0200
>> files:       include/control.h src/control/hcontrol.c src/mixer/simple_none.c
>> description:
>> Move dB parser to mixer abstraction
>>
>> Moved the parser of dB value to mixer abstraction from hcontrol layer.
>> Also, cleaned up codes.
>>
> 
> Is it too much to ask that if you commit code, that it actually works.
> Currently, any call to "static int get_dB_ops(..." returns an error,
> irrespective of whether the kernel driver returns useful dB info or not. :-(
> 
> At least the code I committed actually worked!
> 

Sorry, The mistake is my end. I had been playing with an older repository.

James



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
