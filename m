From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: Re: [linux-audio-user] midi and ecasound
Date: Wed, 17 Aug 2005 00:48:44 +0300 (EEST)
Message-ID: <Pine.LNX.4.62.0508170033020.26977@ecabase.localdomain>
References: <43645.192.168.0.2.1123890071.squirrel@192.168.0.2>
 <46225.192.168.0.2.1123891721.squirrel@192.168.0.2> <1123884862.12680.62.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1123884862.12680.62.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: A list for linux audio users <linux-audio-user@music.columbia.edu>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, 12 Aug 2005, Lee Revell wrote:
> Um, /dev/snd/midi* are not supposed to be used directly by applications.
> They are intended to be accessed via alsa-lib.

has there been (or is under planning) any major changes to this, or known 
problems?

Ecasound (and many other apps) has used /dev/snd/midi* with no reported 
problems for many years now (at least since ALSA 0.6.x). See for example:
    http://lalists.stanford.edu/lad/2001/Apr/0176.html

I understand the general principle of getting rid of all direct 
"user-space apps <-> ALSA kernel modules" interactions, but in this case 
I'd like to stick with the current code until there's some practical 
reason to update (adding support for ALSA sequencer API is another thing). 
The good ol' read/write interface is quite sufficient for rawmidi, and you 
can cover many use-cases with one piece of code (ALSA, OSS, pipes, etc)...

PS In this case not using alsa-lib is obviously not the problem as
    the same thing happens with /dev/midi*...

--
  links, my public keys, etc at http://eca.cx/kv


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
