From: Tim Goetze <tim@quitte.de>
Subject: Re: General Guidelines?  (MIDI)
Date: Thu, 16 Jan 2003 16:32:05 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0301161630050.665-100000@summer.quitte>
References: <20030116134157.GA31876@bhv1.adelphia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030116134157.GA31876@bhv1.adelphia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian Victor <bhv1@psu.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Brian Victor wrote:

>On Thu, Jan 16, 2003 at 08:39:23AM +0100, Clemens Ladisch wrote:
>>Brian Victor wrote:
>>> Monitoring /proc/asound/seq/queues shows the events being queued, but as
>>> soon as the queue starts, all 400 notes leave the queue instantly; none
>>> are played.

afaik, you should use snd_seq_event_output() instead of
snd_seq_event_output_direct() -- the latter is supposed
to by-pass the queue for instant transmission.

you may want to look at alsa-lib/test/playmidi1.c for
another reference.

>(Which begs another question: what does PPQ stand for?  Something per
>quarter?)

ticks/quarter (aka 'parts per quarter').

hth, tim



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
