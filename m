From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: alsa-lib bloat.
Date: Sat, 09 Dec 2006 11:09:18 +0000
Message-ID: <457A995E.6080708@superbug.co.uk>
References: <45795C6D.9030100@superbug.co.uk>
	<Pine.LNX.4.61.0612090908570.13335@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0612090908570.13335@tm8103.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Fri, 8 Dec 2006, James Courtier-Dutton wrote:
> 
>> Hi,
>>
>> On my desktop system, I have this:
>> /usr/lib/libasound.so.2.0.0
>> size: 2785380 bytes.
> 
> Have you tried to build minimal alsa library?
> 
>   --disable-aload         disable reading /dev/aload*
>   --disable-mixer     Disable the mixer component
>   --disable-pcm       Disable the PCM component
>   --disable-rawmidi   Disable the raw MIDI component
>   --disable-hwdep     Disable the hwdep component
>   --disable-seq       Disable the sequencer component
>   --disable-instr     Disable the instrument component
>   --disable-alisp     Disable the alisp component
> 
>   --with-pcm-plugins=<list>  Build PCM plugins
> 
> Note that only hw plugin is important for pcm if applications will do all 
> conversions itself.
> 
> Just quick test with:
> 
> ./configure --disable-aload --disable-mixer --disable-rawmidi 
> --disable-hwdep --disable-seq --disable-instr --disable-alisp 
> --with-pcm-plugins=hw
> 
> strip -g --remove-section=.comment --remove-section=.note libasound.so
> 
> -rwxr-xr-x  1 perex users 366562 2006-12-09 09:22 libasound.so.2.0.0
> 
> It does not look so bad, doesn't?
> 
> With mixer stuff:
> 
> -rwxr-xr-x   1 perex users 420024 2006-12-09 09:25 libasound.so.2.0.0
> 
>> libasound is really too big for what is does.
>> I was talking to some embedded platform developers recently, and they 
>> really don't like it at all.
> 
> The best thing is to discuss what else can be shrinked (removed from 
> build). If embedded platform developers stay quiet, we won't care.
> 
> For example, all dynamic configuration code can be removed, too.
> 
> 						Jaroslav
> 

Thanks, that is a good start. I have entered that information into the 
alsa wiki.

https://bugtrack.alsa-project.org/wiki/wikka.php?wakka=AlsaEmbedded



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
