From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Re: The obsolence of OSS, Was: big smile
Date: Wed, 25 Feb 2004 15:03:22 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040225150322.pochini@shiny.it>
References: <20040225112021.GE8820@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040225112021.GE8820@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 25-Feb-2004 Adam Tla/lka wrote:
> On Tue, Feb 24, 2004 at 10:54:58PM +0100, Benno Senoner wrote:
>> for those that are too lazy to browse the forums:
>>
>> http://www.4front-tech.com/forum/viewtopic.php?t=25
>> -----
>> ....
>> far more advanced ???
>> Ok I'd like see Ardour runnnig with multiple 24bit cards, all the 
>> switches for hardware monitoring etc under OSS.
> nice but many people just haven't this hardware and want to use
> normal PCI sound cards or even matherboard build in codecs
> and mix many applications PCM sound together [...]

Actually, I have far less xruns with ALSA than OSS. Are you sure the
buffer has the same length ? Otherwise the comparison is unfair. The
tar test does measure mainly the quality of the VM subsystem and the
speed of the harddisk. The sound stops because the application runs
out of data to play because the disk is busy. If the app freezes it
means there are bugs somewhere.
And yes, OSS is simpler for the end user because it has far more
features and it's not flexible. It's the Windows philosophy :))

>> So this will slowly but surely render OSS totally obsolete. I'm
>> sorry but that's the truth that you cannot escape from.
> Maybe but now functionalty of ALSA and just ease of use is not
> so good to satisfy us. Mixing in lib is bad in my opinion and works nice
> only if we have enough free CPU cycles. But we use many applications at
> the same time compiling kernel, transfering data, looking in the
> archives, doing backups etc.

The code that runs inside the kernel doesn't execute faster. Instead,
you have far less control over it and it can cause high latencies.

And about the cuckoo thing, it's an ALSA-over-OSS frankenstein monster
that cannot be as good as both OSS or ALSA alone. They're trying to
keep OSS alive as long as they can.



--
Giuliano.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
