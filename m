From: Laurent Georget <lgeorget2@club-internet.fr>
Subject: Re: possible ALSA bug/feature (was: important recording
 broke. why?) (fwd)
Date: Sat, 22 Mar 2003 22:43:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E7CD8F5.7030502@club-internet.fr>
References: <Pine.LNX.4.44.0303211610150.20651-100000@vaino.wakkanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I reported sometimes ago the same problem with alsa "level" and "ameter" 
plugins:
After 0.9rc7 , using these plugin fails ( EIO  )  , if buffer size is low.

There is now an additional checking in pcm_wait (pcm.c line 2017 ) , 
that came after 0.9rc7:
if (revents & (POLLERR | POLLNVAL))
		return -EIO;

Commenting out POLLER|  "solves" the problem .

As i am far from being a top developper, I wonder if this new checking 
is really needed,
and , if it is,  do you think that the error could be solved in the 
plugin code ?

Thanks

Laurent


Kai Vehmanen wrote:
> Hi,
> 
> first please read the mail to ecasound-list below. 
> 
> It seems that with newer ALSA versions, snd_pcm_read[in]()  sometimes
> returns -EIO even though documentation says nothing about this. After some
> testing this seems to not happen on direct hw-access, only with
> the pcm_plugin. The EIO comes from snd_pcm_wait(). 
> 
> Is this a bug or or a feature?
> 
> Btw; the error does not seem to be critical. If I handle
>      the EIO the same way as EPIPE (i.e. run xrun 
>      handling code), the recording will continue fine.
> 



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
