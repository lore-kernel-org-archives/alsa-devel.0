From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Advice on using ALSA with callbacks?
Date: Wed, 28 Dec 2005 19:13:16 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0512281912160.9509@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0512281715520.11482@holly>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0512281715520.11482@holly>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dave Raggett <dsr@w3.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 28 Dec 2005, Dave Raggett wrote:

> The tutorials by Paul Davis are nice and clear, but unfortunately don't cover
> the use of call backs. Is there a relatively simple example program I could
> look at for what I need to do?
> 
> Any advice would be much appreciated.

My advice is to use poll() also for the audio data. It's not really 
required to use an asynchronous source for your application.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
