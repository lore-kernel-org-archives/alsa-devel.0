From: Sergei Steshenko <steshenko_sergei@list.ru>
Subject: Re: Revo 7.1 setup ?
Date: Sat, 3 Dec 2005 21:21:22 +0200
Message-ID: <20051203212122.13f4e6b5@athlon.home.net>
References: <1133636889.4274.7.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1133636889.4274.7.camel@rousalka.dyndns.org>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: nicolas.mailhot@laposte.net
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Have you played with settings using 'alsamixer' ?

I have never tried digital out, so I can't be more specific.

On Sat, 03 Dec 2005 20:08:03 +0100
Nicolas Mailhot <nicolas.mailhot@laposte.net> wrote:

> Hi,
> 
> I'm trying to setup a revo 7.1 in digital out mode (will do 5.1 analog
> whenever I receive Y cables).
> 
> After much googling the best asoundrc setting I found is :
> 
> pcm.!default {
>         type plug
>         slave.pcm "spdif"
> }
> 
> (no it's not in the wiki nor anywhere else, I had to merge two different
> suggestions in messages separated by months to get any sound on this
> card).
> 
> Problem is :
> 1. apps complain someone blocks accesses (probably means some dmixing is
> in order ?)
> 2. I'm hearing stuttering when I manage to kick esd from the card.
> 3. I don't seem able to control sound anywhere in the gnome mixer
> 
> Can anyone help me ? I've already spend hours on this, and I'm still not
> able to play a CD decently with what is supposed to be a well-supported
> alsa card.
> 
> 
> -- 
> Nicolas Mailhot


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
