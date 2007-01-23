From: "James Courtier-Dutton" <james.dutton@gmail.com>
Subject: Re: is it possible to use /dev/mem or somesuch to
	fiddle bits on the soundcard?
Date: Tue, 23 Jan 2007 13:30:49 +1100
Message-ID: <ad2655cb0701221830y5f9b7fddg4045e4160a2931b9@mail.gmail.com>
References: <F8FB97052F1BEF409F7842E960E49B5ADF39B3@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <F8FB97052F1BEF409F7842E960E49B5ADF39B3@sea-exch-01.na.corp.dmxmusic.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: John Utz <John.Utz@dmxmusic.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 23/01/07, John Utz <John.Utz@dmxmusic.com> wrote:
>
>
>
> Hello again;
>
>
>
> My current development process has me continually creating/editing driver
> code and the recompiling the module and reloading it and driving the results
> with amixer, and then reviewing the results via
>
> cat /proc/asound/V8237/codec97#0/ac97#0-0+regs
>
> is there a way to fiddle the bits more explicitly? Is the +regs stuff
> available as writable somehow?
>

Yes, build in debug mode.
./configure --with-cards=via  --with-debug=basic

The files in /proc/asound/V8237/codec97#0  will then be writable as well.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
