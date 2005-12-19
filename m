From: David Mulcahy <eseol@tiscali.co.uk>
Subject: Re: Real-world reports on two Delta 1010LTs/ice1712 synched?
Date: Mon, 19 Dec 2005 13:34:54 +0000
Message-ID: <200512191334.54471.eseol@tiscali.co.uk>
References: <43A5C630.7000704@findus.dhs.org> <20051218222543.GA4450@localhost.localdomain> <43A6A964.9030308@nostar.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <43A6A964.9030308@nostar.net>
Content-Disposition: inline
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: jackit-devel@lists.sourceforge.net
Cc: Doug McLain <doug@nostar.net>, John Rigg <j@sound-man.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 19 Dec 2005 12:36, Doug McLain wrote:
> John Rigg wrote:
> > There are a few things to be aware of. After it took me 2 months to get
> > two Delta 1010s working I put up a web page about it at
> >
> > http://www.sound-man.co.uk/linuxaudio/ice1712multi.html
>
> John,
>
> Great page! This website was great news for me, and I immediately stuck
> a 2nd delta into my machine today and went to it.
>
> I upgraded to kernel 2.6.14, added the privided .asoundrc to my
> /etc/asound.conf, applied the MMAP_COMPLEX patch to jack 100.7, applied
> the pcm_multi-patch to alsa-lib 1.0.10 and applied the envy24 patch.
>
> I am happy to say that seperate capture and playback of 16 tracks works
> wonderfully.  I'm using spdif-out of card 0 to spdif-in of card 1 for
> clocking at the moment, the recordings and playbacks sound perfect.  I
> tested by playing 8 tracks (4 out of each card, all i had was 1 8-way
> snake to test with atm) out of the delta's into a fostex G16 1/2" analog
> reel, then played back out of the reel, again into 4 tracks of each card
> and into ardour.  Everything seemed to be perfect, when running jack
> with -C or -P.  I use -R for both the captures tests (recording into
> ardour) and playback tests.
>
> When trying to run duplex via: jackd -d alsa -C multi_capture -P
> multi_playback (with or without -R), I get:
>
> jackd watchdog: timeout - killing jackd
> Aborted
>
> And jackd dies.  I did nm /usr/lib/libasound.so|grep
> snd_pcm_multi_link_fd to make sure that the patch applied correctly, and
> nothing was returned, so all looks good there.  Does anyone have any
> advice for me?
>
> Doug

Hi Doug 

Did you see this message. 

http://boudicca.tux.org/hypermail/jackit-devel/this-month/0063.html

It seems to indicate a working setup (albeit a different card).  I guess it 
might be worth giving it a try.

Dave


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
