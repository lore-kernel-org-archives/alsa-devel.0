From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Kernel crash
Date: Tue, 07 Sep 2004 09:55:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040907095502.pochini@shiny.it>
References: <s5h7jr7whqj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jr7whqj.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 06-Sep-2004 Takashi Iwai wrote:

>> It successfully crashes my system after a few attempts:
>>
>> Linux Jay 2.6.8.1 #2 SMP Wed Aug 18 15:14:51 CEST 2004 ppc unknown
>> booted with maxcpus=1 and without preempt.
>> alsa-driver-1.0.6a and CVS-2004-09-05
>> alsa-lib-1.0.4
>> gcc 3.4.1
>>
>> with both the powermac (Snapper) driver and my Echoaudio driver.
>
> It doesn't crash on my system with SB live with the latest CVS
> version but segfaults at line 263 because c is bogus.
> The crash looks likely driver-specific, then.

No, I don't think so. I already found (one of?) the cause, but
I forgot to mention it again, sorry. It happens because ALSA
calls the .free() pcm callback without calling .trigger(STOP)
and .close() first. Jaroslav posted a patch which didn't work,
then the discussion stopped. The problem occurs only when the
substreams are linked and the userpace app is badly broken
like mine.


> Did you try a UP kernel?

Just tried. Same thing with Echo driver, but the Pmac
driver doen't seem to crash anymore. And about the
PC I don't know if that kernel is MP of UP.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
