From: Roger E Critchlow Jr <rec@elf.org>
Subject: Re: Help fix driver for YMF-744B on Toshiba Tecra 8100?
Date: Thu, 19 Feb 2004 11:28:32 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40350050.1040901@elf.org>
References: <Pine.LNX.4.58.0402181132500.19312@laptop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0402181132500.19312@laptop.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: "Mihai T. Lazarescu" <mihai@email.it>
List-Id: alsa-devel@alsa-project.org

As I mentioned back in December, I can get the alsa driver to
work on my Tecra 8100 by reloading the alsa driver until it
works.  This takes somewhere between 0 and 20 reloads.  Mihai
has confirmed this behavior on his machine and also noted that
the sound functional/nonfunctional state persists through a
suspend/resume cycle.

I've combined the reloading process with two different state
scans to see if I could detect what is different between the
working and non-working states of the ymfpci driver.

The first state was the output of /sbin/lspci -vvxxxs 00:0c.0,
and the second state was a concatenation of the file contents
of every file found under /proc/asound/card0.

In each case, I looped through 10 reloads of alsa, found the
exact same machine state after each reload, but some of the
reloaded states produced functional sound while others produced
noise.

Is there any other state information that I might look at to
determine why an Alsa driver doesn't appear to be behaving
deterministically?

-- rec --

Mihai T. Lazarescu wrote:

>Hello developers,
>
>I would like to try to fix the long standing bug of the ALSA
>driver for the Toshiba Tecra 8100 YMF-744B card.
>
>My experiences until now led, in the best of the cases,
>to sound with cracks and distortions, no matter the mixer
>settings (mostly if at boot time the OSS drivers are loaded,
>then rmmod them and insmod ALSA).  In the worst, only high
>pitch whistles with some cracks here and there (mostly if ALSA
>is loaded directly at boot).
>
>I am quite familiar with C, but not with ALSA internals.
>I'd like to try and debug this if someone is willing to direct
>me to what to look for.
>
>Thanks in advance!
>
>Mihai
>  
>



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
